import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/components/my_textfield.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/screens/components/flutter_toast/flutter_toast_widget.dart';

import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> buildCambiarPassProfesionalDialog(BuildContext context,
    TextEditingController passwordController,
    String? email) {
  return showDialog(
    context: context,
    builder: (context) {
      passwordController.text = "";
      return AlertDialog(
        title:  Text(
          "cambiarpasspro".tr()+"-> ${email}",
          style: AppFonts.nannic(
            color: Colors.black38,
            fontSize: 16,
            fontWeight: FontWeight.w800
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextField(controller: passwordController, hintText: 'nuevapasscambiar'.tr(), obscureText:false),

          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey,
            ),
            child: Text('cancelar'.tr(), style: AppFonts.nannic(
              color: Colors.black38,
              fontSize: 12,
              fontWeight: FontWeight.w800
            )),
          ),

          ElevatedButton(
            onPressed: () {
              String newPassword = passwordController.text;
              // Aquí puedes manejar la lógica para cambiar la contraseña

              if(newPassword.isEmpty || newPassword.length < 8) {

                Fluttertoast.showToast(
                  msg: 'passmuycorta'.tr(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );

              } else {
                //procesos para cambiar password
                ApiService().cambiarPasswordProfesional(newPassword, email!);
                newPassword = "";
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
            ),
            child: Text('passcambiar'.tr(), style: AppFonts.nannic(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16
            )),
          )
          ,
        ],
      );
    },
  );
}