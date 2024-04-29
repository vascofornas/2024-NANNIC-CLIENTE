import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {

  static TextStyle nannic({Color? color, double? fontSize,FontWeight? fontWeight}) {
    return GoogleFonts.comingSoon(
      textStyle: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    );
  }
}