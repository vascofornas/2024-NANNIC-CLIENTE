import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/pacientes_screen.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesionales_screen.dart';
import 'package:universal_html/html.dart' as html;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_button.dart';
import 'package:flutter_nannic_cliente/components/my_textfield.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/components/analytic_cards.dart';
import 'package:flutter_nannic_cliente/screens/components/custom_appbar/custom_appbar.dart';
import 'package:flutter_nannic_cliente/screens/components/discussions.dart';
import 'package:flutter_nannic_cliente/screens/components/flutter_toast/flutter_toast_widget.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url_grande.dart';
import 'package:flutter_nannic_cliente/screens/components/top_referals.dart';
import 'package:flutter_nannic_cliente/screens/components/users.dart';
import 'package:flutter_nannic_cliente/screens/components/users_by_device.dart';
import 'package:flutter_nannic_cliente/screens/components/viewers.dart';
import 'package:flutter_nannic_cliente/screens/dashboard/dash_board_screen.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class EditarPacienteContent extends StatefulWidget {
  const EditarPacienteContent({Key? key, required this.paciente, }) : super(key: key);

  final Paciente paciente;


  @override
  State<EditarPacienteContent> createState() => _EditarPacienteContentState();
}

class _EditarPacienteContentState extends State<EditarPacienteContent> {
  late TextEditingController _nameController = TextEditingController();

  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();

  String emailUsuario = "";
  String nombreUsuario = "";

  String telUsuario = "";
  String imagenUsuario = "paciente.jpg";
  String idUsuario = "";

  //para la imagen del paciente
  File? _image;

  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   cargarDatosActualesPaciente();
  }

  cargarDatosActualesPaciente(){

    if (mounted){
      imagenUsuario = widget.paciente.imagen_paciente!;
      nombreUsuario = widget.paciente.nombre!;
      _nameController.text = nombreUsuario;

      telUsuario = widget.paciente.tel_paciente!;
      _phoneController.text = telUsuario;
      emailUsuario = widget.paciente.email_paciente!;
      _emailController.text = emailUsuario;
      idUsuario = widget.paciente.id_paciente!;

    }

  }


  bool validarFormatoEmail(String email) {
    // Expresión regular para verificar el formato de un email
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return regex.hasMatch(email);
  }




  Future<void> registrarCambiosPaciente() async {
    const String url =
        URLProyecto + APICarpeta + "actualizar_datos_paciente.php";

    //verificar que estan todos los campos
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text("faltandatos".tr()),
        ),
      );
      return; // Detener la ejecución si faltan datos

    }
    var emailValido = validarFormatoEmail(_emailController.text);
    if(!emailValido){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text("formatoemailnovalido".tr()),
        ),
      );
      return; // Detener la ejecución si el formato del email no es válido
    }

    try {
      print("nombre paciente ${_nameController.text}");
      print("email paciente ${_emailController.text}");
      print("tel paciente ${_phoneController.text}");
      print("imagen paciente ${imagenUsuario}");


      final response = await http.post(
        Uri.parse(url),
        body: {

          'nombre': _nameController.text,

          'tel_paciente': _phoneController.text,
          'email_paciente': _emailController.text,
          'imagen_paciente': imagenUsuario,
          'id': widget.paciente.id_paciente


        },
      );
      print("respuesta1 servidor ${response.body}");

      if (response.statusCode == 200) {
        print("respuesta2 servidor ${response.body}");

        if(response.body == "Email existente"){
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: Text("emailyaexiste".tr()),
            ),
          );
        }
        else {
          Fluttertoast.showToast(
            msg: "datospacienteactualizados".tr(),
            toastLength: Toast.LENGTH_LONG,
            fontSize: 18.0,
          );
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  PacientesScreen( )),
          );
        }

      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();

    super.dispose();
  }





  Future<void> uploadImageToServer(File imageFile) async {
    // URL del servidor donde se subirá la imagen
    var url = Uri.parse(URLProyecto + APICarpeta + 'publicar_avatar_paciente.php');

    // Crear una solicitud de tipo multipart para enviar la imagen
    var request = http.MultipartRequest('POST', url);
    var nombreArchivo = randomAlpha(12) + '.jpg';

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
      imagenUsuario = nombreArchivo;


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
        var nombreArchivo = randomAlpha(12) + '.jpg';

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
          imagenUsuario = nombreArchivo;

        } else {
          print('Error al cargar la imagen: ${response.reasonPhrase}');
        }
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImageToServer(
            _image!); // Llamar a la función para cargar la imagen al servidor
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadImageToServer(
            _image!); // Llamar a la función para cargar la imagen al servidor
      } else {
        print('No image selected.');
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


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(
            appPadding), // Añade un espacio de padding alrededor del contenido
        child: Column(
          children: [
            // Widget de barra de aplicación personalizada
            SizedBox(
              height:
                  appPadding, // Espacio adicional entre la barra de aplicación y el contenido
            ),
            //capturar imagen del profesional

            Column(
              children: [
                //imagen del paciente

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        //imagaen actual del paciente
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('imagenactualpaciente'.tr(),
                                textAlign: TextAlign.center,
                                style: AppFonts.nannic(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                          height:
                          appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                        ),

                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(URLProyecto+APICarpeta+"pacientes/${widget.paciente.imagen_paciente}")
                            )
                          ),
                        ),
                        // Mostrar la imagen seleccionada (si existe)
                        SizedBox(
                          height:
                          appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('nuevaimagenpaciente'.tr(),
                                textAlign: TextAlign.center,
                                style: AppFonts.nannic(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                          height:
                          appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                        ),
                        if (_image != null)
                          Image.file(
                            _image!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        else
                        // Mostrar la imagen de usuario actual
                          AvatarFromUrlGrande(
                            imagenUsuario: imagenUsuario,
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
                        Visibility(
                          visible: false,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              // Botón para seleccionar imagen desde la cámara
                              ElevatedButton(
                                onPressed: getImageFromFolder,
                                child: MiTextoSimple(
                                  color: Colors.grey,
                                  fontsize: 14,
                                  fontWeight: FontWeight.bold,
                                  texto: 'cambiarimagenperfil'.tr(),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Primera fila de widgets
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          SizedBox(
                            height:
                                appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              Text('pacienteemail'.tr(),
                                  textAlign: TextAlign.center,
                                  style: AppFonts.nannic(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height:
                                appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              MyTextField(
                                controller: _emailController,
                                hintText: 'pacienteemail'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),


                              Text('pacientenombre'.tr(),
                                  textAlign: TextAlign.center,
                                  style: AppFonts.nannic(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              MyTextField(
                                controller: _nameController,
                                hintText: 'pacientenombre'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),

                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              Text('pacientetel'.tr(),
                                  textAlign: TextAlign.center,
                                  style: AppFonts.nannic(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              MyTextField(
                                controller: _phoneController,
                                hintText: 'pacientetel'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              MyButton(
                                onTap: registrarCambiosPaciente,
                                text: "pacienteeditado".tr(),
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),

                            ],
                          ),

                          // Espacio adicional si el dispositivo es móvil y se muestra la sección de discusiones
                          if (Responsive.isMobile(context))
                            SizedBox(
                              height: appPadding,
                            ),

                        ],
                      ),
                    ),
                    // Espacio adicional si el dispositivo no es móvil
                    if (!Responsive.isMobile(context))
                      SizedBox(
                        width: appPadding,
                      ),

                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

}
