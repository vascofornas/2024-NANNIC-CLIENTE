import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/constants/constants.dart';
import 'package:flutter_admin_dashboard/constants/responsive.dart';
import 'package:flutter_admin_dashboard/screens/components/analytic_cards.dart';
import 'package:flutter_admin_dashboard/screens/components/custom_appbar/custom_appbar.dart';
import 'package:flutter_admin_dashboard/screens/components/discussions.dart';
import 'package:flutter_admin_dashboard/screens/components/top_referals.dart';
import 'package:flutter_admin_dashboard/screens/components/users.dart';
import 'package:flutter_admin_dashboard/screens/components/users_by_device.dart';
import 'package:flutter_admin_dashboard/screens/components/viewers.dart';
import 'package:flutter_admin_dashboard/screens/profesionales/profesionales_analytic.dart';
import 'package:flutter_admin_dashboard/screens/profesionales/zona_profesionales.dart';




class ProfesionalesContent extends StatelessWidget {
  const ProfesionalesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding), // Añade un espacio de padding alrededor del contenido
        child: Column(
          children: [
            CustomAppbar(titulo: 'Profesionales',), // Widget de barra de aplicación personalizada
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
                          ProfesionalesAnalytic(), // Widget para mostrar tarjetas analíticas
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

