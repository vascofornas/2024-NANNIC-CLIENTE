import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/components/my_button.dart';
import 'package:flutter_admin_dashboard/components/my_textfield.dart';
import 'package:flutter_admin_dashboard/constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:random_string/random_string.dart';
import 'package:http/http.dart' as http;


class RecuperarPassLogin extends StatefulWidget {
  const RecuperarPassLogin({Key? key}) : super(key: key);

  @override
  State<RecuperarPassLogin> createState() => _RecuperarPassLoginState();
}

class _RecuperarPassLoginState extends State<RecuperarPassLogin> {


  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextEditingController controlPass = new TextEditingController();
  TextEditingController controlPassConfirm = new TextEditingController();
  TextEditingController controlEmail = new TextEditingController();
  TextEditingController controlPin = new TextEditingController();
  String _textoInfo ="";
  String email ="";
  bool mostrarPin = false;
  bool mostrarCampos = false;
  String random = randomAlphaNumeric(6);

  Future enviarEmailRestaurarPass(String pin, String email, ) async{




    // API URL
    var url = 'https://appcapenergy.com/PHPMailer/enviar_mensaje_pin_pass.php';



    var data = {
      'pin': pin,
      'email': email



    };


    // Starting Web Call with data.
    var response = await http.post(Uri.parse(url), body: json.encode(data));




    // Getting Server response into variable.
    var message = jsonDecode(response.body);
    setState(() {
      mostrarPin = true;
    });





  }

  void _uploadPass(String pass, String passConfirm,String email, BuildContext context) {
    print(pass);
    if (pass == passConfirm && pass.length >= 6){
      final String phpEndPoint = URLProyecto +APICarpeta +'recuperar_pass_usuario.php';


      print("email pasado a php ${email}");
      print("pass pasado a php ${pass}");
      http.post(Uri.parse(phpEndPoint), body: {
        "password": pass,
        "email": email,
      }).then((res) async {
        print(res.statusCode);

      }).catchError((err) {
        print(err);
      });
      Fluttertoast.showToast(
          msg:
          "Contraseña cambiada",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white);

      Navigator.of(context).pop();

    }
    else{
      Fluttertoast.showToast(
          msg:
          "Error al cambiar la contraseña",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Administración de la app Capenergy",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),


          ],
        ),
      ),
      body:   Column(
            children: [
          Container(
          height: MediaQuery.of(context).size.height * .85,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 25.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Restaurar la contraseña de acceso',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: 25.0,),
                    MyTextField(
                      controller: controlEmail,
                      hintText: 'Escribe aquí tu email de administrador',
                      obscureText: false,
                    ),

                    SizedBox(height: 25.0,),
                    MyButton(
                      onTap: (){
                        print("email a enviar ${controlEmail.text}");
                        print("email a random ${random}");
                        if(controlEmail.text.isEmpty){
                          Fluttertoast.showToast(
                              msg:
                              "Email obligatorio",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);

                        }
                        else{
                          enviarEmailRestaurarPass(random, controlEmail.text, );
                          setState(() {
                            mostrarPin = true;
                          });
                          print("mostrar ${mostrarPin}");
                        }
                      },
                      text: "Enviar",
                    ),

                    SizedBox(height: 30.0,),
                    Visibility(
                      visible: mostrarPin,
                      child: Text(
                        'En breve recibirás un email con un código de verificación',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    SizedBox(height: 10.0,),
                    Visibility(
                      visible: mostrarPin,
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: PinCodeTextField(
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.circle,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          backgroundColor: Theme.of(context).colorScheme.background,
                          enableActiveFill: false,

                          controller: controlPin,
                          onCompleted: (v) {
                            print("Completed");
                            print("pin = ${v}");
                            if(v == random){
                              print("es correcto");
                              setState(() {
                                mostrarCampos = true;
                              });
                            }
                            else{
                              print("no es correcto");
                              Fluttertoast.showToast(
                                  msg:
                                  "Código incorrecto",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white);
                            }
                          },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              // currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          }, appContext: context,
                        ),
                      ),
                    ),

                    Visibility(
                      visible: mostrarCampos,
                      child: Column(
                        children: [
                          MyTextField(
                        controller: controlPass,
                        hintText: 'Escribe aquí tu contraseña nueva',
                        obscureText: false,
                      ),
                          SizedBox(height: 10.0,),
                          MyTextField(
                            controller: controlPassConfirm,
                            hintText: 'Confirma tu contraseña nueva',
                            obscureText: false,
                          ),
                          SizedBox(height: 10.0,),
                          TextButton(

                            child: Text('Cambiar contraseña',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                            onPressed: () {


                              _uploadPass(controlPass.text,controlPassConfirm.text,controlEmail.text,context);



                            },

                          ),
                          Text(_textoInfo),
                          SizedBox(height: 350.0,),

                        ],
                      ),
                    ),

                  ],

                ),
              ),
            ),

          ),
      )

            ],
          ),

    );
  }
}
