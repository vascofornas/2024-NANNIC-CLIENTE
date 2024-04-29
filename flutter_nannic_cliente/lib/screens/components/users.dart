import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';





class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Users",
            style: AppFonts.nannic(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text("aqui va una grafica de barras",
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
