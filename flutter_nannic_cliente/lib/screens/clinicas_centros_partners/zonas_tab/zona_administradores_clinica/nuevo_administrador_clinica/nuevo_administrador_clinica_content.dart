import 'dart:convert';
import 'dart:io';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/clinicas_screen.dart';
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

class NuevoAdministradorClinicaContent extends StatefulWidget {
  const NuevoAdministradorClinicaContent({Key? key, required this.clinicaId, required this.clinicaNombre}) : super(key: key);
  final String clinicaId;
  final String clinicaNombre;

  @override
  State<NuevoAdministradorClinicaContent> createState() => _NuevoAdministradorClinicaContentState();
}

class _NuevoAdministradorClinicaContentState extends State<NuevoAdministradorClinicaContent> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _lastNameController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();

  String emailUsuario = "";
  String nombreUsuario = "";
  String apellidosUsuario = "";
  String telUsuario = "";
  String imagenUsuario = "";
  String idUsuario = "";



  bool validarFormatoEmail(String email) {
    // Expresión regular para verificar el formato de un email
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return regex.hasMatch(email);
  }


  Future<void> registrarUsuario() async {
    const String url =
        URLProyecto + APICarpeta + "registrar_nuevo_administrador_clinica.php";

    //verificar que estan todos los campos
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _lastNameController.text.isEmpty) {
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
      final response = await http.post(
        Uri.parse(url),
        body: {
          'nombre': _nameController.text,
          'apellidos': _lastNameController.text,
          'tel': _phoneController.text,
          'email': _emailController.text,
          'id_clinica': widget.clinicaId,

        },
      );

      if (response.statusCode == 200) {

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
            msg: "datosactualizados".tr(),
            toastLength: Toast.LENGTH_LONG,
            fontSize: 18.0,
          );
          Navigator.of(context).pop();

        }

      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();

    super.dispose();
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
                              Center(
                                child: Text(widget.clinicaNombre,
                                    textAlign: TextAlign.center,
                                    style: AppFonts.nannic(
                                        color: Colors.grey,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height:
                                appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              Text('profesionalemail'.tr(),
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
                                hintText: 'profesionalemail'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),


                              Text('profesionalnombre'.tr(),
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
                                hintText: 'profesionalnombre'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              Text('profesionalapellido'.tr(),
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
                                hintText: 'profesionalapellido'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              Text('profesionaltel'.tr(),
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
                                hintText: 'profesionaltel'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              MyButton(
                                onTap: registrarUsuario,
                                text: "datosadminnuevo".tr(),
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
