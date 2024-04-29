import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<DatosUsuario> obtenerDatosUsuario() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? id = prefs.getString('id');
  String? email = prefs.getString('email');
  String? imagen = prefs.getString('imagen');
  String? nombre = prefs.getString('nombre');
  String? apellidos = prefs.getString('apellidos');
  String? tel = prefs.getString('tel');
  String? nivel_usuario = prefs.getString('nivel_usuario');

  return DatosUsuario(
    id: id!,
    email: email!,
    imagen: imagen!,
    nombre: nombre!,
    apellidos: apellidos!,
      tel: tel!,
    nivel_usuario: nivel_usuario!
  );
}