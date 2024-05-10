import 'dart:convert';
import 'dart:io';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
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

class PerfilContent extends StatefulWidget {
  const PerfilContent({Key? key}) : super(key: key);

  @override
  State<PerfilContent> createState() => _PerfilContentState();
}

class _PerfilContentState extends State<PerfilContent> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _lastNameController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();

  String emailUsuario = "";
  String nombreUsuario = "";
  String apellidosUsuario = "";
  String telUsuario = "";
  String imagenUsuario = "";
  String idUsuario = "";

  late Locale _selectedLocale;

  File? _image;

  final picker = ImagePicker();

  Future<void> actualizarAvatar(String nuevoNombre) async {
    const String url =
        URLProyecto + APICarpeta + "actualizar_datos_usuario_tres.php";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'imagen': nuevoNombre, 'id': idUsuario},
      );

      if (response.statusCode == 200) {

        Fluttertoast.showToast(
          msg: "datosactualizados".tr(),
          toastLength: Toast.LENGTH_LONG,
          fontSize: 18.0,
        );


        SharedPrefsHelper.setFoto(nuevoNombre);

        // Agrega setState aquí para reconstruir los widgets dependientes
        setState(() {
          capturarDatosUsuario();
        });
      }
    } catch (e) {}
  }

  Future<void> actualizarCampos() async {
    const String url =
        URLProyecto + APICarpeta + "actualizar_datos_usuario_dos.php";

    if (_nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _lastNameController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text("faltandatos".tr()),
        ),
      );
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'nombre': _nameController.text,
          'apellidos': _lastNameController.text,
          'tel': _phoneController.text,
          'imagen': imagenUsuario,
          'id': idUsuario
        },
      );

      if (response.statusCode == 200) {

        Fluttertoast.showToast(
          msg: "datosactualizados".tr(),
          toastLength: Toast.LENGTH_LONG,
          fontSize: 18.0,
        );
        //actualizamos shared preferences
        SharedPrefsHelper.setNombre(_nameController.text);
        SharedPrefsHelper.setApellidos(_lastNameController.text);
        SharedPrefsHelper.setTel(_phoneController.text);
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  Future<void> _init() async {
    final locale = EasyLocalization.of(context)?.locale;
    if (locale != null) {
      _selectedLocale = locale;
      setState(() {}); // Notificar a Flutter que el estado ha cambiado
    }
    capturarDatosUsuario();
  }

  void capturarDatosUsuario() async {
    DatosUsuario datos = await obtenerDatosUsuario();

    emailUsuario = datos.email;
    nombreUsuario = datos.nombre;
    apellidosUsuario = datos.apellidos;
    _nameController.text = nombreUsuario;
    _lastNameController.text = apellidosUsuario;

    imagenUsuario = datos.imagen;

    telUsuario = datos.tel;
    _phoneController.text = telUsuario;

    idUsuario = datos.id;
    setState(() {
      //no quitar este
    });
  }

  Future<void> uploadImageToServer(File imageFile) async {
    // URL del servidor donde se subirá la imagen
    var url = Uri.parse(URLProyecto + APICarpeta + 'publicar_avatar.php');

    // Crear una solicitud de tipo multipart para enviar la imagen
    var request = http.MultipartRequest('POST', url);
    var nombreArchivo = randomAlpha(12) + '.jpg';

    // Añadir la imagen al cuerpo de la solicitud
    request.files.add(
      http.MultipartFile(
        'file',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: idUsuario +
            "_" +
            nombreArchivo, // Nombre del archivo en el servidor
      ),
    );

    // Enviar la solicitud al servidor
    var response = await http.Response.fromStream(await request.send());

    // Verificar si la carga fue exitosa
    if (response.statusCode == 200) {

      actualizarAvatar(idUsuario + "_" + nombreArchivo);
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
        var url = Uri.parse(URLProyecto + APICarpeta + 'publicar_avatar.php');

        // Crear una solicitud de tipo multipart para enviar la imagen
        var request = http.MultipartRequest('POST', url);
        var nombreArchivo = randomAlpha(12) + '.jpg';

        // Añadir la imagen al cuerpo de la solicitud
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            bytes,
            filename: idUsuario +
                "_" +
                nombreArchivo, // Nombre del archivo en el servidor
          ),
        );

        // Enviar la solicitud al servidor
        var response = await http.Response.fromStream(await request.send());

        // Verificar si la carga fue exitosa
        if (response.statusCode == 200) {
          print('Imagen cargada correctamente');
          actualizarAvatar(idUsuario + "_" + nombreArchivo);
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
            CustomAppbar(
              titulo: 'perfilusuario'.tr(),
            ), // Widget de barra de aplicación personalizada
            SizedBox(
              height:
                  appPadding, // Espacio adicional entre la barra de aplicación y el contenido
            ),
            Column(
              children: [
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
                              Text('miavatar'.tr(),
                                  textAlign: TextAlign.center,
                                  style: AppFonts.nannic(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      // Mostrar la imagen seleccionada (si existe)
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
                                      Row(
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
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              Text('nombre'.tr(),
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
                                hintText: 'nombre'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              Text('apellido'.tr(),
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
                                controller: _lastNameController,
                                hintText: 'apellido'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              Text('tel'.tr(),
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
                                hintText: 'tel'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              MyButton(
                                onTap: actualizarCampos,
                                text: "actualizarcambios".tr(),
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              CambiarIdioma(context),
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

  Center CambiarIdioma(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Cambiar al idioma inglés
              setState(() {
                _selectedLocale = Locale('en', 'EN');
              });
              context.setLocale(_selectedLocale);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: _selectedLocale.languageCode == 'en' ?Colors.white:Colors.grey,
              backgroundColor: _selectedLocale.languageCode == 'en' ? Colors.blueGrey : null, // Color verde si está seleccionado
            ),
            child: Text('English',
              style: AppFonts.nannic(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),),
          ),
          SizedBox(width: 20,),

          ElevatedButton(
            onPressed: () {
              // Cambiar al idioma holandés
              setState(() {
                _selectedLocale = Locale('nl', 'NL');
              });
              context.setLocale(_selectedLocale);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: _selectedLocale.languageCode == 'nl' ?Colors.white:Colors.grey,
              backgroundColor: _selectedLocale.languageCode == 'nl' ? Colors.blueGrey : null, // Color verde si está seleccionado
            ),
            child: Text('Dutch',
                style: AppFonts.nannic(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                )),
          ),
          SizedBox(width: 20,),
          ElevatedButton(
            onPressed: () {
              // Cambiar al idioma sueco
              setState(() {
                _selectedLocale = Locale('sv', 'SV');
              });
              context.setLocale(_selectedLocale);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: _selectedLocale.languageCode == 'sv' ?Colors.white:Colors.grey,
              backgroundColor: _selectedLocale.languageCode == 'sv' ? Colors.blueGrey : null, // Color verde si está seleccionado
            ),
            child: Text('Svenska',
                style: AppFonts.nannic(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                )),
          ),
        ],
      ),
    );
  }
}
