import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/clinica_modelo.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/nueva_clinica_content.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/tab_administradores_clinica.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/tab_datos_clinica.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/tab_pacientes_clinica.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/tab_profesionales_clinica.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_nannic_cliente/screens/perfil/perfil_content.dart';
import 'package:flutter_nannic_cliente/screens/plantilla/plantilla_content.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_content.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

class DetalleClinicaScreen extends StatefulWidget {
  const DetalleClinicaScreen({Key? key,  required this.clinicaId, required this.clinicaNombre, required this.clinicaEmail, required this.clinicaDireccion, required this.clinicaLogo, required this.clinicaPais, required this.clinicaTel}) : super(key: key);

  final String clinicaId;
  final String clinicaNombre;
  final String clinicaEmail;
  final String clinicaDireccion;
  final String clinicaLogo;
  final String clinicaPais;
  final String clinicaTel;

  @override
  State<DetalleClinicaScreen> createState() => _DetalleClinicaScreenState();
}

class _DetalleClinicaScreenState extends State<DetalleClinicaScreen> with SingleTickerProviderStateMixin {
  late String emailUsuario = "";

  late TabController _tabController;
  late List<Clinica> clinicaActual ;

  String emailClinica = "";
  String nombreClinica = "";
  String direccionClinica = "";
  String telClinica = "";
  String paisClinica = "";
  String logoClinica = "";
  String nombreClinicaSup = "";





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    capturarDatosUsuario();

   // nombreClinicaSup = widget.clinicaNombre!;
    _tabController = TabController(length: 4, vsync: this);
    obtenerClinicasDatosClinica();
  }
  Future<void> obtenerClinicasDatosClinica() async {
    String urlAPI =
        URLProyecto + APICarpeta + "admin_obtener_datos_clinica_actual.php?id="+widget.clinicaId!;
    final url = Uri.parse(urlAPI);
    final response = await http.get(url);


    if (response.statusCode == 200) {

      final List<dynamic> jsonResponse = json.decode(response.body);
      clinicaActual = jsonResponse.map((data) => Clinica.fromJson(data)).toList();

      setState(() {
        emailClinica = clinicaActual[0].nombre_clinica!;
        paisClinica = clinicaActual[0].pais_clinica!;
        direccionClinica = clinicaActual[0].direccion_clinica!;
        emailClinica = clinicaActual[0].email_clinica!;
        telClinica = clinicaActual[0].tel_clinica!;
        logoClinica = clinicaActual[0].logo_clinica!;
        nombreClinica = clinicaActual[0].nombre_clinica!;



      });
    } else {
      throw Exception('Error al obtener las clinicas');
    }
  }

  void capturarDatosUsuario() async {
    DatosUsuario datos = await obtenerDatosUsuario();

    emailUsuario = datos.email;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,

          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: appPadding,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: Icon( Icons.arrow_back_ios),),
                      SizedBox(width: appPadding,),
                      Container(
                        width: 250,
                          child: MiTextoSimple(texto: nombreClinica!, color: Colors.grey, fontWeight: FontWeight.bold, fontsize: 24))
                    ],
                  ),
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey, // Color del texto de la pestaña cuando no está seleccionada
                    labelColor: Colors.black, // Color del texto de la pestaña cuando está seleccionada

                    tabs: [
                      Tab(text: 'datosclinica'.tr(),icon: Icon(Icons.abc),),
                      Tab(text: 'profesionales'.tr(),icon: Icon(Icons.person),),
                      Tab(text: 'administrators'.tr(),icon: Icon(Icons.settings)),
                      Tab(text: 'pacientes'.tr(),icon: Icon(Icons.emoji_people)),

                    ],
                  ),
                  SizedBox(height: 20), // Espacio entre el TabBar y el TabBarView
                  // Contenido de las pestañas
                  Container(
                    height: MediaQuery.of(context).size.height, // Altura arbitraria para el contenido del TabBarView
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Contenido de la pestaña 1
                        TabDatosClinica(clinicaId: widget.clinicaId!,clinicaDireccion: widget.clinicaDireccion!,clinicaEmail: widget.clinicaEmail!,clinicaLogo: widget.clinicaLogo!,clinicaNombre: widget.clinicaNombre!,clinicaPais: widget.clinicaPais!,clinicaTel: widget.clinicaTel!,),
                        // Contenido de la pestaña 2
                        TabProfesionalesClinica(clinicaId: widget.clinicaId!,clinicaDireccion: widget.clinicaDireccion!,clinicaEmail: widget.clinicaEmail!,clinicaLogo: widget.clinicaLogo!,clinicaNombre: widget.clinicaNombre!,clinicaPais: widget.clinicaPais!,clinicaTel: widget.clinicaTel!,),
                        // Contenido de la pestaña 3
                        TabAdministradoresClinica(clinicaId: widget.clinicaId!,clinicaDireccion: widget.clinicaDireccion!,clinicaEmail: widget.clinicaEmail!,clinicaLogo: widget.clinicaLogo!,clinicaNombre: widget.clinicaNombre!,clinicaPais: widget.clinicaPais!,clinicaTel: widget.clinicaTel!,),
                        // Contenido de la pestaña 4
                        TabPacientesClinica(clinicaId: widget.clinicaId!,clinicaDireccion: widget.clinicaDireccion!,clinicaEmail: widget.clinicaEmail!,clinicaLogo: widget.clinicaLogo!,clinicaNombre: widget.clinicaNombre!,clinicaPais: widget.clinicaPais!,clinicaTel: widget.clinicaTel!,),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

      ),
    );
  }
}

_onBackButtonPressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Cerrar la app?"),
          content: Text("¿Realmente quieres cerrar la app?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Si"))
          ],
        );
      });
  return exitApp ?? false;
}
