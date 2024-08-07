import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DatosPielPaciente extends StatefulWidget {
  const DatosPielPaciente({super.key, required this.paciente});
  final Paciente paciente;

  @override
  State<DatosPielPaciente> createState() => _DatosPielPacienteState();
}

class _DatosPielPacienteState extends State<DatosPielPaciente>  {



  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

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

            
            ],
          ),
        ),
      ),
    );
  }
}
