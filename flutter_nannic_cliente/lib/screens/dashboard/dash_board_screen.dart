import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:http/http.dart' as http;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/actualizar_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_estado_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_nannic_cliente/screens/dashboard/dashboard_content.dart';
import 'package:flutter_nannic_cliente/screens/dashboard/dashboard_no_admin.dart';
import 'package:flutter_nannic_cliente/screens/dashboard/usuario_bloqueado_no_admin.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key, }) : super(key: key);


  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late String emailUsuario = '';
  late String idUsuario = '';
  late String nivelUsuario = '';

  bool usuarioBloqueado = false;
  String so_dispositivo = "";
  String version_app = "";
  String modelo_dispositivo = "";
  String versionApp = "";
  late Timer _timer;

  List<String> profesionales = [];
  List<String> administradores = [];
  String idClinica ="";
  String tipoUsuario = "";
  bool soyAdministrador = false;
  bool soyProfesional = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getVersionInfo();

    obtenerDatosDispositivo();

    // Llama a la función verificarEstadoUsuario después de 5 segundos

    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      verificarEstadoUsuario(idUsuario);
      detectarTipoUsuario ();

    });
  }

  Future<void> _getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version_app = packageInfo.version;
    });
  }

  detectarTipoUsuario () async {

    bool? soyAdmin = await SharedPrefsHelper.getAdministradorClinica();
    bool? soyProfesional = await SharedPrefsHelper.getProfesionalClinica();

    if (soyAdmin!){
      print ("SOY ADMINISTRADOR");

    }
    if(soyProfesional!){
      print("SOY PROFESIOnAL");

    }


  }

  Future<void> obtenerDatosDispositivo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        if (androidInfo != null) {
          modelo_dispositivo = androidInfo.model;
          so_dispositivo = "Android";
          guardarDatosDispositivo(
              so_dispositivo, version_app, modelo_dispositivo, idUsuario);


        } else {

        }
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        if (iosInfo != null) {
          modelo_dispositivo = iosInfo.utsname.machine;
          so_dispositivo = "iOS";
          guardarDatosDispositivo(
              so_dispositivo, version_app, modelo_dispositivo, idUsuario);

        } else {

        }
      } else if (kIsWeb) {
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        if (webBrowserInfo != null) {
          modelo_dispositivo = webBrowserInfo.userAgent!;
          so_dispositivo = "Web";
          guardarDatosDispositivo(
              so_dispositivo, version_app, modelo_dispositivo, idUsuario);
          // e.g. "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"
        } else {

        }
      } else {

      }
    } catch (e) {

    }
  }








  verificarEstadoUsuario(String usuario) async {
    try {
      // Llama a obtenerDatosUsuario y espera la respuesta
      Map<String, dynamic> userData = await obtenerDatosEstadoUsuario(usuario);




      if (userData['activo'] != 1) {
        usuarioBloqueado = true;

      } else {
        usuarioBloqueado = false;

      }
    } catch (e) {

    }
    if (mounted) {
      if (usuarioBloqueado == true ) {
        setState(() {

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UsuarioBloqueadoScreen(clinicaId: idClinica,)),
                (route) => false, // Eliminar todas las rutas anteriores
          );

        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          drawer: DrawerMenu(
            emailUsuario: emailUsuario,
            clinicaId: idClinica,
          ),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(
                    child: DrawerMenu(
                      emailUsuario: emailUsuario,
                      clinicaId: idClinica,
                    ),
                  ),
                Expanded(
                  flex: 5,
                  child: DashboardContent(),
                )
              ],
            ),
          ),
          //scaffold para no administradores
        ));
  }
}
