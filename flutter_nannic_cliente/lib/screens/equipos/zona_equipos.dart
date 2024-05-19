import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/models/clinica_modelo.dart';
import 'package:flutter_nannic_cliente/models/equipo_modelo.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/clinica_card.dart';
import 'package:flutter_nannic_cliente/screens/equipos/equipo_card.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesional_card.dart';
import 'package:http/http.dart' as http;

class ZonaEquipos extends StatefulWidget {
  const ZonaEquipos({Key? key, required this.onActualizarEstado, required this.clinicaId,  }) : super(key: key);
  final VoidCallback onActualizarEstado; // Tipo de la función de actualización
  final String clinicaId;





  @override
  _ZonaEquiposState createState() => _ZonaEquiposState();
}

class _ZonaEquiposState extends State<ZonaEquipos> {
  List<Equipo> _equipos = [];
  List<Equipo> _filteredEquipos = [];
  String clinicaActual = "";


  @override
  void initState() {
    super.initState();
    getIdClinica();
  }

  actualizarEquipos(){
    getIdClinica();
  }
  getIdClinica() async {
    clinicaActual = (await SharedPrefsHelper.getIdClinica())!;


    obtenerEquipos(clinicaActual);
  }

  Future<void> obtenerEquipos(String id_clinica) async {
    print("estoy actualizando equipos en zona equipos");
    String urlAPI =
        URLProyecto + APICarpeta + "admin_obtener_equipos_todos_clinica.php?id_clinica=$id_clinica";
    print("url obtener equipos ${urlAPI}");
    final url = Uri.parse(urlAPI);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      print("lista equipos ${jsonResponse}");
      setState(() {
        _equipos = jsonResponse.map((data) => Equipo.fromJson(data)).toList();
        _filteredEquipos = _equipos;
      });
    } else {
      throw Exception('Error al obtener los equipos');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  void filtrarEquipos(String query) {
    setState(() {
      _filteredEquipos = _equipos.where((equipo) {
        final nombreMatch = equipo.nombre_equipo?.toLowerCase().contains(query.toLowerCase()) ?? false;
        final numSerieMatch = equipo.num_serie?.toLowerCase().contains(query.toLowerCase()) ?? false;

        return nombreMatch || numSerieMatch ;
      }).toList();
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
            "zonaequipos".tr(),
            style: AppFonts.nannic(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(height: 16),
          // Campo de búsqueda
          TextField(
            onChanged: filtrarEquipos,
            style: AppFonts.nannic(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
            decoration: InputDecoration(
              labelText: 'buscarequipos'.tr(),
              labelStyle: AppFonts.nannic(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: _filteredEquipos.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredEquipos.length,
                    itemBuilder: (context, index) {
                      final equipo = _filteredEquipos[index];
                      return EquipoCard(
                        equipo: equipo,
                        onActualizarEstado: actualizarEquipos,
                        clinicaid: widget.clinicaId,);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
