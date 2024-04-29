import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_pass_profesional_dialog.dart';


class CambiarPassProfesionalIconButton extends StatefulWidget {
  const CambiarPassProfesionalIconButton({Key? key, required this.email}) : super(key: key);

  final String? email;

  @override
  _CambiarPassProfesionalIconButtonState createState() =>
      _CambiarPassProfesionalIconButtonState();
}

class _CambiarPassProfesionalIconButtonState
    extends State<CambiarPassProfesionalIconButton> {
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.lock,
        size: 30,
        color: Colors.red,
      ),
      onPressed: () {
        buildCambiarPassProfesionalDialog(context,_passwordController,widget.email);
      },
      tooltip: 'Cambiar contraseña',
    );
  }


}
