import 'dart:convert';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> obtenerDatosEstadoUsuario(String id) async {
  final url = Uri.parse(URLProyecto + APICarpeta +'obtener_datos_estado_usuario.php');


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
    final id_usuario = responseBody['id'];

    SharedPrefsHelper.setId(id_usuario);
    //email
    final email_usuario = responseBody['email'];

    SharedPrefsHelper.setEmail(email_usuario);
    //created_at
    final created_at_usuario = responseBody['created_at'];

    SharedPrefsHelper.setCreatedAt(created_at_usuario);
    //imagen
    final imagen_usuario = responseBody['imagen'];

    SharedPrefsHelper.setFoto(imagen_usuario);
    //recibida 75_HAdlzckRaPlQ.jpg
    //verified
    final verified_usuario = responseBody['verified'];

    SharedPrefsHelper.setVerified(verified_usuario);
    //updated_at
    final updated_at_usuario = responseBody['updated_at'];

    SharedPrefsHelper.setUpdatedAt(updated_at_usuario);
    //nombre
    final nombre_usuario = responseBody['nombre'];

    SharedPrefsHelper.setNombre(nombre_usuario);
    //apellidos
    final apellidos_usuario = responseBody['apellidos'];

    SharedPrefsHelper.setApellidos(apellidos_usuario);
    //nivel_usuario
    final nivel_usuario_usuario = responseBody['nivel_usuario'];

    SharedPrefsHelper.setNivelUsuario(nivel_usuario_usuario);
    //activo
    final activo_usuario = responseBody['activo'];

    SharedPrefsHelper.setActivo(activo_usuario);
    //tel
    final tel_usuario = responseBody['tel'];

    SharedPrefsHelper.setTel(tel_usuario);
    //token_firebase
    final token_firebase_usuario = responseBody['token_firebase'];

    SharedPrefsHelper.setTokenFB(token_firebase_usuario);
    //cel_verificado
    final cel_verificado_usuario = responseBody['cel_verificado'];

    SharedPrefsHelper.setCelVerificado(cel_verificado_usuario);
    //terms
    final terms_usuario = responseBody['terms'];

    SharedPrefsHelper.setTerms(terms_usuario);
    //tel_country
    final tel_country_usuario = responseBody['tel_country'];

    SharedPrefsHelper.setTelCountry(tel_country_usuario);
    //version_app
    final version_app_usuario = responseBody['version_app'];

    SharedPrefsHelper.setVersionApp(version_app_usuario);


    // Devolver los datos como un mapa
    return {
      'nivelUsuario': nivelUsuario,
      'activo': activo,
    };
  } else {
    throw Exception('Error al obtener los datos del usuario');
  }
}
