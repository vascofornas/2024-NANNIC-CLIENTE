import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/clinicas_analytic.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/zona_pacientes/pacientes_analytic.dart';
import 'package:flutter_nannic_cliente/screens/components/analytic_cards.dart';
import 'package:flutter_nannic_cliente/screens/components/custom_appbar/custom_appbar.dart';
import 'package:flutter_nannic_cliente/screens/components/discussions.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/components/top_referals.dart';
import 'package:flutter_nannic_cliente/screens/components/users.dart';
import 'package:flutter_nannic_cliente/screens/components/users_by_device.dart';
import 'package:flutter_nannic_cliente/screens/components/viewers.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesionales_analytic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class DashboardContent extends StatefulWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {

  String nombreClinica = "AAA";
  String logoClinica = "logo_clinica.png";
  String tipoUsuario = "?";
  late Timer _timer;
  List<String> profesionales = [];
  List<String> administradores = [];
  String idClinica ="";
  bool _isVisible = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Esperar 5 segundos antes de mostrar el Row
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isVisible = true;
      });
    });
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {

      fetchDataClinica();
      getDatosClinica();
    });


  }

  getDatosClinica() async {
    if(mounted){

        nombreClinica = (await SharedPrefsHelper.getNombreClinica())!;

        logoClinica = (await SharedPrefsHelper.getLogoClinica())!;
        if(SharedPrefsHelper.getAdministradorClinica()== true){
          tipoUsuario = "Administrador";
        }
        if(SharedPrefsHelper.getProfesionalClinica()== true){
          tipoUsuario = "Profesional";
        }

     setState(() {

     });
    }



  }
  Future<void> fetchDataClinica() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id') ?? '';
    // Si el ID del usuario no está presente, no se realiza la solicitud al servidor
    if (userId.isEmpty) {
      return;
    }

    // Realizamos la solicitud HTTP al script PHP
    final response = await http.get(Uri.parse(URLProyecto+APICarpeta+'obtener_clinica_profesional_administrador.php?idUsuario=$userId'));

    // Verificamos si la solicitud fue exitosa (código 200)
    if (response.statusCode == 200) {
      // Convertimos la respuesta JSON en un mapa
      Map<String, dynamic> data = jsonDecode(response.body);
      List<String> profesionales = [];
      List<String> administradores = [];
      String? idClinicaActual;
      String? tipoUsuarioActual;

      if (data.containsKey('profesional')) {
        if (data['profesional'].isNotEmpty) {
          idClinicaActual = data['profesional'][0]; // Suponemos que el usuario es profesional de una sola clínica
          tipoUsuarioActual = 'profesional';
        }
      }

      if (data.containsKey('administrador')) {
        if (data['administrador'].isNotEmpty) {
          idClinicaActual = data['administrador'][0]; // Suponemos que el usuario es administrador de una sola clínica
          tipoUsuarioActual = 'administrador';
        }
      }


      // Actualizamos el estado de la aplicación con los datos obtenidos
      if(mounted){
        this.idClinica = idClinicaActual!;
        this.tipoUsuario = tipoUsuarioActual!;

        //actualizamos SP con los datos obtenidos
        setState(() {


          if(tipoUsuarioActual == "profesional"){

            SharedPrefsHelper.setEsProfesionalClinica(true);
            SharedPrefsHelper.setEsAdministradorClinica(false);
            SharedPrefsHelper.setIdClinica(idClinicaActual!);
            obtenerDatosClinica(idClinicaActual!);
          }
          if(tipoUsuarioActual == "administrador"){

            SharedPrefsHelper.setEsProfesionalClinica(false);
            SharedPrefsHelper.setEsAdministradorClinica(true);
            SharedPrefsHelper.setIdClinica(idClinicaActual!);
          }
          obtenerDatosClinica(idClinica);
        });
      }



    } else {
      // Si la solicitud falla, puedes manejar el error de alguna manera

    }
  }
  Future<Map<String, String>> obtenerDatosClinica(String idClinica) async {
    // URL del script PHP en el servidor remoto
    String url = URLProyecto+APICarpeta+'obtener_datos_clinica.php?idClinica=$idClinica';


    // Realizar la solicitud HTTP
    final response = await http.get(Uri.parse(url));


    // Verificar si la solicitud fue exitosa
    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON
      Map<String, dynamic> data = jsonDecode(response.body);

      // Obtener el nombre y el logo de la clínica
      String nombreClinica = data['nombre_clinica'];

      SharedPrefsHelper.setNombreClinica(nombreClinica);
      String logoClinica = data['logo_clinica'];

      SharedPrefsHelper.setLogoClinica(logoClinica);
      setState(() {

      });


      // Devolver los datos de la clínica como un mapa
      return {
        'nombreClinica': nombreClinica,
        'logoClinica': logoClinica,
      };
    } else {
      // Si la solicitud falla, lanzar una excepción o devolver null
      throw Exception('Error al obtener los datos de la clínica.');
      // return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding), // Añade un espacio de padding alrededor del contenido
        child: Column(
          children: [
            CustomAppbar(titulo: 'dashboard'.tr(),), // Widget de barra de aplicación personalizada
            SizedBox(
              height: appPadding, // Espacio adicional entre la barra de aplicación y el contenido
            ),
            Column(
              children: [
                //datos de la clinica
                // Primera fila de widgets
                Visibility(
                  visible: _isVisible,
                  child: Row(
                    children: [
                      AvatarFromUrl(
                        imageUrl:
                        '${carpetaAdminClinicas}${logoClinica ?? ''}',
                        size: 85,
                      ),
                      SizedBox(width: appPadding,),
                      MiTextoSimple(
                        texto: nombreClinica!,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                        fontsize: 22,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: appPadding,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          ProfesionalesAnalytic(clinicaId: this.idClinica,),
                          SizedBox(height: appPadding,),
                          ClinicasAnalytic(),// Widget para mostrar tarjetas analíticas
                          SizedBox(height: appPadding,),
                          PacientesAnalytic(),
                          SizedBox(
                            height: appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                          ),

                          // Espacio adicional si el dispositivo es móvil y se muestra la sección de discusiones
                          if (Responsive.isMobile(context))
                            SizedBox(
                              height: appPadding,
                            ),
                          // Widget para mostrar discusiones, solo se muestra en dispositivos móviles
                          if (Responsive.isMobile(context)) Discussions(),
                        ],
                      ),
                    ),
                    // Espacio adicional si el dispositivo no es móvil
                    if (!Responsive.isMobile(context))
                      SizedBox(
                        width: appPadding,
                      ),
                    // Widget para mostrar discusiones, solo se muestra si el dispositivo no es móvil
                    if (!Responsive.isMobile(context))
                      Expanded(
                        flex: 2,
                        child: Discussions(),
                      ),
                  ],
                ),
                // Segunda fila de widgets
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          // Espacio adicional entre la primera fila y esta fila de widgets
                          SizedBox(
                            height: appPadding,
                          ),
                          // Sección para mostrar los referentes principales y los espectadores
                          Row(
                            children: [
                              // Sección de referentes principales, se expande más si el dispositivo no es móvil
                              if(!Responsive.isMobile(context))
                                Expanded(
                                  child: TopReferals(),
                                  flex: 2,
                                ),
                              // Espacio adicional si el dispositivo no es móvil
                              if(!Responsive.isMobile(context))
                                SizedBox(width: appPadding,),
                              // Sección de espectadores, se expande más si el dispositivo no es móvil
                              Expanded(
                                flex: 3,
                                child: Viewers(),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          // Espacio adicional entre las secciones de referentes principales/espectadores y la siguiente sección de widgets
                          SizedBox(
                            height: appPadding,
                          ),
                          // Widgets adicionales para dispositivos móviles
                          if (Responsive.isMobile(context))
                            SizedBox(
                              height: appPadding,
                            ),
                          if (Responsive.isMobile(context)) TopReferals(),
                          if (Responsive.isMobile(context))
                            SizedBox(
                              height: appPadding,
                            ),
                          if (Responsive.isMobile(context)) UsersByDevice(),
                        ],
                      ),
                    ),
                    // Espacio adicional si el dispositivo no es móvil
                    if (!Responsive.isMobile(context))
                      SizedBox(
                        width: appPadding,
                      ),
                    // Widget para mostrar información de usuarios por dispositivo, se muestra si el dispositivo no es móvil
                    if (!Responsive.isMobile(context))
                      Expanded(
                        flex: 2,
                        child: UsersByDevice(),
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

