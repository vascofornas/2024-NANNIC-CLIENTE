import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/constants/constants.dart';
import 'package:flutter_admin_dashboard/constants/responsive.dart';
import 'package:flutter_admin_dashboard/funciones/shared_prefs_helper.dart';

import 'package:flutter_admin_dashboard/screens/components/profile_info.dart';
import 'package:flutter_admin_dashboard/screens/components/search_field.dart';

import 'package:provider/provider.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({Key? key, required this.titulo}) : super(key: key);
  final String titulo;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {

  String nombre = "";
  String foto = "";

  @override
  void initState() {
    super.initState();
    cargarDatosUsuario();
  }

  void cargarDatosUsuario() async {
    String? nombreUsuario = await SharedPrefsHelper.getNombre();
    String? fotoUsuario = await SharedPrefsHelper.getFoto();
    setState(() {
      nombre = nombreUsuario ?? "";
      foto = fotoUsuario ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu,color: textColor.withOpacity(0.5),),
          ),
        Text(
          widget.titulo,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 28,
            fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),


        foto.isEmpty
            ? CircularProgressIndicator() // Muestra un indicador de carga mientras se obtiene la imagen
            : ProfileInfo(nombre: nombre, foto: foto,)
      ],
    );
  }
}
