import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/models/analytic_info_model.dart';
import 'package:flutter_nannic_cliente/providers/usuario_provider.dart';
import 'package:flutter_nannic_cliente/screens/components/analytic_info_card.dart';

import 'package:provider/provider.dart';

class PacientesAnalytic extends StatefulWidget {
  const PacientesAnalytic({super.key, required this.clinicaId});
  final String clinicaId;

  @override
  State<PacientesAnalytic> createState() => _PacientesAnalyticState();
}

class _PacientesAnalyticState extends State<PacientesAnalytic> {

  int numeroPacientes = 0;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerNumeroPacientes ();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      obtenerNumeroPacientes ();



    });


  }

  obtenerNumeroPacientes () async {


      numeroPacientes = await ApiService.obtenerNumeroPacientesClinica(widget.clinicaId);
      if(mounted){
        Provider.of<UsuarioProvider>(context,listen:false).cambiarNumPacientesState(numeroPacientes);
      }




  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Responsive(
        mobile: AnalyticPacientesCardGridView(
          crossAxisCount: size.width < 650 ? 2 : 4,
          childAspectRatio: size.width < 650 ? 2 : 1.5,
        ),
        tablet: AnalyticPacientesCardGridView(),
        desktop: AnalyticPacientesCardGridView(

          childAspectRatio: size.width < 1400 ? 1.5 : 2.1,
        ),
      ),
    );
  }
}
class AnalyticPacientesCardGridView extends StatefulWidget {
   AnalyticPacientesCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.4,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;


  @override
  State<AnalyticPacientesCardGridView> createState() => _AnalyticPacientesCardGridViewState();
}

class _AnalyticPacientesCardGridViewState extends State<AnalyticPacientesCardGridView> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<UsuarioProvider>(context);

    List analyticPacientesData = [
      AnalyticInfo(
        title: "pacientes".tr(),
        count: provider.numeroPacientes,
        svgSrc: "assets/icons/paciente.svg",
        color: primaryColor,
      ),


    ];
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: analyticPacientesData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: appPadding,
        mainAxisSpacing: appPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => AnalyticInfoCard(
        info: analyticPacientesData[index],
      ),
    );
  }
}