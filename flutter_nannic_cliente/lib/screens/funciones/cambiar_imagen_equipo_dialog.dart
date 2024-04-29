import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/components/my_textfield.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/screens/components/flutter_toast/flutter_toast_widget.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/equipo_from_url_grande.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';
import 'package:universal_html/html.dart' as html;


Future<dynamic> buildCambiarImagenEquipoDialog(BuildContext context,
    String? imagen,
    String? idEquipo) {
  return showDialog(
    context: context,
    builder: (context) {

      File? _image;
      String nombreEquipo = "";
      String nuevaImagen = "";

      final picker = ImagePicker();
      Future<void> uploadImageToServer(File imageFile) async {
        // URL del servidor donde se subirá la imagen
        var url = Uri.parse(URLProyecto + APICarpeta + 'publicar_equipo_nannic.php');

        // Crear una solicitud de tipo multipart para enviar la imagen
        var request = http.MultipartRequest('POST', url);
        var nombreArchivo = randomAlpha(12) + '.jpg';
        nombreEquipo = nombreArchivo;
        nuevaImagen = nombreEquipo;

        // Añadir la imagen al cuerpo de la solicitud
        request.files.add(
          http.MultipartFile(
            'file',
            imageFile.readAsBytes().asStream(),
            imageFile.lengthSync(),
            filename: nombreEquipo, // Nombre del archivo en el servidor
          ),
        );

        // Enviar la solicitud al servidor
        var response = await http.Response.fromStream(await request.send());

        // Verificar si la carga fue exitosa
        if (response.statusCode == 200) {
          print('Imagen cargada correctamente');

        } else {
          print('Error al cargar la imagen: ${response.reasonPhrase}');
        }
      }

      Future getImageFromCamera() async {
        final pickedFile = await picker.pickImage(source: ImageSource.camera);
        uploadImageToServer(
            _image!);


      }
      Future getImageFromGallery() async {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);


          if (pickedFile != null) {
            _image = File(pickedFile.path);
            uploadImageToServer(
                _image!); // Llamar a la función para cargar la imagen al servidor
          } else {
            print('No image selected.');
          }

      }
      Future<void> uploadImageToServerWeb(
          String fileName, html.Blob fileBlob) async {
        // Convertir el Blob en una lista de enteros
        var reader = html.FileReader();
        reader.readAsArrayBuffer(fileBlob);
        reader.onLoadEnd.listen((e) async {
          if (reader.readyState == html.FileReader.DONE) {
            List<int> bytes = List<int>.from(reader.result as List<int>);

            // URL del servidor donde se subirá la imagen
            var url = Uri.parse(URLProyecto + APICarpeta + 'publicar_equipo_nannic.php');

            // Crear una solicitud de tipo multipart para enviar la imagen
            var request = http.MultipartRequest('POST', url);
            var nombreArchivo = randomAlpha(12) + '.jpg';
            nombreEquipo = nombreArchivo;

            // Añadir la imagen al cuerpo de la solicitud
            request.files.add(
              http.MultipartFile.fromBytes(
                'file',
                bytes,
                filename: nombreEquipo, // Nombre del archivo en el servidor
              ),
            );

            // Enviar la solicitud al servidor
            var response = await http.Response.fromStream(await request.send());

            // Verificar si la carga fue exitosa
            if (response.statusCode == 200) {
              print('Imagen cargada correctamente');
              // actualizarAvatar(idUsuario + "_" + nombreArchivo);
            } else {
              print('Error al cargar la imagen: ${response.reasonPhrase}');
            }
          }
        });
      }
      Future<void> getImageFromFolder() async {
        final html.InputElement input = html.InputElement(type: 'file');
        input.accept = 'image/*';
        input.click();

        input.onChange.listen((event) {
          final files = input.files;
          if (files!.length == 1) {
            final file = files[0];
            final reader = html.FileReader();
            reader.readAsArrayBuffer(file);
            reader.onLoadEnd.listen((e) async {
              if (reader.readyState == html.FileReader.DONE) {
                final bytes = reader.result as List<int>;
                final blob = html.Blob([bytes]);
                final fileName = file.name;
                uploadImageToServerWeb(fileName, blob);
              }
            });
          }
        });
      }


      return AlertDialog(
        title:  Text(
          "cambiarimagendispo".tr(),
          style: AppFonts.nannic(
            color: Colors.black38,
            fontSize: 16,
            fontWeight: FontWeight.w800
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EquipoFromUrlGrande(
              imagenUsuario: imagen!,
            ),
            SizedBox(
              height:
              appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
            ),

            !kIsWeb
                ? Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                // Botón para seleccionar imagen desde la cámara
                ElevatedButton(
                  onPressed: getImageFromCamera,
                  child: MiTextoSimple(
                    color: Colors.grey,
                    fontsize: 14,
                    fontWeight: FontWeight.bold,
                    texto: 'camara'.tr(),

                  ),
                ),
                SizedBox(
                  width: 10,
                ),

                // Botón para seleccionar imagen desde la galería
                ElevatedButton(
                  onPressed:
                  getImageFromGallery,
                  child: MiTextoSimple(
                    color: Colors.grey,
                    fontsize: 14,
                    fontWeight: FontWeight.bold,
                    texto: 'galeria'.tr(),
                  ),
                ),
              ],
            )
                : SizedBox(
              height:
              appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
            ),

          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey,
            ),
            child: Text('cancelar'.tr(), style: AppFonts.nannic(
              color: Colors.black38,
              fontSize: 12,
              fontWeight: FontWeight.w800
            )),
          ),

          ElevatedButton(
            onPressed: () {
              print("pulsado cambiar imagen del equipo antes de cambiar nada");
              print("nombre de la nueva imagen ${nuevaImagen}");


            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
            ),
            child: Text('cambiarimagendispo'.tr(), style: AppFonts.nannic(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16
            )),
          )
          ,
        ],
      );
    },
  );
}