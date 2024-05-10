import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/auth_pages/recuperar_pass_login.dart';
import 'package:flutter_nannic_cliente/auth_shared_preferences/auth_manager.dart';
import 'package:flutter_nannic_cliente/components/my_button.dart';
import 'package:flutter_nannic_cliente/components/my_textfield.dart';
import 'package:flutter_nannic_cliente/components/my_textfield_pass.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/providers/usuario_provider.dart';
import 'package:flutter_nannic_cliente/screens/components/flutter_toast/flutter_toast_widget.dart';
import 'package:flutter_nannic_cliente/screens/dashboard/dash_board_screen.dart';

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


  late Locale _selectedLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();




  bool _isHidden = true;

  final AuthManager _authManager = AuthManager();

  late Map<String, dynamic> userData;

  Future<void> _init() async {
    final locale = EasyLocalization.of(context)?.locale;
    if (locale != null) {
      _selectedLocale = locale;
      setState(() {}); // Notificar a Flutter que el estado ha cambiado
    }
  }

  _saveDataToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData.forEach((key, value) {
      prefs.setString(key, value.toString());
   ;
    });

  }

  Future<void> iniciarSesion() async {
    const String url = URLProyecto + APICarpeta + "login_nannic.php";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Verificar si la respuesta contiene datos del usuario
        if (response.body.isNotEmpty) {
          // Convertir la respuesta JSON a un mapa
          Map<String, dynamic> responseData = json.decode(response.body);
          final Map parsed = json.decode(response.body);


          // Verificar si la respuesta contiene un mensaje de error
          if (responseData.containsKey('error')) {
            // Mostrar mensaje de error en caso de contraseña incorrecta o usuario no encontrado
            final String errorMessage = responseData['error'];
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text(errorMessage),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ],
                );
              },
            );
          } else {
            // La autenticación fue exitosa, puedes procesar los datos del usuario aquí
            // Por ejemplo, guardar los datos del usuario en el almacenamiento local



            userData = responseData;
            _saveDataToSharedPreferences();


            //PROCESAMOS ESTADO LOGGED IN
            _authManager.login();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext ctx) => const DashBoardScreen()));
          }
        }
      }
    } catch (e) {}
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
              child: _selectedLocale == null ? CircularProgressIndicator():
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // logo
                  Image.asset(
                    'assets/images/transparent_logo.png',
                    height: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  const SizedBox(height: 50),

                  // welcome back, you've been missed!

                Text('welcome'.tr(),
                    textAlign: TextAlign.center,
                    style: AppFonts.nannic(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),

                  const SizedBox(height: 25),

                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email'.tr(),
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextFieldPass(
                    controller: passwordController,
                    hintText: 'Password'.tr(),
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
                                        const RecuperarPassLogin()));
                          },
                          child: Text(
                            'forgot'.tr(),
                            style: AppFonts.nannic(color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                    onTap: iniciarSesion,
                    text: "Login".tr(),
                  ),

                  const SizedBox(height: 25),
                  CambiarIdioma(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center CambiarIdioma(BuildContext context) {
    return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Cambiar al idioma inglés
                          setState(() {
                            _selectedLocale = Locale('en', 'EN');
                          });
                          context.setLocale(_selectedLocale);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: _selectedLocale.languageCode == 'en' ?Colors.white:Colors.grey,
                          backgroundColor: _selectedLocale.languageCode == 'en' ? Colors.blueGrey : null, // Color verde si está seleccionado
                        ),
                        child: Text('English',
                        style: AppFonts.nannic(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      SizedBox(width: 20,),

                      ElevatedButton(
                        onPressed: () {
                          // Cambiar al idioma holandés
                          setState(() {
                            _selectedLocale = Locale('nl', 'NL');
                          });
                          context.setLocale(_selectedLocale);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: _selectedLocale.languageCode == 'nl' ?Colors.white:Colors.grey,
                          backgroundColor: _selectedLocale.languageCode == 'nl' ? Colors.blueGrey : null, // Color verde si está seleccionado
                        ),
                        child: Text('Dutch',
                            style: AppFonts.nannic(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                      SizedBox(width: 20,),
                      ElevatedButton(
                        onPressed: () {
                          // Cambiar al idioma sueco
                          setState(() {
                            _selectedLocale = Locale('sv', 'SV');
                          });
                          context.setLocale(_selectedLocale);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: _selectedLocale.languageCode == 'sv' ?Colors.white:Colors.grey,
                          backgroundColor: _selectedLocale.languageCode == 'sv' ? Colors.blueGrey : null, // Color verde si está seleccionado
                        ),
                        child: Text('Svenska',
                            style: AppFonts.nannic(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                );
  }
}
