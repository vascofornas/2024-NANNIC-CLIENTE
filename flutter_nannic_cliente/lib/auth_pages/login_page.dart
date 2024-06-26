import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/auth_pages/recuperar_pass_login.dart';
import 'package:flutter_nannic_cliente/auth_shared_preferences/auth_manager.dart';
import 'package:flutter_nannic_cliente/components/my_button.dart';
import 'package:flutter_nannic_cliente/components/my_textfield.dart';
import 'package:flutter_nannic_cliente/components/my_textfield_pass.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
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

  String nombreClinica = "AAA";
  String logoClinica = "logo_clinica.png";
  String idClinica ="";
  String tipoUsuario = "?";
  String idClinicaActual ="";
  String tipoUsuarioActual ="";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();




  bool _isHidden = true;
  bool ocultarBoton = false;

  final AuthManager _authManager = AuthManager();

  late Map<String, dynamic> userData;

  Future<void> _init() async {
    final locale = EasyLocalization.of(context)?.locale;
    if (locale != null) {
      _selectedLocale = locale;
      setState(() {}); // Notificar a Flutter que el estado ha cambiado
    }
  }



  Future<void> iniciarSesion() async {
    const String url = URLProyecto + APICarpeta + "login_nannic.php";
    setState(() {
      ocultarBoton = true;
    });

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

          print("datos recibidos al hacer login ${responseData.toString()}");

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
            userData = responseData;
            print("userData recibidos ${responseData}");
            await _saveDataToSharedPreferences(userData);

            await fetchDataClinica();

            //PROCESAMOS ESTADO LOGGED IN
            _authManager.login();
          }
        }
      } else {
        throw Exception('Error al obtener los profesionales');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        ocultarBoton = false;
      });
    }
  }

  Future<void> _saveDataToSharedPreferences(Map<String, dynamic> userData) async {
    // Espera a que todos los datos se guarden en SharedPreferences
    await SharedPrefsHelper().setId(userData['id'].toString());
    await SharedPrefsHelper().setEmail(userData['email']);
    await SharedPrefsHelper().setFoto(userData['imagen']);
    await SharedPrefsHelper().setNombre(userData['nombre']);
    await SharedPrefsHelper().setApellidos(userData['apellidos']);
    await SharedPrefsHelper().setNivelUsuario(userData['nivel_usuario']);
    await SharedPrefsHelper().setTel(userData['tel']);
    // Guardar otros datos necesarios del usuario en SharedPreferences
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

  Future<void> fetchDataClinica() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id') ?? '';
    print("userId en login fetchDataClinica $userId");

    if (userId.isEmpty) {
      return;
    }

    final response = await http.get(Uri.parse(URLProyecto + APICarpeta + 'obtener_clinica_profesional_administrador.php?idUsuario=$userId'));

    print("response.body ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String? idClinicaActual;
      String? tipoUsuarioActual;

      if (data.containsKey('profesional') && data['profesional'] != null && (data['profesional'] as List).isNotEmpty) {
        idClinicaActual = (data['profesional'] as List).first.toString();
        tipoUsuarioActual = 'profesional';
      }

      if (data.containsKey('administrador') && data['administrador'] != null && (data['administrador'] as List).isNotEmpty) {
        idClinicaActual = (data['administrador'] as List).first.toString();
        tipoUsuarioActual = 'administrador';
      }

      print("tipo usuario actual $tipoUsuarioActual");

      if (idClinicaActual != null && tipoUsuarioActual != null) {
        // Realizar las operaciones asíncronas primero
        await SharedPrefsHelper().setIdClinica(idClinicaActual);
        if (tipoUsuarioActual == "profesional") {
          await SharedPrefsHelper().setEsProfesionalClinica(true);
          await SharedPrefsHelper().setEsAdministradorClinica(false);
        } else if (tipoUsuarioActual == "administrador") {
          await SharedPrefsHelper().setEsProfesionalClinica(false);
          await SharedPrefsHelper().setEsAdministradorClinica(true);
        }

        // Luego actualizar el estado
        setState(() {
          idClinica = idClinicaActual!;
          tipoUsuario = tipoUsuarioActual!;
          print("id de la clinica en login $idClinicaActual");
          print("tipo de usuario en login $tipoUsuarioActual");

          // Llamar a obtenerDatosClinica después de actualizar el estado
          obtenerDatosClinica(idClinica);
        });
      }

    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<Map<String, String>> obtenerDatosClinica(String idClinica) async {
    // URL del script PHP en el servidor remoto
  ;
    String url = URLProyecto+APICarpeta+'obtener_datos_clinica.php?idClinica=$idClinica';


    // Realizar la solicitud HTTP
    final response = await http.get(Uri.parse(url));


    // Verificar si la solicitud fue exitosa
  print("he llegado hasta aqui");
  if (response.statusCode == 200) {
    // Decodificar la respuesta JSON
    Map<String, dynamic> data = jsonDecode(response.body);

    // Obtener el nombre y el logo de la clínica
    String nombreClinica = data['nombre_clinica'];
    print("nombre de la clinica en login ${nombreClinica}");

    await SharedPrefsHelper().setNombreClinica(nombreClinica);
    String logoClinica = data['logo_clinica'];
    print("logo de la clinica en login ${logoClinica}");

    await SharedPrefsHelper().setLogoClinica(logoClinica);

    print("············································");
    String idUsuario = await SharedPrefsHelper().getId() as String;
    String idClinica = await SharedPrefsHelper().getIdClinica() as String;
    nombreClinica = await SharedPrefsHelper().getNombreClinica() as String;
    logoClinica = await SharedPrefsHelper().getLogoClinica() as String;
    print("············································");

    // Actualizar el estado después de realizar las operaciones asincrónicas
    setState(() {
      ocultarBoton = !ocultarBoton;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext ctx) => const DashBoardScreen(),
        ),
      );
    });

    // Devolver los datos de la clínica como un mapa
    return {
      'nombreClinica': nombreClinica,
      'logoClinica': logoClinica,
    };
  }
  else {
      // Si la solicitud falla, lanzar una excepción o devolver null
      throw Exception('Error al obtener los datos de la clínica.');
      // return null;
    }
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
                  Visibility(
                    visible: !ocultarBoton,
                    child: MyButton(
                      onTap: iniciarSesion,
                      text: "Login".tr(),
                    ),
                  ),
                  //circular progress indicator
                  Visibility(
                      visible: ocultarBoton,
                      child: Container(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(color: Colors.black38 ,),
                      )),

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
