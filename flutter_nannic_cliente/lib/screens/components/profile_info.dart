import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';

import 'package:flutter_svg/flutter_svg.dart';


class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key, required this.nombre, required this.foto}) : super(key: key);
  final String nombre;
  final String foto;

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

         Row(
            children: [
              AvatarFromUrl(imageUrl: carpetaAdminUsuarios + widget.foto),
              if(!Responsive.isMobile(context))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: appPadding / 2),
                child: Text('Hola, ${widget.nombre}',style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                ),),
              )
            ],
          ),

      ],
    );
  }
}
