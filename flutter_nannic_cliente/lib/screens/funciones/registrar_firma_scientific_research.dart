import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:http/http.dart' as http;

Future<void> registrarConsentimientoScientificResearch({
  required String idPaciente,
  required String firmaConsent,
  required String fechaFirmas,
}) async {
  final url = Uri.parse(URLProyecto+APICarpeta+"registrar_firma_scientific_research.php");
  print("firma consent id_paciente ${idPaciente}");
  print("firma consent archivo ${firmaConsent}");
  print("firma consent fecha ${fechaFirmas}");

  try {
    final response = await http.post(
      url,
      body: {
        'id_paciente': idPaciente,
        'firma_consent': firmaConsent,
        'fecha_firmas': fechaFirmas,
      },
    );

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
