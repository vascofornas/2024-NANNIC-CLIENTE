import 'dart:convert';
import 'dart:io';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/models/clinica_modelo.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/clinicas_screen.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/detalle_clinica_screen.dart';
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

class EditarClinicaContent extends StatefulWidget {
  const EditarClinicaContent({Key? key,  required this.clinicaId, required this.clinicaNombre, required this.clinicaEmail, required this.clinicaDireccion, required this.clinicaLogo, required this.clinicaPais, required this.clinicaTel}) : super(key: key);
  final String clinicaId;
  final String clinicaNombre;
  final String clinicaEmail;
  final String clinicaDireccion;
  final String clinicaLogo;
  final String clinicaPais;
  final String clinicaTel;

  @override
  State<EditarClinicaContent> createState() => _EditarClinicaContentState();
}

class _EditarClinicaContentState extends State<EditarClinicaContent> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _paisController = TextEditingController();
  late TextEditingController _direccionController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();

  String emailClinica = "";
  String nombreClinica = "";
  String direccionClinica = "";
  String telClinica = "";
  String paisClinica = "";

  late List<Clinica> clinicaActual ;

  Future<void> obtenerClinicasDatosClinica() async {
    String urlAPI =
        URLProyecto + APICarpeta + "admin_obtener_datos_clinica_actual.php?id="+widget.clinicaId!;
    final url = Uri.parse(urlAPI);
    final response = await http.get(url);


    if (response.statusCode == 200) {

      final List<dynamic> jsonResponse = json.decode(response.body);
      clinicaActual = jsonResponse.map((data) => Clinica.fromJson(data)).toList();

      setState(() {
        _nameController.text = clinicaActual[0].nombre_clinica!;
        _paisController.text = clinicaActual[0].pais_clinica!;
        _direccionController.text = clinicaActual[0].direccion_clinica!;
        _emailController.text = clinicaActual[0].email_clinica!;
        _phoneController.text = clinicaActual[0].tel_clinica!;

      });
    } else {
      throw Exception('Error al obtener las clinicas');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerClinicasDatosClinica();


  }





  bool validarFormatoEmail(String email) {
    // Expresión regular para verificar el formato de un email
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return regex.hasMatch(email);
  }


  Future<void> actualizarClinica() async {
     String url =
        URLProyecto + APICarpeta + "actualizar_datos_clinica.php?id="+widget.clinicaId!;

    //verificar que estan todos los campos
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _paisController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _direccionController.text.isEmpty) {
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
          'nombre_clinica': _nameController.text,
          'direccion_clinica': _direccionController.text,
          'tel_clinica': _phoneController.text,
          'email_clinica': _emailController.text,
          'pais_clinica': _paisController.text,
          'id': widget.clinicaId,

        },
      );

      if (response.statusCode == 200) {
        print("respuesta nuevo clinica ${response.body}");
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
            msg: "datoseditados".tr(),
            toastLength: Toast.LENGTH_LONG,
            fontSize: 18.0,
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetalleClinicaScreen(clinicaId: widget.clinicaId,clinicaDireccion: widget.clinicaDireccion,clinicaEmail: widget.clinicaEmail,clinicaLogo: widget.clinicaLogo,clinicaNombre: widget.clinicaNombre,clinicaPais: widget.clinicaPais,clinicaTel: widget.clinicaTel,)),
          );

        }

      }
    } catch (e) {}
  }

  @override
  void dispose() {
    _nameController.dispose();
    _direccionController.dispose();
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
                              SizedBox(
                                height:
                                appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),

                              //email clinica
                              Text('clinicaemail'.tr(),
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
                                hintText: 'clinicaemail'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),

                              //nombre clinica

                              Text('clinicanombre'.tr(),
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
                                hintText: 'clinicanombre'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              //direccion clinica
                              Text('clinicadireccion'.tr(),
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
                                controller: _direccionController,
                                hintText: 'clinicadireccion'.tr(),
                                obscureText: false,
                              ),
                             //pais clinica
                              SizedBox(
                                height:
                                appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              Text('clinicapais'.tr(),
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
                                controller: _paisController,
                                hintText: 'clinicapais'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              //tel clinica
                              Text('clinicatel'.tr(),
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
                                hintText: 'clinicatel'.tr(),
                                obscureText: false,
                              ),
                              SizedBox(
                                height:
                                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                              ),
                              MyButton(
                                onTap: actualizarClinica,
                                text: "actualizarcambios".tr(),
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
