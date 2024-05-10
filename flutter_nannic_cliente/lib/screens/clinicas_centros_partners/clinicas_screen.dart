import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/clinicas_content.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/profesionales_content.dart';


import 'package:provider/provider.dart';

class ClinicasScreen extends StatefulWidget {
  const ClinicasScreen({Key? key, required this.clinicaId}) : super(key: key);
  final String clinicaId;

  @override
  State<ClinicasScreen> createState() => _ClinicasScreenState();
}

class _ClinicasScreenState extends State<ClinicasScreen> {

  late String emailUsuario = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          drawer: DrawerMenu(emailUsuario: emailUsuario,clinicaId: widget.clinicaId,),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context)) Expanded(child: DrawerMenu(emailUsuario: emailUsuario,clinicaId: widget.clinicaId,),),
                Expanded(
                  flex: 5,
                  child: ClinicasContent(clinicaId: widget.clinicaId,),
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


