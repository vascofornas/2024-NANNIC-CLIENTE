import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/models/clinica_modelo.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/clinica_card.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesional_card.dart';
import 'package:http/http.dart' as http;

class ZonaClinicas extends StatefulWidget {
  const ZonaClinicas({Key? key}) : super(key: key);

  @override
  _ZonaClinicasState createState() => _ZonaClinicasState();
}

class _ZonaClinicasState extends State<ZonaClinicas> {
  List<Clinica> _clinicas = [];
  List<Clinica> _filteredClinicas = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    obtenerClinicas();

  }

  Future<void> obtenerClinicas() async {
    String urlAPI =
        URLProyecto + APICarpeta + "admin_obtener_clinicas_todas.php";
    final url = Uri.parse(urlAPI);
    final response = await http.get(url);

    if (response.statusCode == 200) {

      final List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        _clinicas =
            jsonResponse.map((data) => Clinica.fromJson(data)).toList();
        _filteredClinicas = _clinicas;

      });
    } else {
      throw Exception('Error al obtener las clinicas');
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  void filtrarClinicas(String query) {
    setState(() {
      _filteredClinicas = _clinicas
          .where((clinicas) =>
              clinicas.nombre_clinica!.toLowerCase().contains(query.toLowerCase()) ||
              clinicas.email_clinica!.toLowerCase().contains(query.toLowerCase()) ||
                  clinicas.direccion_clinica!.toLowerCase().contains(query.toLowerCase()) ||
                  clinicas.pais_clinica!.toLowerCase().contains(query.toLowerCase()) ||

              (clinicas.tel_clinica?.toLowerCase() ?? '').contains(query.toLowerCase())
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
            "zonaclinicas".tr(),
            style: AppFonts.nannic(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.grey

            ),
          ),
          SizedBox(height: 16),
          // Campo de búsqueda
          TextField(
            onChanged: filtrarClinicas,
            style: AppFonts.nannic(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey

            ),
            decoration: InputDecoration(
              labelText: 'buscarclinicas'.tr(),
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
            child: _filteredClinicas.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredClinicas.length,
                    itemBuilder: (context, index) {
                      final clinica = _filteredClinicas[index];
                      return ClinicaCard(clinica: clinica);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
