import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/models/analytic_info_model.dart';
import 'package:flutter_nannic_cliente/providers/usuario_provider.dart';
import 'package:flutter_nannic_cliente/screens/components/analytic_info_card.dart';

import 'package:provider/provider.dart';

class EquiposAnalytic extends StatefulWidget {
  const EquiposAnalytic({super.key, required this.idCLinica});
  final String idCLinica;

  @override
  State<EquiposAnalytic> createState() => _EquiposAnalyticState();
}

class _EquiposAnalyticState extends State<EquiposAnalytic> {

  int numeroEquiposNannic = 0;
  String clinicaActual ="";

  getIdClinica() async {
    clinicaActual = (await SharedPrefsHelper.getIdClinica())!;
    setState(() {
      obtenerNumeroEquipos ();
    });



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdClinica();

  }

  obtenerNumeroEquipos () async {

      numeroEquiposNannic = await ApiService.obtenerNumeroEquiposNannicClinica(clinicaActual);



       Provider.of<UsuarioProvider>(context,listen:false).cambiarNumEquiposNannicState(numeroEquiposNannic);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Responsive(
        mobile: AnalyticEquiposNannicCardGridView(
          crossAxisCount: size.width < 650 ? 2 : 4,
          childAspectRatio: size.width < 650 ? 2 : 1.5,
        ),
        tablet: AnalyticEquiposNannicCardGridView(),
        desktop: AnalyticEquiposNannicCardGridView(

          childAspectRatio: size.width < 1400 ? 1.5 : 2.1,
        ),
      ),
    );
  }
}
class AnalyticEquiposNannicCardGridView extends StatefulWidget {
   AnalyticEquiposNannicCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.4,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;


  @override
  State<AnalyticEquiposNannicCardGridView> createState() => _AnalyticEquiposNannicCardGridViewState();
}

class _AnalyticEquiposNannicCardGridViewState extends State<AnalyticEquiposNannicCardGridView> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<UsuarioProvider>(context);

    List analyticEquiposData = [
      AnalyticInfo(
        title: "equipos".tr(),
        count: provider.numeroEquiposNannic,
        svgSrc: "assets/icons/equipos.svg",
        color: primaryColor,
      ),


    ];
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: analyticEquiposData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: appPadding,
        mainAxisSpacing: appPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) => AnalyticInfoCard(
        info: analyticEquiposData[index],
      ),
    );
  }
}