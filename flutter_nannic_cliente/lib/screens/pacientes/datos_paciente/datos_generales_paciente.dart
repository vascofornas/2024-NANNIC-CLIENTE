import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/datos_paciente/datos_basicos_paciente.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/datos_paciente/datos_consent_paciente.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/datos_paciente/datos_habitos_paciente.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/datos_paciente/datos_medicos_paciente.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/datos_paciente/datos_piel_paciente.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DatosGeneralesPaciente extends StatefulWidget {
  const DatosGeneralesPaciente({super.key, required this.paciente});
  final Paciente paciente;

  @override
  State<DatosGeneralesPaciente> createState() => _DatosGeneralesPacienteState();
}

class _DatosGeneralesPacienteState extends State<DatosGeneralesPaciente> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: appPadding),

              // TabBar
              TabBar(
                controller: _tabController,
                isScrollable: true, // Hacer que el TabBar sea desplazable
                labelStyle: AppFonts.nannic(
                  color: Colors.black54, // Cambia el color del texto aquí
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: AppFonts.nannic(
                  color: Colors.black26, // Cambia el color del texto aquí
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/icons/basic_data.svg',
                      height: 24.0, // Puedes ajustar el tamaño del SVG
                      width: 24.0,
                    ),
                    text: "Datosbasicospaciente".tr(),
                  ),
        Tab(
          icon: SvgPicture.asset(
            'assets/icons/consent.svg',
            height: 24.0, // Puedes ajustar el tamaño del SVG
            width: 24.0,
          ),
          text: "consentimientospaciente".tr(),
        ),
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/icons/medical.svg',
                      height: 24.0, // Puedes ajustar el tamaño del SVG
                      width: 24.0,
                    ),
                    text: "datosmedicospaciente".tr(),
                  ),
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/icons/habits.svg',
                      height: 24.0, // Puedes ajustar el tamaño del SVG
                      width: 24.0,
                    ),
                    text: "datoshabitospaciente".tr(),
                  ),
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/icons/skin.svg',
                      height: 24.0, // Puedes ajustar el tamaño del SVG
                      width: 24.0,
                    ),
                    text: "datospielpaciente".tr(),
                  ),

                ],
              ),
              // TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    DatosBasicosPaciente(paciente: widget.paciente),
                    DatosConsentPaciente(paciente: widget.paciente),
                    DatosMedicosPaciente(paciente: widget.paciente),
                    DatosHabitosPaciente(paciente: widget.paciente),
                    DatosPielPaciente(paciente: widget.paciente),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
