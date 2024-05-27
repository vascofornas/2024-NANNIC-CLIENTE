import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/clinicas_analytic.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/nueva_clinica_screen.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zona_clinicas.dart';
import 'package:flutter_nannic_cliente/screens/components/custom_appbar/custom_appbar.dart';
import 'package:flutter_nannic_cliente/screens/equipos/equipos_analytic.dart';
import 'package:flutter_nannic_cliente/screens/equipos/nuevo_equipo_screen.dart';
import 'package:flutter_nannic_cliente/screens/equipos/zona_equipos.dart';
import 'package:flutter_nannic_cliente/screens/funciones/page_route_builder.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_screen.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesionales_analytic.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/zona_profesionales.dart';

import '../../funciones/shared_prefs_helper.dart';






class EquiposContent extends StatefulWidget {
  const EquiposContent({Key? key, required this.clinicaId, }) : super(key: key);

  final String clinicaId;


  @override
  State<EquiposContent> createState() => _EquiposContentState();
}

class _EquiposContentState extends State<EquiposContent> {

  String clinicaActual = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdClinica();

  }
  actualizar(){
    setState(() {


    });
  }

  void getIdClinica() async {
    try {
      // Crear una instancia de SharedPrefsHelper
      SharedPrefsHelper prefsHelper = SharedPrefsHelper();

      // Obtener la ID de la clínica
      clinicaActual = (await prefsHelper.getIdClinica())!;

      // Actualizar el estado si es necesario
      if (mounted) {
        setState(() {
          // Aquí podrías realizar cualquier otra operación necesaria después de obtener la ID de la clínica
        });
      }
    } catch (e) {
      print("Error en getIdClinica: $e");
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
                CustomAppbar(titulo: 'equipos'.tr(),),

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
                          EquiposAnalytic(idCLinica: clinicaActual,), // Widget para mostrar tarjetas analíticas
                          SizedBox(
                            height: appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                          ),
                          ZonaEquipos(onActualizarEstado: actualizar,clinicaId: clinicaActual,), // Widget para mostrar información de usuarios
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

