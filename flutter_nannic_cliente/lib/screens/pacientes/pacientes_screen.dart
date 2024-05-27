import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/pacientes_content.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesionales_content.dart';


import 'package:provider/provider.dart';

class PacientesScreen extends StatefulWidget {
  const PacientesScreen({Key? key, }) : super(key: key);


  @override
  State<PacientesScreen> createState() => _PacientesScreenState();
}

class _PacientesScreenState extends State<PacientesScreen> {

  late String emailUsuario = "";
  late String idUsuario ="";
  late String idClinica ="";
  late String nombreClinica ="";
  late String logoClinica ="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatosUsuario();

  }
  void getDatosUsuario() async {
    try {
      // Crear una instancia de SharedPrefsHelper
      SharedPrefsHelper prefsHelper = SharedPrefsHelper();

      // Obtener los datos del usuario
      idUsuario = (await prefsHelper.getId())!;
      idClinica = (await prefsHelper.getIdClinica())!;
      nombreClinica = (await prefsHelper.getNombreClinica())!;
      logoClinica = (await prefsHelper.getLogoClinica())!;

      // Imprimir los datos para verificar
      print("idUsuario: $idUsuario");
      print("idClinica: $idClinica");
      print("nombreClinica: $nombreClinica");
      print("logoClinica: $logoClinica");

      // Actualizar el estado
      setState(() {
        // Aquí puedes agregar cualquier lógica adicional que necesites
      });
    } catch (e) {
      print("Error en getDatosUsuario: $e");
    }
  }


  void capturarDatosUsuario() async {
    DatosUsuario datos = await obtenerDatosUsuario();

    emailUsuario = datos.email;
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop:  () => onWillPop(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
          drawer: DrawerMenu(emailUsuario: emailUsuario,clinicaId: idClinica,),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context)) Expanded(child: DrawerMenu(emailUsuario: emailUsuario,
                clinicaId: idClinica,),),
                Expanded(
                  flex: 5,
                  child: PacientesContent(clinicaId: idClinica ,),
                )
              ],
            ),
        ),
      ),
    );
  }
}

_onBackButtonPressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context)
  {
    return AlertDialog(
      title: Text("¿Cerrar la app?"),
      content: Text("¿Realmente quieres cerrar la app?"),
      actions: <Widget>[
        TextButton(onPressed: () {
          Navigator.of(context).pop(false);
        },
            child: Text("No")),
        TextButton(onPressed: () {
          Navigator.of(context).pop(true);
        },
            child: Text("Si"))

      ],
    );
  });
  return exitApp ?? false;
}


