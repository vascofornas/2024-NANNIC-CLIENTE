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
import 'package:flutter_nannic_cliente/models/paciente_datos_medicos_modelo.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class DatosMedicosPaciente extends StatefulWidget {
  const DatosMedicosPaciente({super.key, required this.paciente});
  final Paciente paciente;

  @override
  State<DatosMedicosPaciente> createState() => _DatosMedicosPacienteState();
}

class _DatosMedicosPacienteState extends State<DatosMedicosPaciente> {
  String nombrePaciente = "";
  TextEditingController _medicacionController = TextEditingController();
  TextEditingController _observacionesController = TextEditingController();

  bool alta_presion = false;
  bool baja_presion = false;
  bool diabetes = false;
  bool cardiopatias = false;
  bool embarazo = false;
  bool marcapasos = false;
  bool lentillas = false;
  bool epilepsia = false;
  bool alergias = false;
  bool hormonal_problems = false;
  bool implantes_metalicos = false;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  refreshData() {
    fetchPacienteDatosMedicos(widget.paciente.id_paciente!)
        .then((pacienteDatosMedicos) {
      print("refrescando datos en datos medicos");
      if (pacienteDatosMedicos == null) {
      } else {
        // Procesar los datos medicos del paciente

        print(
            "datos alta_presion recibidos ${pacienteDatosMedicos.alta_presion}");
        print(
            "datos baja_presion recibidos ${pacienteDatosMedicos.baja_presion}");
        //alta presion
        if (pacienteDatosMedicos.alta_presion == "1") {
          alta_presion = true;
          setState(() {});
        }
        else{
          alta_presion = false;
          setState(() {});
        }
        //baja presion
        if (pacienteDatosMedicos.baja_presion == "1") {
          baja_presion = true;
          setState(() {});
        }
        else{
          baja_presion = false;
          setState(() {});
        }
        //cardiopatias
        if (pacienteDatosMedicos.cardiopatias== "1") {
          cardiopatias = true;
          setState(() {});
        }
        else{
          cardiopatias = false;
          setState(() {});
        }
        //marcapasos
        if (pacienteDatosMedicos.marcapasos == "1") {
          marcapasos = true;
          setState(() {});
        }
        else{
          marcapasos = false;
          setState(() {});
        }
        //diabetes
        if (pacienteDatosMedicos.diabetes == "1") {
          diabetes = true;
          setState(() {});
        }
        else{
          diabetes = false;
          setState(() {});
        }
        //epilepsia
        if (pacienteDatosMedicos.epilepsia == "1") {
          epilepsia = true;
          setState(() {});
        }
        else{
          epilepsia = false;
          setState(() {});
        }
        //hormonal problems
        if (pacienteDatosMedicos.hormonal_problems == "1") {
          hormonal_problems = true;
          setState(() {});
        }
        else{
          hormonal_problems = false;
          setState(() {});
        }
        //embarazo
        if (pacienteDatosMedicos.embarazo == "1") {
          embarazo = true;
          setState(() {});
        }
        else{
          embarazo = false;
          setState(() {});
        }
        //lentillas
        if (pacienteDatosMedicos.lentillas == "1") {
          lentillas = true;
          setState(() {});
        }
        else{
          lentillas = false;
          setState(() {});
        }
        //aleRgias
        if (pacienteDatosMedicos.alergias == "1") {
          alergias = true;
          setState(() {});
        }
        else{
          alergias = false;
          setState(() {});
        }
        //implantes
        if (pacienteDatosMedicos.implantes_metalicos == "1") {
          implantes_metalicos = true;
          setState(() {});
        }
        else{
          implantes_metalicos = false;
          setState(() {});
        }
        
        //observaciones
        _observacionesController.text = pacienteDatosMedicos.observaciones_datos_medicos!;
        setState(() {

        });
        //medicacion
        _medicacionController.text = pacienteDatosMedicos.medicacion_actual!;
        setState(() {

        });
      }
    });
  }

  Future<PacienteDatosMedicos?> fetchPacienteDatosMedicos(
      String idPaciente) async {
    final url = URLProyecto +
        APICarpeta +
        "obtener_datos_medicos_paciente_clinica.php"; // URL de tu script PHP

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

        return PacienteDatosMedicos.fromJson(parsed);
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

  void mostrarDialogoCambiarCurrentMedication(BuildContext context, String medicacionActual) {
    String nuevaMedicacion =
        ''; // Variable para almacenar el nuevo nombre del paciente
    // Crea un TextEditingController con el texto inicial de medicacionActual
    TextEditingController _controller = TextEditingController(text: medicacionActual);


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('cambiarmedicacion'.tr()),
          content: TextField(
            controller: _controller,

            onChanged: (value) {
              nuevaMedicacion =
                  value; // Actualiza el nuevo nombre a medida que el usuario escribe en el TextField
            },
            decoration: InputDecoration(hintText: 'cambiarmedicacion'.tr()),
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
                enviarNuevaMedicacionPaciente(_controller.text);
                Navigator.of(context)
                    .pop(); // Cierra el AlertDialog después de aceptar los cambios
              },
              child: Text('actualizarmedicacion'.tr()),
            ),
          ],
        );
      },
    );
  }

  Future<void> enviarNuevaMedicacionPaciente(String nuevaMedicacion) async {
    // URL del script PHP para actualizar el nombre del paciente en la base de datos
    print ("valor de la nueva medicacion ${nuevaMedicacion}");
    String url = URLProyecto + APICarpeta + "actualizar_medicacion_paciente.php";

    // Datos a enviar al servidor (id_paciente y nuevo nombre del paciente)
    Map<String, String> datos = {
      'id_paciente': widget.paciente.id_paciente!,
      // Id del paciente a actualizar
      'medicacion_paciente': nuevaMedicacion
      // Nuevo nombre del paciente
    };

    try {
      // Realiza la solicitud POST al script PHP con los datos del nuevo nombre
      http.Response respuesta = await http.post(Uri.parse(url), body: datos);

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (respuesta.statusCode == 200) {
        print('Medicacion del paciente actualizado correctamente.');
        setState(() {
          _medicacionController.text = nuevaMedicacion;
        });
      } else {
        print(
            'Error al actualizar el nombre del paciente: ${respuesta.statusCode}');
      }
    } catch (error) {
      print('Error al enviar el nuevo nombre del paciente: $error');
    }
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
          title: Text('cambiarobservaciones'.tr()),
          content: TextField(
            controller: _controller,

            onChanged: (value) {
              nuevaMedicacion =
                  value; // Actualiza el nuevo nombre a medida que el usuario escribe en el TextField
            },
            decoration: InputDecoration(hintText: 'cambiarobservaciones'.tr()),
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
              child: Text('actualizarobservaciones'.tr()),
            ),
          ],
        );
      },
    );
  }

  Future<void> enviarNuevasObservacionesPaciente(String nuevasObservaciones) async {
    // URL del script PHP para actualizar el nombre del paciente en la base de datos

    String url = URLProyecto + APICarpeta + "actualizar_observaciones_paciente.php";

    // Datos a enviar al servidor (id_paciente y nuevo nombre del paciente)
    Map<String, String> datos = {
      'id_paciente': widget.paciente.id_paciente!,
      // Id del paciente a actualizar
      'observaciones_datos_medicos': nuevasObservaciones
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
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(appPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appPadding),
                  // alta presion
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/bloodpressure.svg", "altapresion".tr()),
                      Spacer(),
                      !alta_presion
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "alta_presion",
                              onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "alta_presion",
                              onRefreshData: refreshData,
                            )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // baja presion
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/bloodpressure.svg", "bajapresion".tr()),
                      Spacer(),
                      !baja_presion
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "baja_presion",
                        onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "baja_presion",
                        onRefreshData: refreshData,
                            )
                    ],
                  ),
                  SizedBox(height: appPadding),

                  // cardiopatias
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/cardiopatia.svg", "cardiopatias".tr()),
                      Spacer(),
                      !cardiopatias
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "cardiopatias",
                        onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "cardiopatias",
                        onRefreshData: refreshData,
                            )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // marcapasos
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/pacemaker.svg", "marcapasos".tr()),
                      Spacer(),
                      !marcapasos
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "marcapasos",
                        onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "marcapasos",
                        onRefreshData: refreshData,
                            )
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // diabetes
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/diabetes.svg", "diabetes".tr()),
                      Spacer(),
                      !diabetes
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "diabetes",
                        onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "diabetes",
                        onRefreshData: refreshData,
                            ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // epilepsia
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/epilepsia.svg", "epilepsia".tr()),
                      Spacer(),
                      !epilepsia
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "epilepsia",
                        onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "epilepsia",
                        onRefreshData: refreshData,
                            ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // problemas hormonales
                  Row(
                    children: [
                      _buildInfoRow("assets/icons/hormonal.svg",
                          "problemahormonales".tr()),
                      Spacer(),
                      !hormonal_problems
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "hormonal_problems",
                        onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "hormonal_problems",
                        onRefreshData: refreshData,
                            ),
                    ],
                  ),
                  SizedBox(height: appPadding),

                  // alergias
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/alergia.svg", "alergias".tr()),
                      Spacer(),
                      !alergias
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "alergias",
                        onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "alergias",
                        onRefreshData: refreshData,
                            ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // implantes metalicos
                  Row(
                    children: [
                      _buildInfoRow("assets/icons/implantes.svg",
                          "implantesmetalicos".tr()),
                      Spacer(),
                      !implantes_metalicos
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "implantes_metalicos",
                        onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "implantes_metalicos",
                        onRefreshData: refreshData,
                            ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // lentillas
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/lentilla.svg", "lentillas".tr()),
                      Spacer(),
                      !lentillas
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "lentillas",
                        onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "lentillas",
                        onRefreshData: refreshData,
                            ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  // embarazada
                  Row(
                    children: [
                      _buildInfoRow(
                          "assets/icons/embarazo.svg", "embarazada".tr()),
                      Spacer(),
                      !embarazo
                          ? NoWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "embarazo",
                        onRefreshData: refreshData,
                            )
                          : YesWidget(
                              pacienteId: widget.paciente.id_paciente!,
                              variable: "embarazo",
                        onRefreshData: refreshData,
                            ),
                    ],
                  ),
                  SizedBox(height: appPadding),
                  //medicacion del paciente
                  Text('medicacion'.tr(),
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
                    controller: _medicacionController,
                    hintText: 'medicacion'.tr(),
                    obscureText: false,
                  ),
                  SizedBox(
                    height:
                        appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                  ),
                  MyButton(
                    onTap: () {
                      mostrarDialogoCambiarCurrentMedication(context,_medicacionController.text);
                    },
                    text: "actualizarmedicacion".tr(),
                  ),
                  SizedBox(
                    height:
                        appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
                  ),
                  SizedBox(height: appPadding),
                  //observaciones datos medicos del paciente
                  Text('observacionesdatosmedicos'.tr(),
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
                    hintText: 'observacionesdatosmedicos'.tr(),
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
                    text: "actualizarobservaciones".tr(),
                  ),
                  SizedBox(
                    height:
                        appPadding, // Espacio adicional entre las tarjetas analíticas y el siguiente widget
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
