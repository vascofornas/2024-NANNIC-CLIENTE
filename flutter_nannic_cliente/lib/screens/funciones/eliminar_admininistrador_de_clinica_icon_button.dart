import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_pass_profesional_dialog.dart';
import 'package:flutter_nannic_cliente/screens/funciones/eliminar_administrador_clinica_dialog.dart';
import 'package:flutter_nannic_cliente/screens/funciones/eliminar_profesional_clinica_dialog.dart';


class EliminarAdministradorClinicaIconButton extends StatefulWidget {
  const EliminarAdministradorClinicaIconButton({Key? key, this.profesionalId, this.clinicaId, this.profesionalNombre, this.onUpdate}) : super(key: key);

  final String? profesionalId;
  final String? clinicaId;
  final String? profesionalNombre;
  final VoidCallback? onUpdate; // Define el tipo del callback

  @override
  _EliminarAdministradorClinicaIconButtonState createState() =>
      _EliminarAdministradorClinicaIconButtonState();
}

class _EliminarAdministradorClinicaIconButtonState
    extends State<EliminarAdministradorClinicaIconButton> {


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
    print("profesional a quitar de clinica ${widget.profesionalNombre} ${widget.profesionalId} ${widget.clinicaId}");
    return IconButton(
      icon: Icon(
        Icons.delete_forever_rounded,
        size: 30,
        color: Colors.red,
      ),
      onPressed: () {
        buildEliminarAdministradorClinicaDialog(context,widget.clinicaId,widget.profesionalNombre,widget.profesionalId,widget.onUpdate);
        // Llamar al callback onUpdate después de eliminar el profesional
        if (widget.onUpdate != null) {
          widget.onUpdate!();
        }

      },
      tooltip: 'Cambiar contraseña',
    );
  }


}
