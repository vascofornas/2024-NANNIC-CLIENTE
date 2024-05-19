import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/screens/administradores/zona_administradores.dart';
import 'package:flutter_nannic_cliente/screens/components/custom_appbar/custom_appbar.dart';
import 'package:flutter_nannic_cliente/screens/funciones/page_route_builder.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/nuevo_paciente_screen.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_screen.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesionales_analytic.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/zona_profesionales.dart';






class AdministradoresContent extends StatefulWidget {
  const AdministradoresContent({Key? key, required this.clinicaId}) : super(key: key);

  final String clinicaId;

  @override
  State<AdministradoresContent> createState() => _AdministradoresContentState();
}

class _AdministradoresContentState extends State<AdministradoresContent> {

  String nombreClinica = "AAA";
  String logoClinica = "logo_clinica.png";
  String idClinica ="";
  String idUsuario ="";

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




    return  SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding), // Añade un espacio de padding alrededor del contenido
        child: Column(
          children: [
            Column(
              children: [
                CustomAppbar(titulo: 'administrators'.tr(),),


              ],
            ), // Widget de barra de aplicación personalizada
            SizedBox(
              height: appPadding, // Espacio adicional entre la barra de aplicación y el contenido
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
                          ProfesionalesAnalytic(clinicaId: this.idClinica ,), // Widget para mostrar tarjetas analíticas
                          SizedBox(
                            height: appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                          ),
                          ZonaAdministradores(), // Widget para mostrar información de usuarios
                          // Espacio adicional si el dispositivo es móvil y se muestra la sección de discusiones

                        ],
                      ),
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

