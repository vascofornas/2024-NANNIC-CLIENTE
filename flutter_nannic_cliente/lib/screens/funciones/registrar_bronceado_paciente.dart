import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:http/http.dart' as http;

Future<void> registrarBronceadoPaciente({
  required String idPaciente,
  required String valor,
  required String fechaActualizacion,
}) async {
  final url = Uri.parse(URLProyecto+APICarpeta+"registrar_bronceado_paciente.php");

  await Future.delayed(Duration(seconds: 3)); // Simula un retraso para la operación



  try {
    final response = await http.post(
      url,
      body: {
        'id_paciente': idPaciente,
        'valor': valor,
        'fecha_actualizacion': fechaActualizacion,
      },
    );
    print("respuesta suplementos ${response.body}");
    final responseData = json.decode(response.body);
    if (responseData['success']) {
      // Manejar éxito
      print('Datos insertados correctamente');
    } else {
      // Manejar error
      print('Error al insertar datos: ${responseData['message']}');
    }
  } catch (error) {
    // Manejar error de red
    print('Error de red: $error');
  }
}
