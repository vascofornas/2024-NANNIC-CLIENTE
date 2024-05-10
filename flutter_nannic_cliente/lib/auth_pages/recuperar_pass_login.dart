import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_button.dart';
import 'package:flutter_nannic_cliente/components/my_textfield.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';

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
    var url = 'https://appnannic.com/flutter_api/PHPMailer/enviar_mensaje_pin_pass.php';

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
          "passok".tr(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white);

      Navigator.of(context).pop();

    }
    else{
      Fluttertoast.showToast(
          msg:
          "errorpass".tr(),
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
              "passwordrecovery".tr(),
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
                          'passwordrecoveryrest'.tr(),
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
                      hintText: 'passwordrecoveryrestadm'.tr(),
                      obscureText: false,
                    ),

                    SizedBox(height: 25.0,),
                    MyButton(
                      onTap: (){

                        if(controlEmail.text.isEmpty){
                          Fluttertoast.showToast(
                              msg:
                              "mailobligatorio".tr(),
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

                        }
                      },
                      text: "enviar".tr(),
                    ),

                    SizedBox(height: 30.0,),
                    Visibility(
                      visible: mostrarPin,
                      child: Text(
                        'pincode'.tr(),
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

                            if(v == random){

                              setState(() {
                                mostrarCampos = true;
                              });
                            }
                            else{

                              Fluttertoast.showToast(
                                  msg:
                                  "pincodeerror".tr(),
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
                        hintText: 'nuevapass'.tr(),
                        obscureText: false,
                      ),
                          SizedBox(height: 10.0,),
                          MyTextField(
                            controller: controlPassConfirm,
                            hintText: 'confirmanuevapass'.tr(),
                            obscureText: false,
                          ),
                          SizedBox(height: 10.0,),
                          TextButton(

                            child: Text('passwordrecoveryrest'.tr(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
