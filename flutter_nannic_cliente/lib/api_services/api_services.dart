import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<int> obtenerNumeroProfesionales() async {
    final response = await http.get(Uri.parse(URLProyecto + APICarpeta + "admin_obtener_numero_profesionales.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final count = int.parse(data['count']); // Convertir a entero

      return count;
    } else {
      throw Exception('Failed to load users count');
    }
  }
  static Future<int> obtenerNumeroProfesionalesClinica(String idClinica) async {


    final response = await http.get(Uri.parse(URLProyecto + APICarpeta + "admin_obtener_numero_profesionales_clinica.php?id_clinica=$idClinica"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final count = int.parse(data['count']); // Convertir a entero

      return count;
    } else {
      throw Exception('Failed to load users count');
    }
  }
  static Future<int> obtenerNumeroPacientes() async {
    final response = await http.get(Uri.parse(URLProyecto + APICarpeta + "admin_obtener_numero_pacientes.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final count = int.parse(data['count']); // Convertir a entero

      return count;
    } else {
      throw Exception('Failed to load users count');
    }
  }
  static Future<int> obtenerNumeroPacientesClinica(String idClinica) async {

    final response = await http.get(Uri.parse(URLProyecto + APICarpeta + "admin_obtener_numero_pacientes_clinica.php?id_clinica=$idClinica"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final count = int.parse(data['count']); // Convertir a entero

      return count;
    } else {
      throw Exception('Failed to load users count');
    }
  }
  static Future<int> obtenerNumeroClinicas() async {
    final response = await http.get(Uri.parse(URLProyecto + APICarpeta + "admin_obtener_numero_clinicas.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final count = int.parse(data['count']); // Convertir a entero

      return count;
    } else {
      throw Exception('Failed to load users count');
    }
  }
  static Future<int> obtenerNumeroEquiposNannic() async {
    final response = await http.get(Uri.parse(URLProyecto + APICarpeta + "admin_obtener_numero_equipos_nannic.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final count = int.parse(data['count']); // Convertir a entero

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

      return count;
    } else {
      throw Exception('Failed to load users count');
    }
  }
  static Future<int> obtenerNumeroProfesionalesAdministradoresClinica(String idClinica) async {




    final response = await http.get(Uri.parse(URLProyecto + APICarpeta + "admin_obtener_numero_profesionales_administradores_clinica.php?id_clinica=$idClinica"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final count = int.parse(data['count']); // Convertir a entero

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

        Fluttertoast.showToast(
            msg: "passcambiada".tr(),
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

      }
    } catch (e) {
      // Captura cualquier error que ocurra durante la solicitud

    }
  }
  Future<void> cambiarActivoProfesional(String id, String activo) async {
    // URL del script PHP
    String url = URLProyecto+APICarpeta+'actualizar_datos_usuario_cuatro.php'; // Reemplaza con la URL real del script PHP

    // Parámetros a enviar
    Map<String, String> params = {
      'id': id,
      'activo': activo,
    };

    try {
      // Realiza la solicitud POST
      final response = await http.post(Uri.parse(url), body: params);

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (response.statusCode == 200) {
        // Imprime la respuesta del servidor (para depuración)

        activo == "0" ? Fluttertoast.showToast(
            msg: "desactivado".tr(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0):
        Fluttertoast.showToast(
            msg: "activado".tr(),
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

      }
    } catch (e) {
      // Captura cualquier error que ocurra durante la solicitud
      print('Error: $e');
    }
  }
  Future<void> cambiarEstadoEquipo(String id, String disponibilidad) async {
    // URL del script PHP
    String url = URLProyecto+APICarpeta+'actualizar_datos_estado_equipo.php'; // Reemplaza con la URL real del script PHP

    // Parámetros a enviar
    Map<String, String> params = {
      'id': id,
      'equipo_disponible': disponibilidad,
    };

    try {
      // Realiza la solicitud POST
      final response = await http.post(Uri.parse(url), body: params);

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (response.statusCode == 200) {
        // Imprime la respuesta del servidor (para depuración)

        disponibilidad== "0" ? Fluttertoast.showToast(
            msg: "dispositivoretirado".tr(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0):
        Fluttertoast.showToast(
            msg: "activado".tr(),
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
  Future<void> quitarProfesionalFromClinica(String id_profesional, String id_clinica) async {
    // URL del script PHP
    String url = URLProyecto+APICarpeta+'eliminar_profesional_clinica.php'; // Reemplaza con la URL real del script PHP

    // Parámetros a enviar
    Map<String, String> params = {
      'id_profesional': id_profesional,
      'id_clinica': id_clinica,
    };

    try {
      // Realiza la solicitud POST
      final response = await http.post(Uri.parse(url), body: params);

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (response.statusCode == 200) {
        // Imprime la respuesta del servidor (para depuración)



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
  Future<void> quitarAdministradorFromClinica(String id_profesional, String id_clinica) async {
    // URL del script PHP
    String url = URLProyecto+APICarpeta+'eliminar_administrador_clinica.php'; // Reemplaza con la URL real del script PHP

    // Parámetros a enviar
    Map<String, String> params = {
      'id_profesional': id_profesional,
      'id_clinica': id_clinica,
    };

    try {
      // Realiza la solicitud POST
      final response = await http.post(Uri.parse(url), body: params);

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (response.statusCode == 200) {
        // Imprime la respuesta del servidor (para depuración)



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

