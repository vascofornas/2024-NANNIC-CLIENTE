import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_alergias_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_alta_presion_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_baja_presion_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_cardiopatia_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_diabetes_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_embarazo_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_epilepsia_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_hormonal_problems_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_implantes_metalicos_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_lentillas_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_marcapasos_paciente.dart';

class NoWidget extends StatefulWidget {
  final String pacienteId;
  final String variable;
  final Function()? onRefreshData; // Función para ejecutar refreshData()

  const NoWidget({
    Key? key,
    required this.pacienteId,
    required this.variable,
    this.onRefreshData,
  }) : super(key: key);

  @override
  State<NoWidget> createState() => _NoWidgetState();
}

class _NoWidgetState extends State<NoWidget> {
  bool cargando = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          cargando = true;
        });

        if (widget.variable == "alta_presion") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarAltaPresionPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }
        if (widget.variable == "baja_presion") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarBajaPresionPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }
        if (widget.variable == "cardiopatias") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarCardiopatiaPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }
        if (widget.variable == "marcapasos") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarMarcapasosPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }
        if (widget.variable == "diabetes") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarDiabetesPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }
        if (widget.variable == "epilepsia") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarEpilepsiaPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }
        if (widget.variable == "hormonal_problems") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarHormonalProblemsPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }
        if (widget.variable == "embarazo") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarEmbarazoPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }
        if (widget.variable == "lentillas") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarLentillasPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }
        if (widget.variable == "alergias") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarAlergiasPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }
        if (widget.variable == "implantes_metalicos") {
          print("pulsado si  ${widget.pacienteId} ${widget.variable}");
          final now = DateTime.now();
          final formatter = DateFormat('yyyy-MM-dd');
          final formattedDate = formatter.format(now);
          await registrarImplantesMetalicosPaciente(
            idPaciente: widget.pacienteId,
            valor: "1",
            fechaActualizacion: formattedDate,
          );
          widget.onRefreshData?.call();
        }

        setState(() {
          cargando = false;
        });
      },
      child: cargando
          ? CircularProgressIndicator()
          : Container(
        decoration: BoxDecoration(
          color: Colors.red, // Fondo verde del rectángulo
          borderRadius: BorderRadius.circular(
              10.0), // Borde redondeado del rectángulo
        ),
        padding: EdgeInsets.all(10.0), // Espaciado interno del rectángulo
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30.0, // Ancho del contenedor del círculo
              height: 30.0, // Alto del contenedor del círculo
              decoration: BoxDecoration(
                color: Colors.grey, // Fondo gris del círculo
                shape: BoxShape.circle, // Forma circular del contenedor
              ),
              child: Center(
                child: Text(
                  'N', // Letra Y dentro del círculo
                  style: TextStyle(
                    fontSize: 16.0, // Tamaño de la letra
                    fontWeight: FontWeight.bold, // Negrita
                    color: Colors.black, // Color de la letra (negro)
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0), // Espaciado entre el círculo y el texto
            Text(
              'No', // Texto "No"
              style: TextStyle(
                color: Colors.white, // Color blanco del texto
                fontSize: 16.0, // Tamaño del texto
                fontWeight: FontWeight.bold, // Negrita
              ),
            ),
          ],
        ),
      ),
    );
  }
}
