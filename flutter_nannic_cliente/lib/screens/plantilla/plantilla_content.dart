import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/screens/components/analytic_cards.dart';
import 'package:flutter_nannic_cliente/screens/components/custom_appbar/custom_appbar.dart';
import 'package:flutter_nannic_cliente/screens/components/discussions.dart';
import 'package:flutter_nannic_cliente/screens/components/top_referals.dart';
import 'package:flutter_nannic_cliente/screens/components/users.dart';
import 'package:flutter_nannic_cliente/screens/components/users_by_device.dart';
import 'package:flutter_nannic_cliente/screens/components/viewers.dart';




class PlantillaContent extends StatelessWidget {
  const PlantillaContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding), // Añade un espacio de padding alrededor del contenido
        child: Column(
          children: [
            CustomAppbar(titulo: 'Plantilla',), // Widget de barra de aplicación personalizada
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
                          AnalyticCards(), // Widget para mostrar tarjetas analíticas
                          SizedBox(
                            height: appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                          ),
                          Users(), // Widget para mostrar información de usuarios
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

