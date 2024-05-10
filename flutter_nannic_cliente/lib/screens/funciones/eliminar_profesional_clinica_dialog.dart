import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/components/my_textfield.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/screens/components/flutter_toast/flutter_toast_widget.dart';

import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> buildEliminarProfesionalClinicaDialog(BuildContext context,
    String? clinicaId,
    String? profesionalNombre,
    String? profesionalId,
    VoidCallback? onUpdate) {
  return showDialog(
    context: context,
    builder: (context) {

      return AlertDialog(
        title:  Text(
          "quitarprofesionalcentro".tr(),
          style: AppFonts.nannic(
            color: Colors.black38,
            fontSize: 16,
            fontWeight: FontWeight.w800
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(profesionalNombre!)

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


                //procesos para cambiar password
                ApiService().quitarProfesionalFromClinica(profesionalId!, clinicaId!);


                Navigator.of(context).pop();
                // Llamar al callback onUpdate después de eliminar el profesional
                if (onUpdate != null) {
                  onUpdate!();
                }

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
            ),
            child: Text('quitarprofesionalcentro'.tr(), style: AppFonts.nannic(
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