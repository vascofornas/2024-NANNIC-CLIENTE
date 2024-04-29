import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/actualizar_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_estado_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_nannic_cliente/screens/dashboard/dashboard_content.dart';
import 'package:flutter_nannic_cliente/screens/dashboard/dashboard_no_admin.dart';
import 'package:flutter_nannic_cliente/screens/dashboard/usuario_bloqueado_no_admin.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late String emailUsuario = '';
  late String idUsuario = '';
  late String nivelUsuario = '';
  bool usuarioAdministrador = true;
  bool usuarioBloqueado = false;
  String so_dispositivo = "";
  String version_app = "";
  String modelo_dispositivo = "";
  String versionApp = "";
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getVersionInfo();
    capturarDatosUsuario();
    obtenerDatosDispositivo();

    // Llama a la función verificarEstadoUsuario después de 5 segundos

    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      verificarEstadoUsuario(idUsuario);
    });
  }

  Future<void> _getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version_app = packageInfo.version;
    });
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

          print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
        } else {
          print('No se pudo obtener información del dispositivo Android.');
        }
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        if (iosInfo != null) {
          modelo_dispositivo = iosInfo.utsname.machine;
          so_dispositivo = "iOS";
          guardarDatosDispositivo(
              so_dispositivo, version_app, modelo_dispositivo, idUsuario);
          print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
        } else {
          print('No se pudo obtener información del dispositivo iOS.');
        }
      } else if (kIsWeb) {
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        if (webBrowserInfo != null) {
          modelo_dispositivo = webBrowserInfo.userAgent!;
          so_dispositivo = "Web";
          guardarDatosDispositivo(
              so_dispositivo, version_app, modelo_dispositivo, idUsuario);
          print(
              'Running on ${webBrowserInfo.userAgent}'); // e.g. "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"
        } else {
          print('No se pudo obtener información del navegador web.');
        }
      } else {
        print('Plataforma no compatible.');
      }
    } catch (e) {
      print('Error al obtener información del dispositivo: $e');
    }
  }

  void capturarDatosUsuario() async {
    DatosUsuario datos = await obtenerDatosUsuario();
    print('El email del usuario es: ${datos.email}');
    emailUsuario = datos.email;
    nivelUsuario = datos.nivel_usuario;
    idUsuario = datos.id;

    print('El nivel del usuario es: ${nivelUsuario}');
    if (nivelUsuario != "2") {
      setState(() {
        usuarioAdministrador = false;
      });
    }
  }

  verificarEstadoUsuario(String usuario) async {
    try {
      // Llama a obtenerDatosUsuario y espera la respuesta
      Map<String, dynamic> userData = await obtenerDatosEstadoUsuario(usuario);



      if (userData['nivelUsuario'] != 2) {
        usuarioAdministrador = false;

      } else {
        usuarioAdministrador = true;

      }
      if (userData['activo'] != 1) {
        usuarioBloqueado = true;

      } else {
        usuarioBloqueado = false;

      }
    } catch (e) {

    }
    if (mounted) {
      if (usuarioBloqueado == true || usuarioAdministrador == false) {
        setState(() {

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UsuarioBloqueadoScreen()),
                (route) => false, // Eliminar todas las rutas anteriores
          );

        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        "Condición usuarioAdministrador == false: ${usuarioAdministrador == false}");

    return WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          drawer: DrawerMenu(
            emailUsuario: emailUsuario,
          ),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(
                    child: DrawerMenu(
                      emailUsuario: emailUsuario,
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
