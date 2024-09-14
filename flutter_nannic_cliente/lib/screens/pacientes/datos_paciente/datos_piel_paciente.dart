import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/paciente_datos_piel_modelo.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/skinselector/skin_pores_selector.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/skinselector/skin_selector.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class DatosPielPaciente extends StatefulWidget {
  const DatosPielPaciente({super.key, required this.paciente});
  final Paciente paciente;

  @override
  State<DatosPielPaciente> createState() => _DatosPielPacienteState();
}

class _DatosPielPacienteState extends State<DatosPielPaciente> {
  String skin_type = "0";
  String skin_pores_type = "0";
  bool isLoading = true; // Variable para indicar si los datos están siendo cargados

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> refreshData() async {
    final pacienteDatosPiel = await fetchPacienteDatosPiel(widget.paciente.id_paciente!);
    print("refrescando datos en datos piel");

    if (pacienteDatosPiel != null) {
      setState(() {
        skin_type = pacienteDatosPiel.skin_type ?? "0";
        skin_pores_type = pacienteDatosPiel.pores ?? "0";
        print("skin type recibido ${pacienteDatosPiel.skin_type} ${skin_type}");
        isLoading = false; // Datos cargados, desactivar indicador de carga
      });
    } else {
      print("refrescando datos en datos piel NULL");
      setState(() {
        isLoading = false; // Datos cargados, desactivar indicador de carga incluso si es null
      });
    }
  }

  Future<PacienteDatosPiel?> fetchPacienteDatosPiel(String idPaciente) async {
    final url = URLProyecto + APICarpeta + "obtener_datos_piel_paciente_clinica.php"; // URL de tu script PHP

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'id_paciente': idPaciente}, // Parámetros enviados al script PHP
      );

      print("respuesta datos piel paciente clinica --> ${response.body}");
      print("response.statusCode recibido en datos piel paciente clinica --> ${response.statusCode}");

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return PacienteDatosPiel.fromJson(parsed);
      } else {
        throw Exception('Error al cargar los datos del paciente');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(appPadding),
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // Muestra un indicador de carga mientras los datos se cargan
                : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "skinanalysis".tr(),
                        style: AppFonts.nannic(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "skintype".tr(),
                        style: AppFonts.nannic(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Spacer(),
                      Container(
                        width: 200,
                        height: 300,
                        child: SkinTypeSelector(
                          pacienteId: widget.paciente.id_paciente!,
                          skinTypeRecibido: skin_type,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "skinpores".tr(),
                        style: AppFonts.nannic(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Spacer(),
                      Container(
                        width: 200,
                        height: 200,
                        child: SkinPoresSelector(
                          pacienteId: widget.paciente.id_paciente!,
                          skinPoresTypeRecibido: skin_pores_type,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "skinreactivity".tr(),
                        style: AppFonts.nannic(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "skinbloodflow".tr(),
                        style: AppFonts.nannic(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "skinsensitivity".tr(),
                        style: AppFonts.nannic(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "skinexcessivehair".tr(),
                        style: AppFonts.nannic(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "skinsensitivityUV".tr(),
                        style: AppFonts.nannic(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
