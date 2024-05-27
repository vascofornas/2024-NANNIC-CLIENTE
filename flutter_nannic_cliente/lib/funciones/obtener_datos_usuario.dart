import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<DatosUsuario> obtenerDatosUsuario() async {
 String? id = await SharedPrefsHelper().getId();
 String? email = await SharedPrefsHelper().getEmail();
 String? imagen = await SharedPrefsHelper().getFoto();
 String? nombre = await SharedPrefsHelper().getNombre();
 String? apellidos = await SharedPrefsHelper().getApellidos();
 String? tel = await SharedPrefsHelper().getTel();
 String? nivel_usuario = await SharedPrefsHelper().getNivelUsuario();

 return DatosUsuario(
  id: id ?? '',
  email: email ?? '',
  imagen: imagen ?? '',
  nombre: nombre ?? '',
  apellidos: apellidos ?? '',
  tel: tel ?? '',
  nivel_usuario: nivel_usuario ?? '',
 );
}
