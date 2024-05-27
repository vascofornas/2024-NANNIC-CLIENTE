import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/screens/components/custom_appbar/custom_appbar.dart';
import 'package:flutter_nannic_cliente/screens/funciones/page_route_builder.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/nuevo_paciente_screen.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_screen.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesionales_analytic.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/zona_profesionales.dart';






class ProfesionalesContent extends StatefulWidget {
  const ProfesionalesContent({Key? key, required this.clinicaId}) : super(key: key);

  final String clinicaId;

  @override
  State<ProfesionalesContent> createState() => _ProfesionalesContentState();
}

class _ProfesionalesContentState extends State<ProfesionalesContent> {

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


  void getDatosUsuario() async {
    try {
      // Crear una instancia de SharedPrefsHelper
      SharedPrefsHelper prefsHelper = SharedPrefsHelper();

      // Obtener el ID de usuario
      idUsuario = await prefsHelper.getId() as String;

      // Obtener el ID de la clínica
      idClinica = await prefsHelper.getIdClinica() as String;

      // Obtener el nombre de la clínica
      nombreClinica = await prefsHelper.getNombreClinica() as String;

      // Obtener el logo de la clínica
      logoClinica = await prefsHelper.getLogoClinica() as String;

      // Actualizar el estado
      setState(() {
        // Aquí puedes realizar cualquier actualización de estado necesaria
      });
    } catch (e) {
      print("Error al obtener datos de usuario: $e");
    }
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
                CustomAppbar(titulo: 'profesionales'.tr(),),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        // Action to be performed on FAB tap
                        //abrir pantalla nuevo profesional
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>NuevoProfesionalPage(clinicaId: this.idClinica,)),
                        );
                      },
                      child: Icon(Icons.add),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      splashColor: Colors.white,
                    ),
                  ],
                )
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
                          ZonaProfesionales(), // Widget para mostrar información de usuarios
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

