import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/screens/components/custom_appbar/custom_appbar.dart';
import 'package:flutter_nannic_cliente/screens/funciones/page_route_builder.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_screen.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesionales_analytic.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/zona_profesionales.dart';






class ProfesionalesContent extends StatelessWidget {
  const ProfesionalesContent({Key? key}) : super(key: key);

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
                          MaterialPageRoute(builder: (context) => const NuevoProfesionalPage()),
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
                          const ProfesionalesAnalytic(), // Widget para mostrar tarjetas analíticas
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

