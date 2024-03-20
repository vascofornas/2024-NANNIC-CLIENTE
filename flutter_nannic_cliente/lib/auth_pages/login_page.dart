import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_admin_dashboard/auth_pages/recuperar_pass_login.dart';
import 'package:flutter_admin_dashboard/auth_shared_preferences/auth_manager.dart';
import 'package:flutter_admin_dashboard/components/my_button.dart';
import 'package:flutter_admin_dashboard/components/my_textfield.dart';
import 'package:flutter_admin_dashboard/components/my_textfield_pass.dart';
import 'package:flutter_admin_dashboard/constants/constants.dart';
import 'package:flutter_admin_dashboard/providers/usuario_provider.dart';
import 'package:flutter_admin_dashboard/screens/components/flutter_toast/flutter_toast_widget.dart';
import 'package:flutter_admin_dashboard/screens/dashboard/dash_board_screen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isHidden = true;

  final AuthManager _authManager = AuthManager();

  iniciarSesion() async {
    if (emailController.text.isEmpty) {
      CustomToastWidget(message: 'Falta email',);
      return;
    }

    var url = URLProyecto + APICarpeta + "login.php";
    final response = await http.post(Uri.parse(url), body: {
      "email": emailController.text,
      "password": passwordController.text
    });

    final Map parsed = json.decode(response.body);
    if (parsed.containsKey('user') && parsed['error'].toString() == 'false') {
      CustomToastWidget(message: 'Inicio de sesion correcto',);;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      //PROCESAMOS EMAIL DEL USUARIO
      prefs.setString('email', parsed['user']['email'].toString()); //SP
      //PROCESAMOS ESTADO LOGGED IN
      _authManager.login();
      prefs.setString('ultimo_email', parsed['user']['email'].toString()); //SP
      //PROCESAMOS NOMBRE DEL USUARIO
      prefs.setString('nombre', parsed['user']['nombre'].toString()); //SP

      //PROCESAMOS APELLIDOS DEL USUARIO
      prefs.setString('apellidos', parsed['user']['apellidos'].toString()); //SP

      //PROCESAMOS IMAGEN DEL USUARIO
      prefs.setString('foto', parsed['user']['imagen'].toString()); //SP

      //PROCESAMOS ID DEL USUARIO
      prefs.setString(
          'id_usuario', parsed['user']['id_usuario'].toString()); //SP

      //PROCESAMOS TEL DEL USUARIO
      prefs.setString('tel', parsed['user']['tel'].toString()); //SP

      Provider.of<UsuarioProvider>(context, listen: false)
          .cambiarTelUsuarioState(parsed['user']['tel'].toString());

      //PROCESAMOS TOKEN FB DEL USUARIO
      String tokenFb = parsed['user']['token_firebase'].toString();
      prefs.setString(
          'token_firebase', parsed['user']['token_firebase'].toString()); //SP

      //nivel usuario
      print("nivel usuario ${parsed['user']['nivel_usuario']}");
      int nivel = parsed['user']['nivel_usuario'];
      if (nivel == 2) {
        print("ES ADMINISTRADOR");
        prefs.setBool('es_admin', true);
      } else {
        print("no ES ADMINISTRADOR");
        prefs.setBool('es_admin', false);
      }

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => DashBoardScreen()));
    } else {
      CustomToastWidget(message: "Error en el inicio de sesión");

    }
  }

  // forgot password
  void forgotPw() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("User tapped forgot password."),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // logo
                  Image.asset(
                    'assets/images/logo_corto.png',
                    height: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  const SizedBox(height: 50),

                  // welcome back, you've been missed!
                  Text(
                    '¡Bienvenido de nuevo, te hemos echado de menos!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextFieldPass(
                    controller: passwordController,
                    hintText: 'Contraseña',
                    obscureText: true,
                  ),

                  const SizedBox(height: 25),

                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext ctx) =>
                                        RecuperarPassLogin()));
                          },
                          child: Text(
                            '¿Contraseña olvidada?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                    onTap: iniciarSesion,
                    text: "Iniciar sesión",
                  ),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
