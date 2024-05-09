import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/equipo_modelo.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/nueva_clinica_content.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_nannic_cliente/screens/equipos/edit_equipo_content.dart';
import 'package:flutter_nannic_cliente/screens/equipos/nuevo_equipo_content.dart';
import 'package:flutter_nannic_cliente/screens/perfil/perfil_content.dart';
import 'package:flutter_nannic_cliente/screens/plantilla/plantilla_content.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_content.dart';

import 'package:provider/provider.dart';

class EditEquipoPage extends StatefulWidget {
  const EditEquipoPage({Key? key, required this.equipo, required this.clinicaId}) : super(key: key);

  final Equipo equipo;
  final String clinicaId;

  @override
  State<EditEquipoPage> createState() => _EditEquipoPageState();
}

class _EditEquipoPageState extends State<EditEquipoPage> {
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
                          child: MiTextoSimple(texto: widget.equipo.nombre_equipo!, color: Colors.grey, fontWeight: FontWeight.bold, fontsize: 24))
                    ],
                  ),
                  EditEquipoContent(equipo: widget.equipo,clinicaId: widget.clinicaId,),
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
