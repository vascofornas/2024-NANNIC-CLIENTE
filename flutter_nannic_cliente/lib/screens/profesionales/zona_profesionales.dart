import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesional_card.dart';
import 'package:http/http.dart' as http;

class ZonaProfesionales extends StatefulWidget {
  const ZonaProfesionales({Key? key}) : super(key: key);

  @override
  _ZonaProfesionalesState createState() => _ZonaProfesionalesState();
}

class _ZonaProfesionalesState extends State<ZonaProfesionales> {
  List<Profesional> _profesionales = [];
  List<Profesional> _filteredProfesionales = [];

  @override
  void initState() {
    super.initState();
    obtenerProfesionales();
  }

  Future<void> obtenerProfesionales() async {
    String urlAPI =
        URLProyecto + APICarpeta + "admin_obtener_profesionales_todos.php";
    final url = Uri.parse(urlAPI);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        _profesionales =
            jsonResponse.map((data) => Profesional.fromJson(data)).toList();
        _filteredProfesionales = _profesionales;
      });
    } else {
      throw Exception('Error al obtener los profesionales');
    }
  }

  void filtrarProfesionales(String query) {
    setState(() {
      _filteredProfesionales = _profesionales
          .where((profesional) =>
              profesional.nombre!.toLowerCase().contains(query.toLowerCase()) ||
              profesional.apellidos!.toLowerCase().contains(query.toLowerCase()) ||
              profesional.email!.toLowerCase().contains(query.toLowerCase()) ||
                  profesional.so_dispositivo!.toLowerCase().contains(query.toLowerCase()) ||
                  profesional.version_app!.toLowerCase().contains(query.toLowerCase()) ||
              (profesional.tel?.toLowerCase() ?? '').contains(query.toLowerCase())
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
            "zonaprofesionales".tr(),
            style: AppFonts.nannic(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey

            ),
          ),
          SizedBox(height: 16),
          // Campo de búsqueda
          TextField(
            onChanged: filtrarProfesionales,
            style: AppFonts.nannic(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey

            ),
            decoration: InputDecoration(
              labelText: 'buscarprofesionales'.tr(),
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
            child: _filteredProfesionales.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredProfesionales.length,
                    itemBuilder: (context, index) {
                      final profesional = _filteredProfesionales[index];
                      return ProfesionalCard(profesional: profesional);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
