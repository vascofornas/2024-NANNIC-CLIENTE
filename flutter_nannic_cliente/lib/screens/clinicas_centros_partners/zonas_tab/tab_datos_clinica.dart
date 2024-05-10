import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/clinica_modelo.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/nueva_clinica_content.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/edit_clinica/editar_clinica_screen.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/perfil/perfil_content.dart';
import 'package:flutter_nannic_cliente/screens/plantilla/plantilla_content.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_content.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

class TabDatosClinica extends StatefulWidget {

  const TabDatosClinica({Key? key, required this.clinicaId, required this.clinicaNombre, required this.clinicaEmail, required this.clinicaDireccion, required this.clinicaLogo, required this.clinicaPais, required this.clinicaTel}) : super(key: key);
  final String clinicaId;

  final String clinicaNombre;
  final String clinicaEmail;
  final String clinicaDireccion;
  final String clinicaLogo;
  final String clinicaPais;
  final String clinicaTel;


  @override
  State<TabDatosClinica> createState() => _TabDatosClinicaState();
}

class _TabDatosClinicaState extends State<TabDatosClinica> {
  late String emailUsuario = "";
  late List<Clinica> clinicaActual ;

  String emailClinica = "";
  String nombreClinica = "";
  String direccionClinica = "";
  String telClinica = "";
  String paisClinica = "";
  String logoClinica = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    capturarDatosUsuario();
    obtenerClinicasDatosClinica();
  }
  Future<void> obtenerClinicasDatosClinica() async {
    String urlAPI =
        URLProyecto + APICarpeta + "admin_obtener_datos_clinica_actual.php?id="+widget.clinicaId!;
    final url = Uri.parse(urlAPI);
    final response = await http.get(url);


    if (response.statusCode == 200) {

      final List<dynamic> jsonResponse = json.decode(response.body);
      clinicaActual = jsonResponse.map((data) => Clinica.fromJson(data)).toList();

      setState(() {
        emailClinica = clinicaActual[0].nombre_clinica!;
        paisClinica = clinicaActual[0].pais_clinica!;
        direccionClinica = clinicaActual[0].direccion_clinica!;
        emailClinica = clinicaActual[0].email_clinica!;
        telClinica = clinicaActual[0].tel_clinica!;
        logoClinica = clinicaActual[0].logo_clinica!;
        nombreClinica = clinicaActual[0].nombre_clinica!;

      });
      setState(() {
        obtenerClinicasDatosClinica();

      });
    } else {
      throw Exception('Error al obtener las clinicas');
    }
  }

  void capturarDatosUsuario() async {
    DatosUsuario datos = await obtenerDatosUsuario();

    emailUsuario = datos.email;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,

          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: appPadding,),
                    //logo y nombre clinica
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AvatarFromUrl(
                          imageUrl:
                          '${carpetaAdminClinicas}${logoClinica ?? ''}',
                          size: 60,
                        ),
                        SizedBox(width: appPadding,),
                        MiTextoSimple(texto: nombreClinica, color: Colors.grey, fontWeight: FontWeight.w800, fontsize: 18)

                      ],
                    ),

                    //direccion clinica
                //direccion clinica
                    SizedBox(height: appPadding,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.pin_drop_outlined,size: 30,color: Colors.grey,),
                    SizedBox(
                      width: appPadding,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width -80,
                          child: Text(
                            direccionClinica ?? 'Sin dirección',
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: AppFonts.nannic(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey),

                          ),
                        ),
                      ],
                    ),


                  ],
                ),

                    //email clinica
                    SizedBox(height: appPadding,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.contact_mail,size: 30,color: Colors.grey,),
                        SizedBox(
                          width: appPadding,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width -80,
                              child: Text(
                                emailClinica ?? 'Sin email',
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: AppFonts.nannic(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey),

                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                    SizedBox(height: appPadding,),
                    //tel clinica

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.contact_phone,size: 30,color: Colors.grey,),
                        SizedBox(
                          width: appPadding,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width -80,
                              child: Text(
                                telClinica ?? 'Sin tel',
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: AppFonts.nannic(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey),

                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                    //country clinica
                    SizedBox(height: appPadding,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.flag,size: 30,color: Colors.grey,),
                        SizedBox(
                          width: appPadding,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 25 ,
                              width: MediaQuery.of(context).size.width -80,
                              child: Text(
                                paisClinica ?? 'Sin pais',
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: AppFonts.nannic(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey),

                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                    SizedBox(height: appPadding,),
                    SizedBox(height: appPadding,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: (){

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditarClinicaPage(clinicaId: widget.clinicaId,clinicaDireccion: widget.clinicaDireccion, clinicaEmail: widget.clinicaEmail,clinicaLogo: widget.clinicaLogo,clinicaNombre: widget.clinicaNombre,clinicaPais: widget.clinicaPais,clinicaTel: widget.clinicaTel,)),
                          ).then((value) => setState(() {



                          }));
                        }, child: Column(
                          children: [
                            Icon(Icons.edit,color: Colors.grey,size: 30,),
                            Text("editardatosclinica".tr()),
                          ],
                        ))
                      ],
                    ),
                    SizedBox(height: appPadding,),
                    SizedBox(height: appPadding,),




                  ],
                ),
              ),
            ),
          ),

      ),
    );
  }
}

_onBackButtonPressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Cerrar la app?"),
          content: Text("¿Realmente quieres cerrar la app?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Si"))
          ],
        );
      });
  return exitApp ?? false;
}
