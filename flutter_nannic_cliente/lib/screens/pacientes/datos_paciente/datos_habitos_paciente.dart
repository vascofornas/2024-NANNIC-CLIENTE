import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_button.dart';
import 'package:flutter_nannic_cliente/components/my_textfield.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/components/no_widget.dart';
import 'package:flutter_nannic_cliente/components/yes_widget.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/paciente_datos_habitos_modelo.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class DatosHabitosPaciente extends StatefulWidget {
  const DatosHabitosPaciente({super.key, required this.paciente});
  final Paciente paciente;

  @override
  State<DatosHabitosPaciente> createState() => _DatosHabitosPacienteState();
}

class _DatosHabitosPacienteState extends State<DatosHabitosPaciente>  {

  bool suplementos_alimenticios = false;
  bool tipo_alimentacion = false;
  bool fuma = false;
  bool bebe_alcohol = false;
  bool desorden_alimenticio = false;
  bool trastorno_sueno = false;
  bool bronceado = false;
  bool circunstancias_laborales_especificas = false;

  TextEditingController _observacionesController = TextEditingController();



  @override
  void initState() {
    super.initState();
    refreshData();

  }

  refreshData() {
    fetchPacienteDatosHabitos(widget.paciente.id_paciente!)
        .then((pacienteDatosHabitos) {
      print("refrescando datos en datos habitps");
      if (pacienteDatosHabitos == null) {
      } else {
        // Procesar los datos habitos del paciente


        //suplementos alimenticios
        if (pacienteDatosHabitos.suplementos_alimenticios == "1") {
          suplementos_alimenticios = true;
          setState(() {});
        }
        else{
          suplementos_alimenticios = false;
          setState(() {});
        }
        //tipo_alimentacion
        if (pacienteDatosHabitos.tipo_alimentacion == "1") {
          tipo_alimentacion = true;
          setState(() {});
        }
        else{
          tipo_alimentacion = false;
          setState(() {});
        }
        //fuma
        if (pacienteDatosHabitos.fuma == "1") {
          fuma = true;
          setState(() {});
        }
        else{
          fuma = false;
          setState(() {});
        }
        //bebe alcohol
        if (pacienteDatosHabitos.bebe_alcohol == "1") {
          bebe_alcohol = true;
          setState(() {});
        }
        else{
          bebe_alcohol = false;
          setState(() {});
        }
        //desorden alimenticio
        if (pacienteDatosHabitos.desorden_alimenticio == "1") {
          desorden_alimenticio = true;
          setState(() {});
        }
        else{
          desorden_alimenticio = false;
          setState(() {});
        }
        //trastorno_sueno
        if (pacienteDatosHabitos.trastorno_sueno == "1") {
          trastorno_sueno = true;
          setState(() {});
        }
        else{
          trastorno_sueno = false;
          setState(() {});
        }
        //bronceado
        if (pacienteDatosHabitos.bronceado == "1") {
          bronceado = true;
          setState(() {});
        }
        else{
          bronceado = false;
          setState(() {});
        }
        //circunstancias_laborales_especificas
        if (pacienteDatosHabitos.circunstancias_laborales_especificas == "1") {
          circunstancias_laborales_especificas = true;
          setState(() {});
        }
        else{
          circunstancias_laborales_especificas = false;
          setState(() {});
        }

        //observaciones habitos
        _observacionesController.text = pacienteDatosHabitos.observaciones_costumbres!;
        setState(() {

        });

      }
    });
  }

  void mostrarDialogoCambiarObservaciones(BuildContext context, String observaciones) {
    String nuevaMedicacion =
        ''; // Variable para almacenar el nuevo nombre del paciente
    // Crea un TextEditingController con el texto inicial de medicacionActual
    TextEditingController _controller = TextEditingController(text: observaciones);


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('actualizarobservacionescostumbres'.tr()),
          content: TextField(
            controller: _controller,

            onChanged: (value) {
              nuevaMedicacion =
                  value; // Actualiza el nuevo nombre a medida que el usuario escribe en el TextField
            },
            decoration: InputDecoration(hintText: 'actualizarobservacionescostumbres'.tr()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Cierra el AlertDialog sin hacer cambios
              },
              child: Text('cancelar'.tr()),
            ),
            TextButton(
              onPressed: () {
                // Llama a la función para enviar el nuevo nombre del paciente al servidor
                enviarNuevasObservacionesPaciente(_controller.text);
                Navigator.of(context)
                    .pop(); // Cierra el AlertDialog después de aceptar los cambios
              },
              child: Text('actualizarobservacionescostumbres'.tr()),
            ),
          ],
        );
      },
    );
  }

  Future<void> enviarNuevasObservacionesPaciente(String nuevasObservaciones) async {
    // URL del script PHP para actualizar el nombre del paciente en la base de datos

    String url = URLProyecto + APICarpeta + "actualizar_observaciones_habitos_paciente.php";

    // Datos a enviar al servidor (id_paciente y nuevo nombre del paciente)
    Map<String, String> datos = {
      'id_paciente': widget.paciente.id_paciente!,
      // Id del paciente a actualizar
      'observaciones_costumbres': nuevasObservaciones
      // Nuevo nombre del paciente
    };

    try {
      // Realiza la solicitud POST al script PHP con los datos del nuevo nombre
      http.Response respuesta = await http.post(Uri.parse(url), body: datos);

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (respuesta.statusCode == 200) {
        print('Medicacion del paciente actualizado correctamente.');
        setState(() {
          _observacionesController.text = nuevasObservaciones;
        });
      } else {
        print(
            'Error al actualizar el nombre del paciente: ${respuesta.statusCode}');
      }
    } catch (error) {
      print('Error al enviar el nuevo nombre del paciente: $error');
    }
  }


  Future<PacienteDatosHabitos?> fetchPacienteDatosHabitos(
      String idPaciente) async {
    final url = URLProyecto +
        APICarpeta +
        "obtener_datos_costumbres_paciente_clinica.php"; // URL de tu script PHP

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'id_paciente': idPaciente}, // Parámetros enviados al script PHP
      );

      print("respuesta datos medicos paciente clinica --> ${response.body}");
      print(
          "response.statusCode recibido en datos medicos paciente clinica --> ${response.statusCode}");

      if (response.statusCode == 200) {
        // Si la solicitud es exitosa, decodifica la respuesta JSON
        final parsed = json.decode(response.body);

        return PacienteDatosHabitos.fromJson(parsed);
      } else {
        // Si la solicitud falla, lanza una excepción
        throw Exception('Error al cargar los datos del paciente');
      }
    } catch (e) {
      // Manejo de errores
      print('Error: $e');
      return null;
    }
  }

  @override
  void dispose() {

    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    // Método helper para construir una fila de información
    Widget _buildInfoRow(String svgAssetPath, String? info) {
      return Row(
        children: [
          SvgPicture.asset(
            svgAssetPath,
            width: 44, // Ajusta el tamaño del icono según sea necesario
            height: 44,
            color: Colors.black54, // Opcional: para aplicar un color al SVG
          ),
          SizedBox(width: appPadding),
          Container(
            constraints: BoxConstraints(maxWidth: 250),
            child: Text(
              info ?? 'Información no disponible',
              style: AppFonts.nannic(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      );
    }

    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(appPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appPadding),
                  // suplementos alimenticios
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/suplementos.svg", "suplementos".tr()),
                      Spacer(),
                      !suplementos_alimenticios
                          ? NoWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "suplementos_alimenticios",
                        onRefreshData: refreshData,
                      )
                          : YesWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "suplementos_alimenticios",
                        onRefreshData: refreshData,
                      )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // tipo alimentacion
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/tipo_dieta.svg", "tipoalimentacion".tr()),
                      Spacer(),
                      !tipo_alimentacion
                          ? NoWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "tipo_alimentacion",
                        onRefreshData: refreshData,
                      )
                          : YesWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "tipo_alimentacion",
                        onRefreshData: refreshData,
                      )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // fuma
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/smoking.svg", "fuma".tr()),
                      Spacer(),
                      !fuma
                          ? NoWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "fuma",
                        onRefreshData: refreshData,
                      )
                          : YesWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "fuma",
                        onRefreshData: refreshData,
                      )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // bebe_alcohol
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/alcohol.svg", "bebealcohol".tr()),
                      Spacer(),
                      !bebe_alcohol
                          ? NoWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "bebe_alcohol",
                        onRefreshData: refreshData,
                      )
                          : YesWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "bebe_alcohol",
                        onRefreshData: refreshData,
                      )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // desorden_alimenticio
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/desorden.svg", "desordenalimenticio".tr()),
                      Spacer(),
                      !desorden_alimenticio
                          ? NoWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "desorden_alimenticio",
                        onRefreshData: refreshData,
                      )
                          : YesWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "desorden_alimenticio",
                        onRefreshData: refreshData,
                      )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // trastorno_sueno
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/insomnio.svg", "trastornosueno".tr()),
                      Spacer(),
                      !trastorno_sueno
                          ? NoWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "trastorno_sueno",
                        onRefreshData: refreshData,
                      )
                          : YesWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "trastorno_sueno",
                        onRefreshData: refreshData,
                      )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // bronceado
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/bronceado.svg", "bronceado".tr()),
                      Spacer(),
                      !bronceado
                          ? NoWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "bronceado",
                        onRefreshData: refreshData,
                      )
                          : YesWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "bronceado",
                        onRefreshData: refreshData,
                      )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // circunstancias laborales especificas
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/circunstancias.svg", "circunstanciaslaborales".tr()),
                      Spacer(),
                      !circunstancias_laborales_especificas
                          ? NoWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "circunstancias_laborales_especificas",
                        onRefreshData: refreshData,
                      )
                          : YesWidget(
                        pacienteId: widget.paciente.id_paciente!,
                        variable: "circunstancias_laborales_especificas",
                        onRefreshData: refreshData,
                      )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  //observaciones datos costumbres del paciente
                  Text('observacionesdatoshabitos'.tr(),
                      textAlign: TextAlign.center,
                      style: AppFonts.nannic(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height:
                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                  ),
                  MyTextField(
                    controller: _observacionesController,
                    hintText: 'observacionesdatoshabitos'.tr(),
                    obscureText: false,
                  ),
                  SizedBox(
                    height:
                    appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                  ),
                  MyButton(
                    onTap: () {
                      mostrarDialogoCambiarObservaciones(context,_observacionesController.text);

                    },
                    text: "actualizarobservacionescostumbres".tr(),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
