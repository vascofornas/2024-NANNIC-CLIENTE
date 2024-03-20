import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/auth_shared_preferences/auth_manager.dart';

import 'package:flutter_admin_dashboard/constants/constants.dart';

import 'package:flutter_admin_dashboard/inicio_total.dart';
import 'package:flutter_admin_dashboard/providers/usuario_provider.dart';
import 'package:flutter_admin_dashboard/screens/components/drawer/drawer_divider.dart';
import 'package:flutter_admin_dashboard/screens/components/drawer/drawer_list_tile.dart';

import 'package:flutter_admin_dashboard/screens/dashboard/dash_board_screen.dart';
import 'package:flutter_admin_dashboard/screens/funciones/page_route_builder.dart';
import 'package:flutter_admin_dashboard/screens/plantilla/plantilla_screen.dart';
import 'package:flutter_admin_dashboard/screens/profesionales/profesionales_screen.dart';
import 'package:provider/provider.dart';


class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    final AuthManager _authManager = AuthManager();
    var pantallaSeleccionada = Provider.of<UsuarioProvider>(context);

    return Drawer(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset("assets/images/logo_corto.png"),
          ),

          //profesionales
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: pantallaSeleccionada.pantallaSeleccionada ==
                    "profesionales" ? Theme.of(context).colorScheme.primary : Colors.white),
                color: pantallaSeleccionada.pantallaSeleccionada == "profesionales"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DrawerListTile(
                title: 'Profesionales',
                color: pantallaSeleccionada.pantallaSeleccionada == "profesionales"
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                svgSrc: 'assets/icons/Subscribers.svg',
                tap: () {
                  // Navegar a ProfesionalesScreen o a DashBoardScreen
                  final nextScreen = pantallaSeleccionada.pantallaSeleccionada != "profesionales"
                      ? ProfesionalesScreen()
                      : DashBoardScreen();
                  Navigator.pushAndRemoveUntil(
                    context,
                    buildPageRouteBuilder(nextScreen),
                        (route) => false, // Eliminar todas las rutas anteriores
                  );

                  // Actualizar el estado de pantalla seleccionada
                  pantallaSeleccionada.pantallaSeleccionada == "profesionales"
                      ? pantallaSeleccionada.cambiarPantallaState("dashboard")
                      : pantallaSeleccionada.cambiarPantallaState("profesionales");
                },
              ),
            ),
          ),
          //plantilla
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: pantallaSeleccionada.pantallaSeleccionada ==
                    "plantilla" ? Theme.of(context).colorScheme.primary : Colors.white),
                color: pantallaSeleccionada.pantallaSeleccionada == "plantilla"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DrawerListTile(
                title: 'Plantilla',
                color: pantallaSeleccionada.pantallaSeleccionada == "plantilla"
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                svgSrc: 'assets/icons/Subscribers.svg',
                tap: () {
                  // Navegar a ProfesionalesScreen o a DashBoardScreen
                  final nextScreen = pantallaSeleccionada.pantallaSeleccionada != "plantilla"
                      ? PlantillaScreen()
                      : DashBoardScreen();
                  Navigator.pushAndRemoveUntil(
                    context,
                    buildPageRouteBuilder(nextScreen),
                        (route) => false, // Eliminar todas las rutas anteriores
                  );

                  // Actualizar el estado de pantalla seleccionada
                  pantallaSeleccionada.pantallaSeleccionada == "plantilla"
                      ? pantallaSeleccionada.cambiarPantallaState("dashboard")
                      : pantallaSeleccionada.cambiarPantallaState("plantilla");
                },
              ),
            ),
          ),


          buildPaddingDivider(),

          DrawerListTile(
            title: 'Logout',
            color: Colors.red,
            svgSrc: 'assets/icons/Logout.svg',
            tap: () {
              print("pulsado logout");
              _authManager.logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext ctx) => MiWidget()));
            },
          ),
        ],
      ),
    );
  }




}
