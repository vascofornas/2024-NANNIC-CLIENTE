import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/models/clinica_modelo.dart';
import 'package:flutter_nannic_cliente/models/equipo_modelo.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/providers/usuario_provider.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/detalle_clinica_screen.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/equipos/edit_equipo_screen.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_imagen_equipo_icon_button.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_pass_profesional_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EquipoCard extends StatefulWidget {
  const EquipoCard({super.key, required this.equipo, required this.onActualizarEstado, required this.clinicaid});

  final Equipo equipo;
  final String clinicaid;

  final VoidCallback onActualizarEstado; // Tipo de la función de actualización

  @override
  State<EquipoCard> createState() => _EquipoCardState();
}

class _EquipoCardState extends State<EquipoCard> {
  bool usuarioActivo = false;
  bool usuarioAceptaTerms = false;
  bool isAvailable = false;
  bool equipoDisponible = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAvailable = widget.equipo.disponible == '1';
    equipoDisponible = isAvailable;


  }

  String convertDate(String date) {
    // Parse the original date string
    DateTime parsedDate = DateTime.parse(date);

    // Format the date into the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);

    return formattedDate;
  }
  Future<void> updateEquipoDisponibilidad(String equipoId, String disponibilidad) async {
    final url = URLProyecto+APICarpeta+"actualizar_disponibilidad_equipo_clinica.php"; // Reemplaza con la URL correcta de tu API

    print("equipoId ${equipoId}");
    print("disponibilidad ${disponibilidad}");
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': equipoId,
        'disponible': disponibilidad,
      }),
    );
    print("respuesta actualizar disponibilidad equipo ${response.body}");
    // Actualizar el estado del equipo en la interfaz de usuario
    setState(() {
      print("la disponibilidad es ${disponibilidad}");
      widget.equipo.disponible = disponibilidad;
      if(disponibilidad == "1"){
        isAvailable = true;
      }
      else{
        isAvailable = false;
      }
    });



    if (response.statusCode != 200) {
      throw Exception('Failed to update equipo disponibilidad');
    }
  }

  void _toggleAvailability(bool? newValue) async {
    setState(() {
      isAvailable = newValue ?? false;
      if (isAvailable){
        equipoDisponible = true;
      }
      else{
        equipoDisponible = false;
      }
    });

    try {
      await updateEquipoDisponibilidad(
        widget.equipo.id!,
        isAvailable ? '1' : '0',
      );
      setState(() {
        widget.equipo.disponible = isAvailable ? '1' : '0';
      });
      widget.onActualizarEstado(); // Notifica a ZonaEquipos que necesita actualizar la lista de equipos
    } catch (e) {
      setState(() {
        isAvailable = !isAvailable;// Revert the change if the update fails
      });
      // Handle error, e.g., show a Snackbar

    }
  }


  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: (){


      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //imagen+nombre
              Row(
                children: [
                  AvatarFromUrl(
                    imageUrl:
                        '${carpetaAdminEquipos}${widget.equipo.imagen_equipo ?? ''}',
                    size: 60,
                  ),


                  Spacer(),
                  Center(
                    child: Row(
                      children: [

                        Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                widget.equipo.nombre_equipo ?? 'Sin nombre',
                                maxLines: 2,
                                style: AppFonts.nannic(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey),
                              ),
                            )),
                         ],
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: 20,
                      child: Center(
                        child: Text(
                          'S/N: ${widget.equipo.num_serie ?? 'Sin número de serie'}',

                          style: AppFonts.nannic(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      )),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Container(
                      height: 40,
                      child: Center(
                        child: Text("fechaaltaequiponannic".tr()+": "+convertDate(widget.equipo.fecha_alta!),
                          style: AppFonts.nannic(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ))

                ],
              ),
              Row(
                children: [
                  Text(
                    'disponibilidad'.tr(),
                    style: AppFonts.nannic(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Checkbox(
                    value: equipoDisponible,
                    onChanged: _toggleAvailability,
                  ),
                  equipoDisponible ?Text(
                    'disponible'.tr() ,
                    style: AppFonts.nannic(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),  ):
                  Text(
                    'nodisponible'.tr(),
                    style: AppFonts.nannic(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),  ),
                ],
              ),
              
                         ],
          ),
        ),
      ),
    );
  }
}
