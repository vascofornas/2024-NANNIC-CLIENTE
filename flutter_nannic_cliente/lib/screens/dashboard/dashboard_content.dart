import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple_dos_lineas.dart';
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
  String idClinica ="";
  String idUsuario ="";
  String tipoUsuario = "?";
  late Timer _timer;
  List<String> profesionales = [];
  List<String> administradores = [];

  bool _isVisible = true;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatosUsuario();





  }

  getDatosUsuario() async {

    print("············································");
    idUsuario = await SharedPrefsHelper.getId() as String;

    idClinica = await SharedPrefsHelper.getIdClinica() as String;

    nombreClinica = await SharedPrefsHelper.getNombreClinica() as String;

    logoClinica = await SharedPrefsHelper.getLogoClinica() as String;


    setState(() {

    });

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
                      SizedBox(
                        width: 215,
                        height: 85,
                        child: MiTextoSimpleDosLineas(
                          texto: nombreClinica!,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontsize: 22,
                        ),
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
                          PacientesAnalytic(clinicaId: this.idClinica),
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

