import 'dart:async';


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/auth_shared_preferences/auth_manager.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple_dos_lineas.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/inicio_total.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/providers/usuario_provider.dart';
import 'package:flutter_nannic_cliente/screens/administradores/administradores_screen.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/clinicas_screen.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_divider.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_list_tile.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/components/profile_info.dart';
import 'package:flutter_nannic_cliente/screens/dashboard/dash_board_screen.dart';
import 'package:flutter_nannic_cliente/screens/equipos/equipos_screen.dart';
import 'package:flutter_nannic_cliente/screens/funciones/page_route_builder.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/pacientes_screen.dart';
import 'package:flutter_nannic_cliente/screens/perfil/perfil_screen.dart';
import 'package:flutter_nannic_cliente/screens/plantilla/plantilla_screen.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesionales_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key, required this.emailUsuario, required this.clinicaId}) : super(key: key);

  final String emailUsuario;
  final String clinicaId;

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  String version = "";

  late String emailUsuario = '';
  late String avatarUsuario = '';

  String nombreClinica = "AAA";
  String logoClinica = "logo_clinica.png";
  String tipoUsuario = "?";


  String idClinica ="";
  String idUsuario ="";

  bool soyAdmin = false;

  late Timer _timer;
  bool _isVisible = false;



  Future obtenerInfoPaquete() async {
    PackageInfo.fromPlatform().then((value) {
      var myPackageData = value.data;
      print("paquet ${myPackageData}");
      setState(() {});
    });
  }

  getDatosUsuario() async {


    idUsuario = await SharedPrefsHelper.getId() as String;

    emailUsuario = (await SharedPrefsHelper.getEmail())!;

    idClinica = await SharedPrefsHelper.getIdClinica() as String;

    nombreClinica = await SharedPrefsHelper.getNombreClinica() as String;

    logoClinica = await SharedPrefsHelper.getLogoClinica() as String;
    soyAdmin = (await SharedPrefsHelper.getAdministradorClinica())!;
    avatarUsuario = (await SharedPrefsHelper.getFoto())!;


    setState(() {

    });

  }








  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    obtenerInfoPaquete();
    getDatosUsuario();



  }



  @override
  Widget build(BuildContext context) {
    final AuthManager _authManager = AuthManager();
    var pantallaSeleccionada = Provider.of<UsuarioProvider>(context);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          //zona superior Nannic
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              soyAdmin?Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/admin.png")
                  )
                ),
                child: Text(""),
              ):SizedBox(width: 0,height: 0,),

              Container(
                width: 140,
                height: 140,
                padding: EdgeInsets.all(appPadding),
                child: Image.asset(
                  "assets/images/nannic.png",
                ),
              ),
            ],
          ),

          Center(
            child: Container(
                padding: EdgeInsets.all(appPadding),
                child: Text(
                  emailUsuario,
                  style:
                  AppFonts.nannic(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey

                  ),
                )),
          ),
          //zona superior Clinica
          Visibility(
            visible: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AvatarFromUrl(
                    imageUrl:
                    '${carpetaAdminClinicas}${logoClinica ?? ''}',
                    size: 55,
                  ),
                  SizedBox(width: appPadding,),
                  SizedBox(
                    width: 200,
                    height: 65,
                    child: MiTextoSimpleDosLineas(
                      texto: nombreClinica!,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontsize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Dashboard
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: pantallaSeleccionada.pantallaSeleccionada ==
                        "dashboard"
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white),
                color:
                pantallaSeleccionada.pantallaSeleccionada == "dashboard"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DrawerListTile(
                title: 'dashboard'.tr(),
                color:
                pantallaSeleccionada.pantallaSeleccionada == "dashboard"
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                svgSrc: 'assets/icons/Dashboard.svg',
                tap: () {
                  // Navegar a ProfesionalesScreen o a DashBoardScreen
                  final nextScreen =
                  pantallaSeleccionada.pantallaSeleccionada !=
                      "dashboard"
                      ? DashBoardScreen()
                      : DashBoardScreen();

                  Navigator.pushAndRemoveUntil(
                    context,
                    buildPageRouteBuilder(nextScreen),
                        (route) => false, // Eliminar todas las rutas anteriores
                  );

                  // Actualizar el estado de pantalla seleccionada
                  pantallaSeleccionada.pantallaSeleccionada == "dashboard"
                      ? pantallaSeleccionada.cambiarPantallaState("dashboard")
                      : pantallaSeleccionada
                      .cambiarPantallaState("dashboard");
                },
              ),
            ),
          ),
          //administradores
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: pantallaSeleccionada.pantallaSeleccionada ==
                        "adaministradores"
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white),
                color:
                pantallaSeleccionada.pantallaSeleccionada == "administradores"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DrawerListTile(
                title: 'administrators'.tr(),
                color:
                pantallaSeleccionada.pantallaSeleccionada == "administradores"
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                svgSrc: 'assets/icons/administrator.svg',
                tap: () {
                  // Navegar a ProfesionalesScreen o a DashBoardScreen
                  final nextScreen =
                  pantallaSeleccionada.pantallaSeleccionada !=
                      "administradores"
                      ? AdministradoresScreen(clinicaId: widget.clinicaId,)
                      : DashBoardScreen();

                  Navigator.pushAndRemoveUntil(
                    context,
                    buildPageRouteBuilder(nextScreen),
                        (route) => false, // Eliminar todas las rutas anteriores
                  );

                  // Actualizar el estado de pantalla seleccionada
                  pantallaSeleccionada.pantallaSeleccionada == "administradores"
                      ? pantallaSeleccionada.cambiarPantallaState("dashboard")
                      : pantallaSeleccionada
                      .cambiarPantallaState("administradores");
                },
              ),
            ),
          ),

          //profesionales
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: pantallaSeleccionada.pantallaSeleccionada ==
                            "profesionales"
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white),
                color:
                    pantallaSeleccionada.pantallaSeleccionada == "profesionales"
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DrawerListTile(
                title: 'profesionales'.tr(),
                color:
                    pantallaSeleccionada.pantallaSeleccionada == "profesionales"
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary,
                svgSrc: 'assets/icons/profesionales.svg',
                tap: () {
                  // Navegar a ProfesionalesScreen o a DashBoardScreen
                  final nextScreen =
                      pantallaSeleccionada.pantallaSeleccionada !=
                              "profesionales"
                          ? ProfesionalesScreen(clinicaId: widget.clinicaId,)
                          : DashBoardScreen();

                  Navigator.pushAndRemoveUntil(
                    context,
                    buildPageRouteBuilder(nextScreen),
                    (route) => false, // Eliminar todas las rutas anteriores
                  );

                  // Actualizar el estado de pantalla seleccionada
                  pantallaSeleccionada.pantallaSeleccionada == "profesionales"
                      ? pantallaSeleccionada.cambiarPantallaState("dashboard")
                      : pantallaSeleccionada
                          .cambiarPantallaState("profesionales");
                },
              ),
            ),
          ),

          //pacientes
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: pantallaSeleccionada.pantallaSeleccionada ==
                        "pacientes"
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white),
                color:
                pantallaSeleccionada.pantallaSeleccionada == "pacientes"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DrawerListTile(
                title: 'pacientes'.tr(),
                color:
                pantallaSeleccionada.pantallaSeleccionada == "pacientes"
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                svgSrc: 'assets/icons/pacientes.svg',
                tap: () {
                  // Navegar a ProfesionalesScreen o a DashBoardScreen
                  final nextScreen =
                  pantallaSeleccionada.pantallaSeleccionada !=
                      "pacientes"
                      ? PacientesScreen()
                      : DashBoardScreen();

                  Navigator.pushAndRemoveUntil(
                    context,
                    buildPageRouteBuilder(nextScreen),
                        (route) => false, // Eliminar todas las rutas anteriores
                  );

                  // Actualizar el estado de pantalla seleccionada
                  pantallaSeleccionada.pantallaSeleccionada == "pacientes"
                      ? pantallaSeleccionada.cambiarPantallaState("dashboard")
                      : pantallaSeleccionada
                      .cambiarPantallaState("pacientes");
                },
              ),
            ),
          ),
          //equipos
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: pantallaSeleccionada.pantallaSeleccionada ==
                        "equipos"
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white),
                color:
                pantallaSeleccionada.pantallaSeleccionada == "equipos"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DrawerListTile(
                title: 'equipos'.tr(),
                color:
                pantallaSeleccionada.pantallaSeleccionada == "equipos"
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                svgSrc: 'assets/icons/equipos.svg',
                tap: () {
                  // Navegar a ProfesionalesScreen o a DashBoardScreen
                  final nextScreen =
                  pantallaSeleccionada.pantallaSeleccionada !=
                      "equipos"
                      ? EquiposScreen(clinicaId: widget.clinicaId,)
                      : DashBoardScreen();

                  Navigator.pushAndRemoveUntil(
                    context,
                    buildPageRouteBuilder(nextScreen),
                        (route) => false, // Eliminar todas las rutas anteriores
                  );

                  // Actualizar el estado de pantalla seleccionada
                  pantallaSeleccionada.pantallaSeleccionada == "equipos"
                      ? pantallaSeleccionada.cambiarPantallaState("dashboard")
                      : pantallaSeleccionada
                      .cambiarPantallaState("equipos");
                },
              ),
            ),
          ),
          //perfil
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color:
                    pantallaSeleccionada.pantallaSeleccionada == "perfil"
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white),
                color: pantallaSeleccionada.pantallaSeleccionada == "perfil"
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: DrawerListTile(
                title: 'miperfil'.tr(),
                color: pantallaSeleccionada.pantallaSeleccionada == "perfil"
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                svgSrc: 'assets/icons/Subscribers.svg',
                tap: () {
                  // Navegar a ProfesionalesScreen o a DashBoardScreen
                  final nextScreen =
                  pantallaSeleccionada.pantallaSeleccionada != "perfil"
                      ? PerfilScreen(clinicaId: widget.clinicaId,)
                      : DashBoardScreen();
                  Navigator.pushAndRemoveUntil(
                    context,
                    buildPageRouteBuilder(nextScreen),
                        (route) => false, // Eliminar todas las rutas anteriores
                  );

                  // Actualizar el estado de pantalla seleccionada
                  pantallaSeleccionada.pantallaSeleccionada == "perfil"
                      ? pantallaSeleccionada.cambiarPantallaState("dashboard")
                      : pantallaSeleccionada.cambiarPantallaState("perfil");
                },
              ),
            ),
          ),
          //plantilla
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color:
                        pantallaSeleccionada.pantallaSeleccionada == "plantilla"
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white),
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
                  final nextScreen =
                      pantallaSeleccionada.pantallaSeleccionada != "plantilla"
                          ? PlantillaScreen(clinicaid: widget.clinicaId,)
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

              _authManager.logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext ctx) => MiWidget()));
            },
          ),
          buildPaddingDivider(),


          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error al obtener la información de la aplicación');
              } else {
                String version = snapshot.data!.version;
                return Center(
                  child: Text(
                    '©${DateTime.now().year} Nannic v${version}',
                    style: AppFonts.nannic(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey

                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
