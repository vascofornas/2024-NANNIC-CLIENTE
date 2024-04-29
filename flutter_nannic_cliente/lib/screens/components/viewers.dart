import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';




class Viewers extends StatelessWidget {
  const Viewers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Viewers',
            style: AppFonts.nannic(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.grey

            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text("Aqui va una grafica",
                    style: AppFonts.nannic(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey

                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
