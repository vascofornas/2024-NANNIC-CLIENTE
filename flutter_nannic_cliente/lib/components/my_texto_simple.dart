import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';

class MiTextoSimple extends StatelessWidget {
  const MiTextoSimple({super.key, required this.texto, required this.color, required this.fontWeight, required this.fontsize});
  final String texto;
  final Color color;
  final FontWeight fontWeight;
  final double fontsize;


  @override
  Widget build(BuildContext context) {
    return Text(this.texto,style:AppFonts.nannic(color: this.color,fontWeight: this.fontWeight, fontSize: this.fontsize),);
  }
}
