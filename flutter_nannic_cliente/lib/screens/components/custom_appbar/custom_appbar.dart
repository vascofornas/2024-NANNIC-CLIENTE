import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/funciones/shared_prefs_helper.dart';
import 'package:flutter_nannic_cliente/screens/components/profile_info.dart';
import 'package:flutter_nannic_cliente/screens/perfil/perfil_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String email = "";

  @override
  void initState() {
    super.initState();
    cargarDatosUsuario();
    print("titulo en appbar ${widget.titulo}");
  }

  void cargarDatosUsuario() async {
    try {
      String? nombreUsuario = await SharedPrefsHelper().getNombre();
      String? fotoUsuario = await SharedPrefsHelper().getFoto();
      String? emailUsuario = await SharedPrefsHelper().getEmail();
      print("avatar $fotoUsuario");
      setState(() {
        nombre = nombreUsuario ?? "";
        foto = fotoUsuario ?? "";
        email = emailUsuario ?? "";
      });
    } catch (e) {
      // Manejar cualquier excepción que ocurra durante la carga de datos
      print('Error al cargar datos de usuario: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: textColor.withOpacity(0.5),
            ),
          ),
        Column(
          children: [
            Text(widget.titulo,
                style: AppFonts.nannic(
                    color: Colors.grey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            Text(email,
                style: AppFonts.nannic(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
