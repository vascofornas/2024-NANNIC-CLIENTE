import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/auth_pages/login_page.dart';
import 'package:flutter_admin_dashboard/auth_shared_preferences/auth_manager.dart';
import 'package:flutter_admin_dashboard/screens/dashboard/dash_board_screen.dart';


class MiWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: AuthManager().isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Si aún estamos esperando la respuesta, puedes mostrar un indicador de carga
            return CircularProgressIndicator();
          } else {
            // Una vez que tenemos la respuesta, podemos mostrar el contenido basado en el estado de autenticación
            if (snapshot.hasError) {
              // Si hay un error al obtener el estado de autenticación
              return Text('Error al obtener el estado de autenticación');
            } else {
              // Si todo está bien, podemos mostrar el contenido basado en el estado de autenticación
              bool isLoggedIn = snapshot.data ?? false;
              return isLoggedIn?DashBoardScreen():LoginPage();
            }
          }
        },
      ),
    );
  }
}
