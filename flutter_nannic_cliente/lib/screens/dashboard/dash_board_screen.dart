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
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String emailUsuario = '';
  String nivelUsuario = '';
  bool usuarioBloqueado = false;
  String so_dispositivo = "";
  String version_app = "";
  String modelo_dispositivo = "";
  String versionApp = "";
  late Timer _timer;
  List<String> profesionales = [];
  List<String> administradores = [];
  String idClinica = "";
  String tipoUsuario = "";
  bool soyAdministrador = false;
  bool soyProfesional = false;
  String idUsuario = ""; // Declarar idUsuario como una variable de estado

  @override
  void initState() {
    super.initState();

    _getVersionInfo();


    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      detectarTipoUsuario();





    });
  }

  Future<void> _getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version_app = packageInfo.version;

    });
  }
  void detectarTipoUsuario() async {
    try {
      if (!mounted) return; // Verificar si el widget está montado antes de realizar operaciones

      // Crear una instancia de SharedPrefsHelper
      SharedPrefsHelper sharedPrefsHelper = SharedPrefsHelper();

      // Obtener los valores de SharedPrefsHelper
      bool? soyAdmin = await sharedPrefsHelper.getAdministradorClinica();
      bool? soyProfesional = await sharedPrefsHelper.getProfesionalClinica();
      String? id = await sharedPrefsHelper.getId();

      // Asignar el valor de idUsuario
      idUsuario = id!;

      // Establecer el estado según los valores obtenidos
      setState(() {
        soyAdministrador = soyAdmin == true;
        soyProfesional = soyProfesional == true;
      });

      // Verificar el estado del usuario
      verificarEstadoUsuario(idUsuario);
      // Obtener los datos del dispositivo
      obtenerDatosDispositivo();
    } catch (e) {
      print("Error en detectarTipoUsuario: $e");
    }
  }


  void imprimirTodoSP () async {
    try {
      var idSP = await SharedPrefsHelper().getId() ?? "";
      var emailSP = await SharedPrefsHelper().getEmail() ?? "";
      var created_atSP = await SharedPrefsHelper().getCreatedAt() ?? "";
      var updated_atSP = await SharedPrefsHelper().getUpdatedAt() ?? "";
      var fotoSP = await SharedPrefsHelper().getFoto() ?? "";
      var verifiedSP = await SharedPrefsHelper().getVerified() ?? "";
      var nombreSP = await SharedPrefsHelper().getNombre() ?? "";
      var apellidosSP = await SharedPrefsHelper().getApellidos() ?? "";
      var nivel_usuarioSP = await SharedPrefsHelper().getNivelUsuario() ?? "";
      var activoSP = await SharedPrefsHelper().getActivo() ?? "";
      var telSP = await SharedPrefsHelper().getTel() ?? "";
      var tokenFBSP = await SharedPrefsHelper().getTokenFB() ?? "";
      var cel_verificadoSP = await SharedPrefsHelper().getCelVerificado() ?? "";
      var termsSP = await SharedPrefsHelper().getTerms() ?? "";
      var version_appSP = await SharedPrefsHelper().getVersionApp() ?? "";
      var so_appSP = await SharedPrefsHelper().getSOApp() ?? "";
      var modeloDispSP = await SharedPrefsHelper().getModeloDisp() ?? "";
      var logeadoSP = await SharedPrefsHelper().getLogeado() ?? false;
      var profesionalClinicaSP = await SharedPrefsHelper().getProfesionalClinica() ?? false;
      var adminClinicaSP = await SharedPrefsHelper().getAdministradorClinica() ?? false;
      var clinicaIdSP = await SharedPrefsHelper().getIdClinica() ?? "";
      var nombreClinicaSP = await SharedPrefsHelper().getNombreClinica() ?? "";
      var logoClinicaSP = await SharedPrefsHelper().getLogoClinica() ?? "";
      var ultimoUsoAppSP = await SharedPrefsHelper().getUltimoUsoApp() ?? "";

      // Imprimir los valores
      print("id: $idSP");
      print("email: $emailSP");
      print("created_at: $created_atSP");
      print("updated_at: $updated_atSP");
      print("foto: $fotoSP");
      print("verified: $verifiedSP");
      print("nombre: $nombreSP");
      print("apellidos: $apellidosSP");
      print("nivel_usuario: $nivel_usuarioSP");
      print("activo: $activoSP");
      print("tel: $telSP");
      print("token_firebase: $tokenFBSP");
      print("cel_verificado: $cel_verificadoSP");
      print("terms: $termsSP");
      print("version_app: $version_appSP");
      print("so_app: $so_appSP");
      print("modelo_dispositivo: $modeloDispSP");
      print("logeado: $logeadoSP");
      print("profesionalClinica: $profesionalClinicaSP");
      print("adminClinica: $adminClinicaSP");
      print("clinicaId: $clinicaIdSP");
      print("nombreClinica: $nombreClinicaSP");
      print("logoClinica: $logoClinicaSP");
      print("ultimoUsoApp: $ultimoUsoAppSP");
    } catch (e) {
      print("Error al imprimir datos de SharedPreferences: $e");
    }
  }



  Future<void> obtenerDatosDispositivo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        modelo_dispositivo = androidInfo.model;
        so_dispositivo = "Android";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        modelo_dispositivo = iosInfo.utsname.machine;
        so_dispositivo = "iOS";
      } else if (kIsWeb) {
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        modelo_dispositivo = webBrowserInfo.userAgent!;
        so_dispositivo = "Web";
      }
      print("guardando datos del dispositivo ${so_dispositivo} ${version_app} ${modelo_dispositivo} ${idUsuario}");
      guardarDatosDispositivo(so_dispositivo, version_app, modelo_dispositivo, idUsuario);


      imprimirTodoSP();
    } catch (e) {
      print("Error al obtener datos del dispositivo: $e");
    }
  }

  void verificarEstadoUsuario(String usuario) async {
    print("estoy en verificarEstadoUsuario");
    try {
      Map<String, dynamic> userData = await obtenerDatosEstadoUsuario(usuario);
      setState(() {
        usuarioBloqueado = userData['activo'] != 1;
      });
      if (usuarioBloqueado) {
        print("ESTOY BLOQUEADO");
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UsuarioBloqueadoScreen(clinicaId: idClinica)),
                (route) => false,
          );
        }
      } else {
        print("NO ESTOY BLOQUEADO");
      }
    } catch (e) {
      print("Error al verificar el estado del usuario: $e");
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
      ),
    );
  }
}
