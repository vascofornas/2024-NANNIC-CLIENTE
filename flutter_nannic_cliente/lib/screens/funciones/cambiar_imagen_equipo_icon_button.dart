import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_imagen_equipo_dialog.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_pass_profesional_dialog.dart';


class CambiarImagenEquipoIconButton extends StatefulWidget {
  const CambiarImagenEquipoIconButton({Key? key, required this.imagenActual, this.idEquipo}) : super(key: key);

  final String? imagenActual;
  final String? idEquipo;

  @override
  _CambiarImagenEquipoIconButtonState createState() =>
      _CambiarImagenEquipoIconButtonState();
}

class _CambiarImagenEquipoIconButtonState
    extends State<CambiarImagenEquipoIconButton> {


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.camera_alt,
        size: 20,
        color: Colors.grey,
      ),
      onPressed: () {
        buildCambiarImagenEquipoDialog(context,widget.imagenActual,widget.idEquipo);
      },
      tooltip: 'Cambiar contraseña',
    );
  }


}
