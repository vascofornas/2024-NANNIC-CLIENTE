import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/zona_profesionales_clinica/nuevo_profesional_clinica/nuevo_profesional_clinica_screen.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_pass_profesional_icon_button.dart';
import 'package:flutter_nannic_cliente/screens/funciones/eliminar_profesional_de_clinica_icon_button.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_screen.dart';
import 'package:http/http.dart' as http;

class ContenidoProfesionalesClinica extends StatefulWidget {
  const ContenidoProfesionalesClinica(
      {super.key, required this.clinicaId, required this.clinicaNombre});

  final String clinicaId;
  final String clinicaNombre;

  @override
  State<ContenidoProfesionalesClinica> createState() =>
      _ContenidoProfesionalesClinicaState();
}

class _ContenidoProfesionalesClinicaState
    extends State<ContenidoProfesionalesClinica> {
  List<Profesional> _profesionales = [];
  List<Profesional> _filteredProfesionales = [];
  //late List<Map<String, dynamic>> _profesionales = [];

  @override
  void initState() {
    super.initState();
    _fetchProfesionales();
  }

  void actualizarProfesionales() {
    setState(() {
      // Llamar a _fetchProfesionales para actualizar la lista de profesionales
      _fetchProfesionales();
    });
  }

  Future<void> _fetchProfesionales() async {
    print("clinica id ${widget.clinicaId}");
    final url = URLProyecto +
        APICarpeta +
        'obtener_profesionales_clinica.php'; // Reemplazar con la URL de tu script PHP
    final response = await http.post(
      Uri.parse(url),
      body: {'clinicaId': widget.clinicaId},
    );

    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, analizar la respuesta
      final List<dynamic> data = json.decode(response.body);
      final List<dynamic> jsonResponse = json.decode(response.body);
      print("respuesta profesionales clinica ${data.toString()}");
      setState(() {
        _profesionales =
            jsonResponse.map((data) => Profesional.fromJson(data)).toList();
        _filteredProfesionales = _profesionales;
      });
    } else {
      // Si la solicitud falla, manejar el error
      print("Error en la solicitud: ${response.body}");
      throw Exception('Failed to load data');
    }
  }

  void filtrarProfesionales(String query) {
    setState(() {
      print("buscando pro clinica ${query}");
      _filteredProfesionales = _profesionales
          .where((profesionales) =>
              profesionales.nombre!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              profesionales.apellidos!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              profesionales.email!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  // Action to be performed on FAB tap
                  //abrir pantalla nuevo profesional
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NuevoProfesionalClinicaPage(
                              clinicaId: widget.clinicaId,
                              clinicaNombre: widget.clinicaNombre,
                            )),
                  ).then((value) {
                    setState(() {
                      _fetchProfesionales();
                    });
                  });
                },
                child: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                splashColor: Colors.white,
              ),
            ],
          ),
          // Campo de búsqueda
          TextField(
            onChanged: filtrarProfesionales,
            style: AppFonts.nannic(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
            decoration: InputDecoration(
              labelText: 'buscarprofesionales'.tr(),
              labelStyle: AppFonts.nannic(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 16),
          if (_profesionales.isNotEmpty)
            Container(
              height: MediaQuery.of(context).size.height *
                  0.7, // ajusta la altura según sea necesario
              child: ListView.builder(
                itemCount: _filteredProfesionales.length,
                itemBuilder: (context, index) {
                  final profesional = _filteredProfesionales[index];
                  return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            AvatarFromUrl(
                              imageUrl:
                                  '${carpetaAdminUsuarios}${profesional.imagen ?? ''}',
                              size: 45,
                            ),
                            SizedBox(
                              width: appPadding,
                            ),
                            MiTextoSimple(
                              texto: profesional.nombre! +
                                  " " +
                                  profesional.apellidos!,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontsize: 16,
                            ),
                            Spacer(),
                            //borrar usuario
                            Center(
                              child: EliminarProfesionalClinicaIconButton(
                                profesionalId: profesional.id,
                                clinicaId: widget.clinicaId,
                                profesionalNombre: profesional.nombre,
                                onUpdate: actualizarProfesionales,
                              ),
                            ),
                          ],
                        ),
                        subtitle: MiTextoSimple(
                          texto: profesional.email!,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontsize: 16,
                        ),
                      ));
                },
              ),
            ),
          if (_profesionales.isEmpty)
            SizedBox(
              height: appPadding,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MiTextoSimple(
                texto: 'clinicasinprofesionales'.tr(),
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontsize: 18,
              ),
            ],
          )
        ],
      ),
    );
  }
}
