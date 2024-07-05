import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_firma_commercial_purposes.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_firma_honor.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_firma_informed_consent.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_firma_privacy_policy.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_firma_scientific_research.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class SignaturePad extends StatefulWidget {

  final String tipoFirma;
  final String pacienteId;

  const SignaturePad({super.key, required this.tipoFirma, required this.pacienteId});
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
  //boton atras visibilidad
  bool verBackButton = true;

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

    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);

    //registramos firma de informed consent
    if(widget.tipoFirma == 'informed_consent'){
      String idPaciente = widget.pacienteId;

      registrarConsentimiento(idPaciente: idPaciente, firmaConsent: fileName, fechaFirmas: formattedDate);
    }
    //registramos firma de privacy policy
    if(widget.tipoFirma == 'privacy_policy'){
      String idPaciente = widget.pacienteId;

      registrarConsentimientoPrivacyPolicy(idPaciente: idPaciente, firmaConsent: fileName, fechaFirmas: formattedDate);
    }
    //registramos firma de scientific research
    if(widget.tipoFirma == 'scientific_research'){
      String idPaciente = widget.pacienteId;

      registrarConsentimientoScientificResearch(idPaciente: idPaciente, firmaConsent: fileName, fechaFirmas: formattedDate);
    }
    //registramos firma de commercial purposes
    if(widget.tipoFirma == 'commercial_purposes'){
      String idPaciente = widget.pacienteId;

      registrarConsentimientoCommercialPurposes(idPaciente: idPaciente, firmaConsent: fileName, fechaFirmas: formattedDate);
    }

    //registramos firma de honor
    if(widget.tipoFirma == 'honor'){
      String idPaciente = widget.pacienteId;

      registrarConsentimientoHonor(idPaciente: idPaciente, firmaConsent: fileName, fechaFirmas: formattedDate);
    }
    File file = File('$path/$fileName');
    await file.writeAsBytes(data);

    return file.path;
  }
  //publicar la firma

  Future<void> _uploadSignature(String filePath) async {
    setState(() {
      verBackButton = false;
    });
    verBackButton = false;
    var request = http.MultipartRequest('POST', Uri.parse(URLProyecto+APICarpeta+"guardar_firma_paciente.php"));
    request.files.add(await http.MultipartFile.fromPath('signature', filePath));

    var response = await request.send();
    if (response.statusCode == 200) {


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signature uploaded successfully')),
      );
      setState(() {
        verBackButton = true;
      });
      Navigator.of(context).pop();
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

    if(widget.tipoFirma == 'privacy_policy'){
      tipoFirma = "PrivacyPolicy".tr();
    }

    if(widget.tipoFirma == 'scientific_research'){
      tipoFirma = "ConsentforScientificResearch".tr();
    }

    if(widget.tipoFirma == 'commercial_purposes'){
      tipoFirma = "ConsentforCommercialPurposes".tr();
    }
    if(widget.tipoFirma == 'honor'){
      tipoFirma = "StatementonHonorofNoSymptoms/Abnormalities".tr();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:
        Visibility(
          visible: verBackButton,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black54), // Icono personalizado
            onPressed: () {
              Navigator.pop(context); // Acción personalizada, por ejemplo, regresar a la pantalla anterior
            },
          ),
        ),
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
