import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/zona_administradores_clinica/nuevo_administrador_clinica/nuevo_administrador_clinica_screen.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/zona_profesionales_clinica/nuevo_profesional_clinica/nuevo_profesional_clinica_screen.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/funciones/eliminar_admininistrador_de_clinica_icon_button.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_screen.dart';
import 'package:http/http.dart' as http;

class ContenidoPacientesClinica extends StatefulWidget {
  const ContenidoPacientesClinica(
      {super.key, required this.clinicaId, required this.clinicaNombre});

  final String clinicaId;
  final String clinicaNombre;

  @override
  State<ContenidoPacientesClinica> createState() =>
      _ContenidoPacientesClinicaState();
}

class _ContenidoPacientesClinicaState
    extends State<ContenidoPacientesClinica> {
  List<Paciente> _pacientes = [];
  List<Paciente> _filteredPacientes = [];

  @override
  void initState() {
    super.initState();
    _fetchPacientesClinica();
  }
  void actualizarPacientesClinica() {
    setState(() {
      // Llamar a _fetchProfesionalesAdm para actualizar la lista de administradores
      _fetchPacientesClinica();
    });
  }

  Future<void> _fetchPacientesClinica() async {
    print("clinica id ${widget.clinicaId}");
    final url = URLProyecto +
        APICarpeta +
        'obtener_pacientes_clinica.php'; // Reemplazar con la URL de tu script PHP
    final response = await http.post(
      Uri.parse(url),
      body: {'clinicaId': widget.clinicaId},
    );

    print ("respuesta pacientes ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<dynamic> jsonResponse = json.decode(response.body);
      print("respuesta profesionales clinica ${data.toString()}");
      setState(() {
        _pacientes =
            jsonResponse.map((data) => Paciente.fromJson(data)).toList();
        _filteredPacientes = _pacientes;
      });
    } else {
      // Si la solicitud falla, manejar el error
      print("Error en la solicitud: ${response.body}");
      throw Exception('Failed to load data');
    }
  }
  void filtrarPacientes(String query) {
    setState(() {
      print("buscando pacientes clinica ${query}");
      _filteredPacientes = _pacientes
          .where((pacientes) =>
      pacientes.nombre!
          .toLowerCase()
          .contains(query.toLowerCase()) ||
          pacientes.email_paciente!
              .toLowerCase()
              .contains(query.toLowerCase()) )
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Campo de búsqueda
          TextField(
            onChanged: filtrarPacientes,
            style: AppFonts.nannic(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
            decoration: InputDecoration(
              labelText: 'buscarpacientes'.tr(),
              labelStyle: AppFonts.nannic(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
              prefixIcon: Icon(Icons.search),
            ),
          ),

          if (_pacientes.isNotEmpty)
            Container(
              height: MediaQuery.of(context).size.height *
                  0.7, // ajusta la altura según sea necesario
              child: ListView.builder(
                itemCount: _filteredPacientes.length,
                itemBuilder: (context, index) {
                  final paciente = _filteredPacientes[index];
                  return Card(
                    elevation: 6,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            AvatarFromUrl(
                              imageUrl:
                                  '${carpetaAdminPacientes}${paciente.imagen_paciente ?? ''}',
                              size: 45,
                            ),
                            SizedBox(
                              width: appPadding,
                            ),
                            MiTextoSimple(
                              texto: paciente.nombre!,
                              color: Colors.grey,
                              fontWeight: FontWeight.w900,
                              fontsize: 16,
                            ),

                          ],
                        ),

                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [


                            Icon(Icons.email,color: Colors.grey,size: 14,),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: MiTextoSimple(
                                texto: paciente.email_paciente!,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontsize: 12,
                              ),
                            ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Icon(Icons.phone,color: Colors.grey,size: 14,),
                        ),
                            MiTextoSimple(
                              texto: paciente.tel_paciente!,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontsize: 12,
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),
          if (_pacientes.isEmpty)
            SizedBox(
              height: appPadding,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MiTextoSimple(
                texto: 'sinpacientes'.tr(),
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
