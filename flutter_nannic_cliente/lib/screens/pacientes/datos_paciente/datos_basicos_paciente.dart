import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/paciente_datos_basicos_modelo.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';
import 'package:universal_html/html.dart' as html;

class DatosBasicosPaciente extends StatefulWidget {
  const DatosBasicosPaciente({super.key, required this.paciente});
  final Paciente paciente;

  @override
  State<DatosBasicosPaciente> createState() => _DatosBasicosPacienteState();
}

class _DatosBasicosPacienteState extends State<DatosBasicosPaciente> {
  // URL base del servidor
  String baseUrl = URLProyecto + APICarpeta + "pacientes/";
  String baseUrlImagen = "";

  //capturar nueva imagen del paciente

  File? _imageFile;

  final ImagePicker _picker = ImagePicker();
  String nombreArchivo = "";
  String nombrePaciente = "";
  String emailPaciente = "";
  String telPaciente = "";




  //otros datos basicos

  String _direccion = "direccionpacientedesc".tr();
  String _genero = "generopacientedesc".tr();
  String _idioma = "idiomapacientedesc".tr();
  String _fecha_nacimiento = "fnpacientedesc".tr();

  String formatDate(String date) {
    // Convierte la fecha de yyyy-MM-dd a dd-MM-yyyy
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  }


  Future<void> actualizarImagenPaciente(String laNuevaImagen) async {
    const String url =
        URLProyecto + APICarpeta + "actualizar_imagen_paciente.php";

    print("nueva imagen usuario en actualizarImagenPaciente ${laNuevaImagen}");




    try {



      final response = await http.post(
        Uri.parse(url),
        body: {


          'imagen_paciente': laNuevaImagen,
          'id': widget.paciente.id_paciente


        },
      );


      if (response.statusCode == 200) {









        Fluttertoast.showToast(
          msg: "datospacienteactualizados".tr(),
          toastLength: Toast.LENGTH_LONG,
          fontSize: 18.0,
        );



      }
    } catch (e) {}
  }

  Future<void> uploadImageToServer(File imageFile) async {
    // URL del servidor donde se subirá la imagen
    var url = Uri.parse(URLProyecto + APICarpeta + 'publicar_avatar_paciente.php');

    // Crear una solicitud de tipo multipart para enviar la imagen
    var request = http.MultipartRequest('POST', url);
     nombreArchivo = randomAlpha(12) + '.jpg';

    // Añadir la imagen al cuerpo de la solicitud
    request.files.add(
      http.MultipartFile(
        'file',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename:
        nombreArchivo, // Nombre del archivo en el servidor
      ),
    );

    // Enviar la solicitud al servidor
    var response = await http.Response.fromStream(await request.send());

    // Verificar si la carga fue exitosa
    if (response.statusCode == 200) {
      print("nombre archivo ${nombreArchivo}");



        // URL completa de la imagen del paciente
        baseUrlImagen = baseUrl + nombreArchivo!;
        setState(() {

        });

        print("estoy en terminada subida true");








    } else {

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
        var url = Uri.parse(URLProyecto + APICarpeta + 'publicar_avatar_paciente.php');

        // Crear una solicitud de tipo multipart para enviar la imagen
        var request = http.MultipartRequest('POST', url);
        nombreArchivo = randomAlpha(12) + '.jpg';

        // Añadir la imagen al cuerpo de la solicitud
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            bytes,
            filename:
            nombreArchivo, // Nombre del archivo en el servidor
          ),
        );

        // Enviar la solicitud al servidor
        var response = await http.Response.fromStream(await request.send());

        // Verificar si la carga fue exitosa
        if (response.statusCode == 200) {
          print('Imagen cargada correctamente');


            baseUrlImagen = baseUrl + nombreArchivo!;
            setState(() {

            });

            print("estoy en terminada subida true");



        } else {
          print('Error al cargar la imagen: ${response.reasonPhrase}');
        }
      }
    });
  }

  Future<void> _showImagePickerDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('seleccionarnuevaimagenpaciente'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('camara'.tr()),
                onTap: () async {
                  final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                      uploadImageToServer(
                          _imageFile!); // Llamar a la función para cargar la imagen al servidor
                    });
                  }
                  Navigator.of(context).pop();
                  _showImagePreviewDialog(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('galeria'.tr()),
                onTap: () async {
                  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                      uploadImageToServer(
                          _imageFile!); // Llamar a la función para cargar la imagen al servidor
                    });
                  }
                  Navigator.of(context).pop();
                  _showImagePreviewDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showImagePreviewDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('vistapreviaimagenpaciente'.tr()),
          content: _imageFile != null
              ? Image.file(_imageFile!)
              : Text('No se seleccionó ninguna imagen'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('cancelar'.tr()),
            ),
           TextButton(
              onPressed: (){
                // Aquí puedes agregar la lógica para guardar la imagen del paciente
                // Por ejemplo, puedes enviar la imagen al servidor



                 actualizarImagenPaciente(nombreArchivo);




                Navigator.of(context).pop();
              },
              child: Text('cambiarimagenpaciente'.tr()),
            )
          ],
        );
      },
    );
  }

  Future<PacienteDatosBasicos?> fetchPacienteDatosBasicos(
      String idPaciente) async {
    final url = URLProyecto +
        APICarpeta +
        "obtener_datos_basicos_paciente_clinica.php"; // URL de tu script PHP

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'id_paciente': idPaciente}, // Parámetros enviados al script PHP
      );

      if (response.statusCode == 200) {
        // Si la solicitud es exitosa, decodifica la respuesta JSON
        final parsed = json.decode(response.body);
        return PacienteDatosBasicos.fromJson(parsed);
      } else {
        // Si la solicitud falla, lanza una excepción
        throw Exception('Error al cargar los datos del paciente');
      }
    } catch (e) {
      // Manejo de errores
      print('Error: $e');
      return null;
    }
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

  void mostrarDialogoCambiarNombre(BuildContext context) {
    String nuevoNombre = ''; // Variable para almacenar el nuevo nombre del paciente

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('cambiarnombrepaciente'.tr()),
          content: TextField(
            onChanged: (value) {
              nuevoNombre = value; // Actualiza el nuevo nombre a medida que el usuario escribe en el TextField
            },
            decoration: InputDecoration(hintText: 'nuevonombrepaciente'.tr()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el AlertDialog sin hacer cambios
              },
              child: Text('cancelar'.tr()),
            ),
            TextButton(
              onPressed: () {
                // Llama a la función para enviar el nuevo nombre del paciente al servidor
                enviarNuevoNombrePaciente(nuevoNombre);
                Navigator.of(context).pop(); // Cierra el AlertDialog después de aceptar los cambios
              },
              child: Text('cambiarnombrepaciente'.tr()),
            ),
          ],
        );
      },
    );
  }


  Future<void> enviarNuevoNombrePaciente(String nuevoNombre) async {
    // URL del script PHP para actualizar el nombre del paciente en la base de datos
    String url = URLProyecto+APICarpeta+"actualizar_nombre_paciente.php";
    print("nuevo nombre del paciente ${nuevoNombre} id_paciente ${widget.paciente.id_paciente}");

    // Datos a enviar al servidor (id_paciente y nuevo nombre del paciente)
    Map<String, String> datos = {
      'id_paciente': widget.paciente.id_paciente!, // Id del paciente a actualizar
      'nombre_paciente': nuevoNombre // Nuevo nombre del paciente
    };

    try {
      // Realiza la solicitud POST al script PHP con los datos del nuevo nombre
      http.Response respuesta = await http.post(Uri.parse(url), body: datos);

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (respuesta.statusCode == 200) {
        print('Nombre del paciente actualizado correctamente.');
        setState(() {
          nombrePaciente = nuevoNombre;
        });
      } else {
        print('Error al actualizar el nombre del paciente: ${respuesta.statusCode}');
      }
    } catch (error) {
      print('Error al enviar el nuevo nombre del paciente: $error');
    }
  }


  void mostrarDialogoCambiarEmail(BuildContext context) {
    String nuevoEmail = ''; // Variable para almacenar el nuevo nombre del paciente

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('cambiaremailpaciente'.tr()),
          content: TextField(
            onChanged: (value) {
              nuevoEmail = value; // Actualiza el nuevo nombre a medida que el usuario escribe en el TextField
            },
            decoration: InputDecoration(hintText: 'nuevoemailpaciente'.tr()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el AlertDialog sin hacer cambios
              },
              child: Text('cancelar'.tr()),
            ),
            TextButton(
              onPressed: () {
                // Llama a la función para enviar el nuevo nombre del paciente al servidor
                enviarNuevoEmailPaciente(nuevoEmail);
                Navigator.of(context).pop(); // Cierra el AlertDialog después de aceptar los cambios
              },
              child: Text('cambiaremailpaciente'.tr()),
            ),
          ],
        );
      },
    );
  }


  Future<void> enviarNuevoEmailPaciente(String nuevoEmail) async {
    // URL del script PHP para actualizar el nombre del paciente en la base de datos
    String url = URLProyecto+APICarpeta+"actualizar_email_paciente.php";
    print("nuevo email del paciente ${nuevoEmail} id_paciente ${widget.paciente.id_paciente}");

    // Datos a enviar al servidor (id_paciente y nuevo nombre del paciente)
    Map<String, String> datos = {
      'id_paciente': widget.paciente.id_paciente!, // Id del paciente a actualizar
      'email_paciente': nuevoEmail // Nuevo nombre del paciente
    };

    try {
      // Realiza la solicitud POST al script PHP con los datos del nuevo nombre
      http.Response respuesta = await http.post(Uri.parse(url), body: datos);

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (respuesta.statusCode == 200) {
        print('email del paciente actualizado correctamente.');
        setState(() {
          emailPaciente = nuevoEmail;
        });
      } else {
        print('Error al actualizar el nombre del paciente: ${respuesta.statusCode}');
      }
    } catch (error) {
      print('Error al enviar el nuevo nombre del paciente: $error');
    }
  }

  void mostrarDialogoCambiarTel(BuildContext context) {
    String nuevoTel = ''; // Variable para almacenar el nuevo nombre del paciente

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('cambiartelpaciente'.tr()),
          content: TextField(
            onChanged: (value) {
              nuevoTel = value; // Actualiza el nuevo nombre a medida que el usuario escribe en el TextField
            },
            decoration: InputDecoration(hintText: 'nuevotelpaciente'.tr()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el AlertDialog sin hacer cambios
              },
              child: Text('cancelar'.tr()),
            ),
            TextButton(
              onPressed: () {
                // Llama a la función para enviar el nuevo nombre del paciente al servidor
                enviarNuevoTelPaciente(nuevoTel);
                Navigator.of(context).pop(); // Cierra el AlertDialog después de aceptar los cambios
              },
              child: Text('cambiartelpaciente'.tr()),
            ),
          ],
        );
      },
    );
  }


  Future<void> enviarNuevoTelPaciente(String nuevoTel) async {
    // URL del script PHP para actualizar el nombre del paciente en la base de datos
    String url = URLProyecto+APICarpeta+"actualizar_tel_paciente.php";
    print("nuevo tel del paciente ${nuevoTel} id_paciente ${widget.paciente.id_paciente}");

    // Datos a enviar al servidor (id_paciente y nuevo nombre del paciente)
    Map<String, String> datos = {
      'id_paciente': widget.paciente.id_paciente!, // Id del paciente a actualizar
      'tel_paciente': nuevoTel // Nuevo nombre del paciente
    };

    try {
      // Realiza la solicitud POST al script PHP con los datos del nuevo nombre
      http.Response respuesta = await http.post(Uri.parse(url), body: datos);

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (respuesta.statusCode == 200) {
        print('email del paciente actualizado correctamente.');
        setState(() {
          telPaciente = nuevoTel;
        });
      } else {
        print('Error al actualizar el tel del paciente: ${respuesta.statusCode}');
      }
    } catch (error) {
      print('Error al enviar el nuevo tel del paciente: $error');
    }
  }


  @override
  void initState() {
    super.initState();
    // URL completa de la imagen del paciente
    baseUrlImagen = baseUrl + widget.paciente.imagen_paciente!;
    nombrePaciente = widget.paciente.nombre!;
    emailPaciente = widget.paciente.email_paciente!;
    telPaciente = widget.paciente.tel_paciente!;


    fetchPacienteDatosBasicos(widget.paciente.id_paciente!)
        .then((pacienteDatosBasicos) {
      if (pacienteDatosBasicos == null) {
      } else {
        // Procesar los datos del paciente normalmente
        setState(() {
          _direccion = pacienteDatosBasicos.direccion!;
          _genero = pacienteDatosBasicos.genero!;
          _idioma = pacienteDatosBasicos.idioma!;
          _fecha_nacimiento = pacienteDatosBasicos.fecha_nacimiento!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(appPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appPadding),
                  if (widget.paciente.imagen_paciente != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none, // Permite que los hijos del Stack se desborden
                          children: [
                            Container(
                              width: 200,
                              height: 300,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey, // Color del borde
                                  width: 2.0, // Ancho del borde
                                ),
                                borderRadius: BorderRadius.circular(8.0), // Bordes redondeados (opcional)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0), // Asegura que la imagen se recorte según el borde redondeado
                                child: Image.network(
                                  baseUrlImagen,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Text(
                                        'Error al cargar la imagen',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -15, // Ajusta este valor para mover el icono hacia afuera verticalmente
                              right: -15,  // Ajusta este valor para mover el icono hacia afuera horizontalmente
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black54, // Fondo del icono
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Acción al presionar el botón del icono
                                    _showImagePickerDialog(context);
                                  },
                                  icon: Icon(Icons.camera_enhance_outlined),
                                  color: Colors.white, // Color del icono
                                  iconSize: 30, // Tamaño del icono
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),



                  SizedBox(height: appPadding),
                  // Nombre del paciente
                  Row(
                    children: [
                      _buildInfoRow(Icons.person, nombrePaciente),
                      Spacer(),
                      IconButton(onPressed: (){
                        mostrarDialogoCambiarNombre(context);

                      }, icon: Icon(Icons.edit))
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // Email del paciente
                  Row(
                    children: [
                      _buildInfoRow(Icons.alternate_email_sharp,
                          emailPaciente),
                      Spacer(),
                      IconButton(onPressed: (){
                        mostrarDialogoCambiarEmail(context);

                      }, icon: Icon(Icons.edit))
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // Teléfono del paciente
                  Row(
                    children: [
                      _buildInfoRow(Icons.phone,telPaciente),
                      Spacer(),
                      IconButton(onPressed: (){
                        mostrarDialogoCambiarTel(context);

                      }, icon: Icon(Icons.edit))
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // Fecha de alta del paciente
                  _buildInfoRow(Icons.calendar_today,
                      formatDate(widget.paciente.fecha_alta!)),
                  SizedBox(height: appPadding),
                  // Dirección del paciente
                  _buildInfoRow(Icons.pin_drop_rounded, _direccion),
                  SizedBox(height: appPadding),
                  // Genero del paciente
                  _buildInfoRow(Icons.transgender, _genero),
                  SizedBox(height: appPadding),
                  // Idioma del paciente
                  _buildInfoRow(Icons.language, _idioma),
                  SizedBox(height: appPadding),
                  // fEcha de nacimiento del paciente
                  _buildInfoRow(Icons.date_range, _fecha_nacimiento),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Método helper para construir una fila de información
  Widget _buildInfoRow(IconData icon, String? info) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: appPadding),
        MiTextoSimple(
          texto: info ?? 'Información no disponible',
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontsize: 14,
        ),
      ],
    );
  }
}

class MiTextoSimple extends StatelessWidget {
  final String texto;
  final Color color;
  final FontWeight fontWeight;
  final double fontsize;

  const MiTextoSimple({
    required this.texto,
    required this.color,
    required this.fontWeight,
    required this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontsize,
      ),
    );
  }
}
