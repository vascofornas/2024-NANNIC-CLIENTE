import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';

import 'package:flutter_svg/flutter_svg.dart';


class DrawerListTile extends StatelessWidget {
  const DrawerListTile({Key? key, required this.title, required this.svgSrc, required this.tap, required this.color}) : super(key: key);

  final String title, svgSrc;
  final Color color;

  final VoidCallback tap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(svgSrc,color: color,height: 40,),
      title: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Text(" "+title,style: AppFonts.nannic(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: color

        ),),
      ),
    );
  }
}
