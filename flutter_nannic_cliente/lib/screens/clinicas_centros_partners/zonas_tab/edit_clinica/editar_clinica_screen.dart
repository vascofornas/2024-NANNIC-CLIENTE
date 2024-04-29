import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/clinica_modelo.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/nueva_clinica_content.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/edit_clinica/editar_clinica_content.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_nannic_cliente/screens/perfil/perfil_content.dart';
import 'package:flutter_nannic_cliente/screens/plantilla/plantilla_content.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_content.dart';

import 'package:provider/provider.dart';

class EditarClinicaPage extends StatefulWidget {
  const EditarClinicaPage({Key? key, required this.clinicaId, required this.clinicaNombre, required this.clinicaEmail, required this.clinicaDireccion, required this.clinicaLogo, required this.clinicaPais, required this.clinicaTel}) : super(key: key);

  final String clinicaId;
  final String clinicaNombre;
  final String clinicaEmail;
  final String clinicaDireccion;
  final String clinicaLogo;
  final String clinicaPais;
  final String clinicaTel;



  @override
  State<EditarClinicaPage> createState() => _EditarClinicaPageState();
}

class _EditarClinicaPageState extends State<EditarClinicaPage> {
  late String emailUsuario = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    capturarDatosUsuario();
  }

  void capturarDatosUsuario() async {
    DatosUsuario datos = await obtenerDatosUsuario();
    print('El email del usuario es: ${datos.email}');
    emailUsuario = datos.email;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,

          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: appPadding,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: Icon( Icons.arrow_back_ios),),
                      SizedBox(width: appPadding,),
                      Container(
                        width: 250,
                          child: MiTextoSimple(texto: widget.clinicaNombre!, color: Colors.grey, fontWeight: FontWeight.bold, fontsize: 24))
                    ],
                  ),
                  EditarClinicaContent(clinicaId: widget.clinicaId,clinicaTel: widget.clinicaTel,clinicaPais: widget.clinicaPais,clinicaNombre: widget.clinicaNombre,clinicaLogo: widget.clinicaLogo,clinicaEmail: widget.clinicaEmail,clinicaDireccion: widget.clinicaDireccion,),
                ],
              ),
            ),
          ),

      ),
    );
  }
}

_onBackButtonPressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("¿Cerrar la app?"),
          content: Text("¿Realmente quieres cerrar la app?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Si"))
          ],
        );
      });
  return exitApp ?? false;
}