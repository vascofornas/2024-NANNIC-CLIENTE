import 'dart:convert';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:http/http.dart' as http;
Future<Map<String, dynamic>> obtenerDatosEstadoUsuario(String id) async {
  final url = Uri.parse(URLProyecto + APICarpeta + 'obtener_datos_estado_usuario.php');

  final response = await http.post(
    url,
    body: {'id': id.toString()},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = json.decode(response.body);

    // Convertir los valores de String a int
    final nivelUsuario = int.tryParse(responseBody['nivel_usuario']) ?? 0;
    final activo = int.tryParse(responseBody['activo']) ?? 0;

    //id
    final idUsuario = responseBody['id'];
    await SharedPrefsHelper().setId(idUsuario);

    //email
    final emailUsuario = responseBody['email'];
    await SharedPrefsHelper().setEmail(emailUsuario);

    //created_at
    final createdAtUsuario = responseBody['created_at'];
    await SharedPrefsHelper().setCreatedAt(createdAtUsuario);

    //imagen
    final imagenUsuario = responseBody['imagen'];
    await SharedPrefsHelper().setFoto(imagenUsuario);

    //verified
    final verifiedUsuario = responseBody['verified'];
    await SharedPrefsHelper().setVerified(verifiedUsuario);

    //updated_at
    final updatedAtUsuario = responseBody['updated_at'];
    await SharedPrefsHelper().setUpdatedAt(updatedAtUsuario);

    //nombre
    final nombreUsuario = responseBody['nombre'];
    await SharedPrefsHelper().setNombre(nombreUsuario);

    //apellidos
    final apellidosUsuario = responseBody['apellidos'];
    await SharedPrefsHelper().setApellidos(apellidosUsuario);

    //nivel_usuario
    final nivelUsuarioUsuario = responseBody['nivel_usuario'];
    await SharedPrefsHelper().setNivelUsuario(nivelUsuarioUsuario);

    //activo
    final activoUsuario = responseBody['activo'];
    print("valor activo_usuario en obtener_estado_usuario ${activoUsuario}");
    await SharedPrefsHelper().setActivo(activoUsuario);

    //tel
    final telUsuario = responseBody['tel'];
    await SharedPrefsHelper().setTel(telUsuario);

    //token_firebase
    final tokenFirebaseUsuario = responseBody['token_firebase'];
    await SharedPrefsHelper().setTokenFB(tokenFirebaseUsuario);

    //cel_verificado
    final celVerificadoUsuario = responseBody['cel_verificado'];
    await SharedPrefsHelper().setCelVerificado(celVerificadoUsuario);

    //terms
    final termsUsuario = responseBody['terms'];
    await SharedPrefsHelper().setTerms(termsUsuario);

    //version_app
    final versionAppUsuario = responseBody['version_app'];
    await SharedPrefsHelper().setVersionApp(versionAppUsuario);

    //so_dispositivo
    final soAppUsuario = responseBody['so_dispositivo'];
    await SharedPrefsHelper().setSOApp(soAppUsuario);

    //modelo_dispositivo
    final modeloDispositivo = responseBody['modelo_dispositivo'];
    await SharedPrefsHelper().setModeloDisp(modeloDispositivo);

    //ultimo uso app
    final ultimoUsoApp = responseBody['ultimo_uso_app'];
    await SharedPrefsHelper().setUltimoUsoApp(ultimoUsoApp);

    // Devolver los datos como un mapa
    return {
      'nivelUsuario': nivelUsuario,
      'activo': activo,
    };
  } else {
    throw Exception('Error al obtener los datos del usuario');
  }
}
