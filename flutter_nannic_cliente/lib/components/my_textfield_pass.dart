import 'package:flutter/material.dart';

class MyTextFieldPass extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;



  const MyTextFieldPass({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,



  });

  @override
  State<MyTextFieldPass> createState() => _MyTextFieldPassState();
}

class _MyTextFieldPassState extends State<MyTextFieldPass> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _isHidden, // Cambiar la visibilidad de la contraseña aquí

        decoration: InputDecoration(
          suffix: InkWell(
            onTap: _togglePasswordView,
            child: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off, // Cambiar el icono según el estado
              color: Colors.black45,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

