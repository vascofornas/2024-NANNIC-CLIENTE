import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/paciente_card.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesional_card.dart';
import 'package:http/http.dart' as http;

class ZonaPacientes extends StatefulWidget {
  const ZonaPacientes({Key? key, }) : super(key: key);


  @override
  _ZonaPacientesState createState() => _ZonaPacientesState();
}

class _ZonaPacientesState extends State<ZonaPacientes> {

  List<Paciente> _pacientes = [];
  List<Paciente> _filteredPacientes = [];
  String idClinica = "";
  late Timer _timer;


  @override
  void initState() {
    super.initState();
    cargarPacientes();

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      cargarPacientes();
      print("actualizando pacientes");


    });

  }

  cargarPacientes() async {

     idClinica = (await SharedPrefsHelper.getIdClinica())! ;

    obtenerPacientes(idClinica as String);
  }

  Future<void> obtenerPacientes(String clinicaId) async {

    String urlAPI =
        URLProyecto + APICarpeta + "obtener_pacientes_clinica_actual.php?clinicaId=${clinicaId}";
    final url = Uri.parse(urlAPI);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        _pacientes =
            jsonResponse.map((data) => Paciente.fromJson(data)).toList();
        _filteredPacientes = _pacientes;
      });
    } else {
      throw Exception('Error al obtener los pacientes');
    }
  }

  void filtrarPacientes(String query) {
    setState(() {
      _filteredPacientes = _pacientes
          .where((paciente) =>
              paciente.nombre!.toLowerCase().contains(query.toLowerCase()) ||
                  paciente.email_paciente!.toLowerCase().contains(query.toLowerCase())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3800,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "zonapacientes".tr(),
            style: AppFonts.nannic(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey

            ),
          ),
          SizedBox(height: 16),
          // Campo de búsqueda
          TextField(
            onChanged: filtrarPacientes,
            style: AppFonts.nannic(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey

            ),
            decoration: InputDecoration(
              labelText: 'buscarpacientes'.tr(),
              labelStyle: AppFonts.nannic(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey

              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: _filteredPacientes.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredPacientes.length,
                    itemBuilder: (context, index) {
                      final paciente = _filteredPacientes[index];
                      return PacienteCard(paciente: paciente);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
