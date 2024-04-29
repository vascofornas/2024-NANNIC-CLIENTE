import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/models/analytic_info_model.dart';
import 'package:flutter_nannic_cliente/providers/usuario_provider.dart';
import 'package:flutter_nannic_cliente/screens/components/analytic_info_card.dart';

import 'package:provider/provider.dart';

class ProfesionalesAnalytic extends StatefulWidget {
  const ProfesionalesAnalytic({super.key});

  @override
  State<ProfesionalesAnalytic> createState() => _ProfesionalesAnalyticState();
}

class _ProfesionalesAnalyticState extends State<ProfesionalesAnalytic> {

  int numeroProfesionales = 0;
  int numeroProfesionalesAdministradores = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerNumeroProfesionales ();
    obtenerNumeroProfesionalesAdministradores ();
  }

  obtenerNumeroProfesionales () async {

      numeroProfesionales = await ApiService.obtenerNumeroProfesionales();
     print("numero profesionales ${numeroProfesionales}");


       Provider.of<UsuarioProvider>(context,listen:false).cambiarNumProfesionalesState(numeroProfesionales);
  }
  obtenerNumeroProfesionalesAdministradores () async {

    numeroProfesionalesAdministradores = await ApiService.obtenerNumeroProfesionalesAdministradores();
    print("numero profesionales adm ${numeroProfesionalesAdministradores}");


    Provider.of<UsuarioProvider>(context,listen:false).cambiarNumProfesionalesAdministradoresState(numeroProfesionalesAdministradores);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Responsive(
        mobile: AnalyticProfesionalesCardGridView(
          crossAxisCount: size.width < 650 ? 2 : 4,
          childAspectRatio: size.width < 650 ? 2 : 1.5,
        ),
        tablet: AnalyticProfesionalesCardGridView(),
        desktop: AnalyticProfesionalesCardGridView(

          childAspectRatio: size.width < 1400 ? 1.5 : 2.1,
        ),
      ),
    );
  }
}
class AnalyticProfesionalesCardGridView extends StatefulWidget {
   AnalyticProfesionalesCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.4,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;


  @override
  State<AnalyticProfesionalesCardGridView> createState() => _AnalyticProfesionalesCardGridViewState();
}

class _AnalyticProfesionalesCardGridViewState extends State<AnalyticProfesionalesCardGridView> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<UsuarioProvider>(context);

    List analyticProfesionalesData = [
      AnalyticInfo(
        title: "profesionales".tr(),
        count: provider.numeroProfesionales,
        svgSrc: "assets/icons/Subscribers.svg",
        color: primaryColor,
      ),
      AnalyticInfo(
        title: "administrators".tr(),
        count: provider.numeroProfesionalesAdministradores,
        svgSrc: "assets/icons/administrator.svg",
        color: textColor,
      ),

    ];
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: analyticProfesionalesData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: appPadding,
        mainAxisSpacing: appPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => AnalyticInfoCard(
        info: analyticProfesionalesData[index],
      ),
    );
  }
}