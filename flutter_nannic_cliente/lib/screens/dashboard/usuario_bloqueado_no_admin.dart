import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_estado_usuario.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/dashboard/dash_board_screen.dart';

class UsuarioBloqueadoScreen extends StatefulWidget {
  const UsuarioBloqueadoScreen({Key? key, required this.clinicaId}) : super(key: key);
  final String clinicaId;

  @override
  State<UsuarioBloqueadoScreen> createState() => _UsuarioBloqueadoScreenState();
}

class _UsuarioBloqueadoScreenState extends State<UsuarioBloqueadoScreen> {

  late String emailUsuario = '';
  late String idUsuario = '';
  late String nivelUsuario = '';

  bool usuarioBloqueado = false;

  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    capturarDatosUsuario();


    // Llama a la función verificarEstadoUsuario después de 5 segundos

    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      verificarEstadoUsuario(idUsuario);
    });
  }
  verificarEstadoUsuario(String usuario) async {
    try {
      // Llama a obtenerDatosUsuario y espera la respuesta
      Map<String, dynamic> userData = await obtenerDatosEstadoUsuario(usuario);

      // Aquí puedes usar los datos obtenidos como desees

      print(
          'Tipo de userData[\'nivelUsuario\']: ${userData['nivelUsuario'].runtimeType}');


      if (userData['activo'] != 1) {
        usuarioBloqueado = true;
        print("EL USUARIO ESTA BLOQUEADO");
      } else {
        usuarioBloqueado = false;
        print("EL USUARIO NO ESTA BLOQUEADO");
      }
    } catch (e) {
      print('Error al obtener datos del usuario: $e');
    }
    if (mounted) {
      if (usuarioBloqueado == false ) {
        setState(() {


          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashBoardScreen()),
                (route) => false, // Eliminar todas las rutas anteriores
          );

        });
      }

    }
  }



  void capturarDatosUsuario() async {
    DatosUsuario datos = await obtenerDatosUsuario();
    print('El email del usuario es: ${datos.email}');
    emailUsuario = datos.email;
    nivelUsuario = datos.nivel_usuario;
    idUsuario = datos.id;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('usuariobloqueado'.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.block,
              size: 100,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              'cuentabloqueada'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
