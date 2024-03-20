import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/constants/constants.dart';
import 'package:flutter_admin_dashboard/constants/responsive.dart';
import 'package:flutter_admin_dashboard/models/profesional_modelo.dart';
import 'package:flutter_admin_dashboard/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_admin_dashboard/screens/funciones/cambiar_pass_profesional_icon_button.dart';

class ProfesionalCard extends StatefulWidget {
  const ProfesionalCard({super.key, required this.profesional});

  final Profesional profesional;

  @override
  State<ProfesionalCard> createState() => _ProfesionalCardState();
}

class _ProfesionalCardState extends State<ProfesionalCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  print("imagen del usuario es ${carpetaAdminUsuarios}${widget.profesional.imagen}");

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarFromUrl(
                      imageUrl:
                          '${carpetaAdminUsuarios}${widget.profesional.imagen ?? ''}',
                      size: 35,
                    ),
                  ],
                ),
                SizedBox(
                  width: 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.profesional.nombre ?? 'Sin nombre',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if(Responsive.isMobile(context))
                          Container(
                          width: 100,
                          height: 40,
                          child: Text(
                            widget.profesional.apellidos ?? 'Sin apellidos',
                            maxLines: 2,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if(Responsive.isDesktop(context) || Responsive.isTablet(context))
                         Text(
                              widget.profesional.apellidos ?? 'Sin apellidos',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),

                          ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    if(Responsive.isMobile(context))Container(
                        width: 180,
                        height: 40,
                        child: Text(
                          widget.profesional.email ?? 'Sin email',
                          maxLines: 2,
                        )),
                    if(Responsive.isDesktop(context) || Responsive.isTablet(context)) Text(
                          widget.profesional.email ?? 'Sin email',
                          maxLines: 2,
                        ),
                    Text(widget.profesional.tel ?? 'Sin teléfono'),
                  ],
                ),
                SizedBox(
                  width: 3,
                ),
                Spacer(),
                if(Responsive.isMobile(context))Column(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ID",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            Text(
                              '${widget.profesional.id}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        CambiarPassProfesionalIconButton(email: widget.profesional.email,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '¿Activo?',
                              style: TextStyle(fontSize: 10),
                            ),
                            Checkbox(
                              value:
                                  true, // Cambia el valor según el estado del checkbox
                              onChanged: (bool? value) {
                                // Maneja el cambio de estado del checkbox aquí
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                if(Responsive.isDesktop(context) || Responsive.isTablet(context))Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ID",
                              style:
                              TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            Text(
                              '${widget.profesional.id}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        CambiarPassProfesionalIconButton(email: widget.profesional.email),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '¿Activo?',
                              style: TextStyle(fontSize: 10),
                            ),
                            Checkbox(
                              value:
                              true, // Cambia el valor según el estado del checkbox
                              onChanged: (bool? value) {
                                // Maneja el cambio de estado del checkbox aquí
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
