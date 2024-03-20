import 'package:flutter/material.dart';

class AvatarFromUrl extends StatelessWidget {
  final String imageUrl;
  final double size;

  const AvatarFromUrl({
    Key? key,
    required this.imageUrl,
    this.size = 38,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
