import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/components/my_texto_simple.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/obtener_datos_usuario.dart';
import 'package:flutter_nannic_cliente/funciones/on_will_pop.dart';
import 'package:flutter_nannic_cliente/models/usuario_model.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/zona_administradores_clinica/nuevo_administrador_clinica/nuevo_administrador_clinica_content.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/zonas_tab/zona_profesionales_clinica/nuevo_profesional_clinica/nuevo_profesional_clinica_content.dart';
import 'package:flutter_nannic_cliente/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_nannic_cliente/screens/perfil/perfil_content.dart';
import 'package:flutter_nannic_cliente/screens/plantilla/plantilla_content.dart';
import 'package:flutter_nannic_cliente/screens/profesionales/nuevo_profesional_content.dart';

import 'package:provider/provider.dart';

class NuevoAdministradorClinicaPage extends StatefulWidget {
  const NuevoAdministradorClinicaPage({Key? key, required this.clinicaId, required this.clinicaNombre}) : super(key: key);

  final String clinicaId;
  final String clinicaNombre;

  @override
  State<NuevoAdministradorClinicaPage> createState() => _NuevoAdministradorClinicaPageState();
}

class _NuevoAdministradorClinicaPageState extends State<NuevoAdministradorClinicaPage> {
  late String emailUsuario = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    capturarDatosUsuario();
  }

  void capturarDatosUsuario() async {
    DatosUsuario datos = await obtenerDatosUsuario();

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
                      MiTextoSimple(texto: "datosadminnuevo".tr(), color: Colors.grey, fontWeight: FontWeight.bold, fontsize: 20)
                    ],
                  ),
                  NuevoAdministradorClinicaContent(clinicaId: widget.clinicaId,clinicaNombre: widget.clinicaNombre,),
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
