import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
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

  String clinicaActual = "";

  @override
  void initState() {
    super.initState();
   getIdClinica();

  }
  getIdClinica() async {
    clinicaActual = (await SharedPrefsHelper().getIdClinica())!;

    print("clinica actual en zona profesionales ${clinicaActual}");
    obtenerProfesionales(clinicaActual);
  }


  Future<void> obtenerProfesionales(String clinica) async {
    // Obtener id_clinica desde SharedPrefsHelper
    final String? idClinica = await SharedPrefsHelper().getIdClinica();
    print("idClinica en profesionales $idClinica");

    // Verificar que id_clinica no esté vacío
    if (idClinica != null && idClinica.isNotEmpty) {
      // Construir URL de la API
      String urlAPI = URLProyecto+APICarpeta+"admin_obtener_profesionales_todos_clinica.php?id_clinica=$clinica";
      print("urlAPI ${urlAPI}");
      final url = Uri.parse(urlAPI);

      try {
        // Hacer la solicitud HTTP GET
        final response = await http.get(url);

        // Verificar el código de estado de la respuesta
        if (response.statusCode == 200) {
          // Decodificar la respuesta JSON
          final dynamic jsonResponse = json.decode(response.body);

          // Verificar si la respuesta es un mapa o una lista
          if (jsonResponse is List) {
            // Es una lista
            setState(() {
              _profesionales = jsonResponse.map((data) => Profesional.fromJson(data as Map<String, dynamic>)).toList();
              _filteredProfesionales = _profesionales;
            });
          } else if (jsonResponse is Map<String, dynamic>) {
            // Es un mapa, posiblemente un único objeto o un mensaje de error
            if (jsonResponse.containsKey('error')) {
              // Manejar el error si está presente en el JSON
              throw Exception('Error del servidor: ${jsonResponse['error']}');
            } else {
              // Manejar como un mapa general, en este caso, asumimos que contiene datos de profesionales
              setState(() {
                _profesionales = [Profesional.fromJson(jsonResponse)];
                _filteredProfesionales = _profesionales;
              });
            }
          } else {
            throw Exception('Respuesta inesperada del servidor');
          }
        } else {
          // Lanzar una excepción si la solicitud no fue exitosa
          throw Exception('Error al obtener los profesionales');
        }
      } catch (e) {
        // Manejar cualquier excepción que ocurra durante la solicitud
        print('Error: $e');
      }
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
