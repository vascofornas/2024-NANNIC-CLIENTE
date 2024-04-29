import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';

class AvatarFromUrlGrande extends StatelessWidget {
  final String imagenUsuario;
  final double size;

  const AvatarFromUrlGrande({
    Key? key,
    required this.imagenUsuario,
    this.size = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Construir la URL de la imagen utilizando imagenUsuario
    final imageUrl = carpetaAdminUsuarios + imagenUsuario;
   // print("url foto $imageUrl");
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Image.network(
        imageUrl,
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          // Manejar el error de carga de imagen aquí
          return Icon(
            Icons.error,
            size: size, // Usar el mismo tamaño que la imagen
          );
        },
      ),
    );
  }
}
