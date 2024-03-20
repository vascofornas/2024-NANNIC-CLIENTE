import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<int> obtenerNumeroProfesionales() async {
    final response = await http.get(Uri.parse(URLProyecto + APICarpeta + "admin_obtener_numero_profesionales.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final count = int.parse(data['count']); // Convertir a entero
      print("data count $count");
      return count;
    } else {
      throw Exception('Failed to load users count');
    }
  }
  static Future<int> obtenerNumeroProfesionalesAdministradores() async {
    final response = await http.get(Uri.parse(URLProyecto + APICarpeta + "admin_obtener_numero_profesionales_administradores.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final count = int.parse(data['count']); // Convertir a entero
      print("data count $count");
      return count;
    } else {
      throw Exception('Failed to load users count');
    }
  }
  Future<void> cambiarPasswordProfesional(String password, String email) async {
    // URL del script PHP
    String url = URLProyecto+APICarpeta+'recuperar_pass_usuario.php'; // Reemplaza con la URL real del script PHP

    // Parámetros a enviar
    Map<String, String> params = {
      'password': password,
      'email': email,
    };

    try {
      // Realiza la solicitud POST
      final response = await http.post(Uri.parse(url), body: params);

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (response.statusCode == 200) {
        // Imprime la respuesta del servidor (para depuración)
        print('Respuesta del servidor cambio pass profesional: ${response.body}');
        Fluttertoast.showToast(
            msg: "La contraseña del profesional ha sido cambiada",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);

        // Aquí puedes manejar la respuesta del servidor según sea necesario
        // Por ejemplo, mostrar un mensaje de éxito al usuario o realizar alguna otra acción.
      } else {
        // Si la solicitud no fue exitosa, muestra un mensaje de error
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Captura cualquier error que ocurra durante la solicitud
      print('Error: $e');
    }
  }
}

