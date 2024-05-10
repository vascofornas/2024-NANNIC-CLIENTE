import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/models/analytic_info_model.dart';
import 'package:flutter_nannic_cliente/providers/usuario_provider.dart';
import 'package:flutter_nannic_cliente/screens/components/analytic_info_card.dart';

import 'package:provider/provider.dart';

class ClinicasAnalytic extends StatefulWidget {
  const ClinicasAnalytic({super.key});

  @override
  State<ClinicasAnalytic> createState() => _ClinicasAnalyticState();
}

class _ClinicasAnalyticState extends State<ClinicasAnalytic> {

  int numeroClinicas = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerNumeroClinicas ();

  }

  obtenerNumeroClinicas () async {

      numeroClinicas = await ApiService.obtenerNumeroClinicas();
     print("numero clinicas ${numeroClinicas}");
     if(mounted){
       Provider.of<UsuarioProvider>(context,listen:false).cambiarNumClinicasState(numeroClinicas);
     }



  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Responsive(
        mobile: AnalyticClinicasCardGridView(
          crossAxisCount: size.width < 650 ? 2 : 4,
          childAspectRatio: size.width < 650 ? 2 : 1.5,
        ),
        tablet: AnalyticClinicasCardGridView(),
        desktop: AnalyticClinicasCardGridView(

          childAspectRatio: size.width < 1400 ? 1.5 : 2.1,
        ),
      ),
    );
  }
}
class AnalyticClinicasCardGridView extends StatefulWidget {
   AnalyticClinicasCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.4,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;


  @override
  State<AnalyticClinicasCardGridView> createState() => _AnalyticClinicasCardGridViewState();
}

class _AnalyticClinicasCardGridViewState extends State<AnalyticClinicasCardGridView> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<UsuarioProvider>(context);

    List analyticClinicasData = [
      AnalyticInfo(
        title: "clinicascentrospartners".tr(),
        count: provider.numeroClinicas,
        svgSrc: "assets/icons/clinicas.svg",
        color: primaryColor,
      ),


    ];
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: analyticClinicasData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: appPadding,
        mainAxisSpacing: appPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => AnalyticInfoCard(
        info: analyticClinicasData[index],
      ),
    );
  }
}