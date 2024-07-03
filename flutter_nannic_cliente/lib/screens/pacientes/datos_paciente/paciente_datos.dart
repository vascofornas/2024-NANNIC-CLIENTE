import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/datos_paciente/datos_generales_paciente.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DatosPaciente extends StatefulWidget {
  const DatosPaciente({super.key, required this.paciente});
  final Paciente paciente;

  @override
  State<DatosPaciente> createState() => _DatosPacienteState();
}

class _DatosPacienteState extends State<DatosPaciente>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: appPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  SizedBox(width: appPadding),
                  MiTextoSimple(
                    texto: "datospaciente".tr()+" --> ${widget.paciente.nombre}",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontsize: 20,
                  ),
                ],
              ),
              // TabBar
              TabBar(
                controller: _tabController,
                labelStyle:  AppFonts.nannic(
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
                      'assets/icons/pacientes.svg',
                      height: 24.0, // Puedes ajustar el tamaño del SVG
                      width: 24.0,
                    ),
                    text: "datospaciente".tr(),
                  ),
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/icons/treatments.svg',
                      height: 24.0, // Puedes ajustar el tamaño del SVG
                      width: 24.0,
                    ),
                    text: "tratamientos".tr(),
                  ),
                ],
              ),
              // TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    DatosGeneralesPaciente(paciente: widget.paciente,),
                    Center(child: Text('Favorites Page')),
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
