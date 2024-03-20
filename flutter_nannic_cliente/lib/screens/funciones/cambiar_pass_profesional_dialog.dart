import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/api_services/api_services.dart';
import 'package:flutter_admin_dashboard/components/my_textfield.dart';
import 'package:flutter_admin_dashboard/screens/components/flutter_toast/flutter_toast_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> buildCambiarPassProfesionalDialog(BuildContext context,
    TextEditingController passwordController,
    String? email) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title:  Text(
          "Cambiar la contraseña del profesional ${email}",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextField(controller: passwordController, hintText: 'Nueva contraseña', obscureText:false),

          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Cancelar', style: TextStyle(color: Colors.black)),
          ),

          ElevatedButton(
            onPressed: () {
              String newPassword = passwordController.text;
              // Aquí puedes manejar la lógica para cambiar la contraseña
              print('Nueva contraseña: $newPassword');
              if(newPassword.isEmpty || newPassword.length < 8) {
                CustomToastWidget(message: 'Contraseña muy corta (mínimo 8 caracteres)',);
              } else {
                //procesos para cambiar password
                ApiService().cambiarPasswordProfesional(newPassword, email!);
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
            ),
            child: Text('Cambiar contraseña', style: TextStyle(color: Colors.white, fontSize: 16)),
          )
          ,
        ],
      );
    },
  );
}