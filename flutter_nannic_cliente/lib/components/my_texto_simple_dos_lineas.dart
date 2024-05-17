import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';

class MiTextoSimpleDosLineas extends StatelessWidget {
  const MiTextoSimpleDosLineas({super.key, required this.texto, required this.color, required this.fontWeight, required this.fontsize});
  final String texto;
  final Color color;
  final FontWeight fontWeight;
  final double fontsize;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          this.texto,

          maxLines: 2,
          overflow: TextOverflow.ellipsis, // O cualquier otro valor según tus necesidades
          style: AppFonts.nannic(
            color: this.color,
            fontWeight: this.fontWeight,
            fontSize: this.fontsize,
          ),
        ),
      ],
    );
  }

}
