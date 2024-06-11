import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class SignaturePad extends StatefulWidget {

  final String tipoFirma;

  const SignaturePad({super.key, required this.tipoFirma});
  @override
  _SignaturePadState createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  String tipoFirma ="";

  //guardar la firma

  Future<String> _saveSignature() async {
    if (_controller.isEmpty) {
      return '';
    }

    var data = await _controller.toPngBytes();
    if (data == null) {
      return '';
    }

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    String fileName = 'signature_${DateTime.now().millisecondsSinceEpoch}.png';
    print("nombre del archivo con la firma ${fileName}");
    File file = File('$path/$fileName');
    await file.writeAsBytes(data);

    return file.path;
  }
  //publicar la firma

  Future<void> _uploadSignature(String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse(URLProyecto+APICarpeta+"guardar_firma_paciente.php"));
    request.files.add(await http.MultipartFile.fromPath('signature', filePath));

    var response = await request.send();
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signature uploaded successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload signature')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.tipoFirma == 'informed_consent'){
      tipoFirma = "InformedConsentforTreatment".tr();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("SignaturePad".tr(),style: AppFonts.nannic(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          SizedBox(height: appPadding,),
          Text(tipoFirma,style: AppFonts.nannic(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.bold),),
          SizedBox(height: appPadding,),
          Signature(
            controller: _controller,
            backgroundColor: Colors.grey[200]!,
            height: 300,
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (_controller.isNotEmpty) {
                    var data = await _controller.toPngBytes();
                    if (data != null) {
                      // Aquí puedes guardar la imagen en una base de datos o en la memoria del dispositivo.
                      print('Signature saved');
                      print("firma guardada ${data}");
                      String filePath = await _saveSignature();
                      if (filePath.isNotEmpty) {
                        await _uploadSignature(filePath);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No signature to save')),
                        );
                      }
                    }
                  }
                },
                child: Text('SignatureSave'.tr(),style: AppFonts.nannic(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 14),),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.clear();
                },
                child:
                Text('SignatureClear'.tr(),style: AppFonts.nannic(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 14),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
