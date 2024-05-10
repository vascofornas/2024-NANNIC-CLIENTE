import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/zona_administradores_clinica/nuevo_administrador_clinica/nuevo_administrador_clinica_screen.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/zona_profesionales_clinica/nuevo_profesional_clinica/nuevo_profesional_clinica_screen.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/funciones/eliminar_admininistrador_de_clinica_icon_button.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_screen.dart';
import 'package:http/http.dart' as http;

class ContenidoAdministradoresClinica extends StatefulWidget {
  const ContenidoAdministradoresClinica(
      {super.key, required this.clinicaId, required this.clinicaNombre});

  final String clinicaId;
  final String clinicaNombre;

  @override
  State<ContenidoAdministradoresClinica> createState() =>
      _ContenidoAdministradoresClinicaState();
}

class _ContenidoAdministradoresClinicaState
    extends State<ContenidoAdministradoresClinica> {

  List<Profesional> _profesionales = [];
  List<Profesional> _filteredProfesionales = [];

  @override
  void initState() {
    super.initState();
    _fetchProfesionalesAdm();
  }
  void actualizarProfesionalesAdm() {
    setState(() {
      // Llamar a _fetchProfesionalesAdm para actualizar la lista de administradores
      _fetchProfesionalesAdm();
    });
  }

  Future<void> _fetchProfesionalesAdm() async {

    final url = URLProyecto +
        APICarpeta +
        'obtener_administradores_clinica.php'; // Reemplazar con la URL de tu script PHP
    final response = await http.post(
      Uri.parse(url),
      body: {'clinicaId': widget.clinicaId},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<dynamic> jsonResponse = json.decode(response.body);

      setState(() {
        _profesionales =
            jsonResponse.map((data) => Profesional.fromJson(data)).toList();
        _filteredProfesionales = _profesionales;
      });
    } else {
      // Si la solicitud falla, manejar el error

      throw Exception('Failed to load data');
    }
  }

  void filtrarProfesionales(String query) {
    setState(() {

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
                        builder: (context) => NuevoAdministradorClinicaPage(
                              clinicaId: widget.clinicaId,
                              clinicaNombre: widget.clinicaNombre,
                            )),
                  ).then((value) {
                    setState(() {
                      _fetchProfesionalesAdm();
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
                              child: EliminarAdministradorClinicaIconButton(
                                profesionalId: profesional.id,
                                clinicaId: widget.clinicaId,
                                profesionalNombre: profesional.nombre,
                                onUpdate: actualizarProfesionalesAdm,
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
                texto: 'clinicasinadministradores'.tr(),
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
