import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_pass_profesional_icon_button.dart';

class AdministratorCard extends StatefulWidget {
  const AdministratorCard({super.key, required this.profesional});

  final Profesional profesional;

  @override
  State<AdministratorCard> createState() => _AdministratorCardState();
}

class _AdministratorCardState extends State<AdministratorCard> {
  bool usuarioActivo = false;
  bool usuarioAceptaTerms = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var esActivo = widget.profesional.activo;
    var terms = widget.profesional.terms;

    if (esActivo == "1") {
      usuarioActivo = true;
    } else {
      usuarioActivo = false;
    }
    if (terms == "1") {
      usuarioAceptaTerms = true;
    } else
      usuarioAceptaTerms = false;
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
            //avatar+email
            Row(
              children: [
                AvatarFromUrl(
                  imageUrl:
                      '${carpetaAdminUsuarios}${widget.profesional.imagen ?? ''}',
                  size: 60,
                ),
                SizedBox(
                  width: appPadding,
                ),
                Spacer(),
                Center(
                  child: Row(
                    children: [
                      Icon(Icons.alternate_email,size: 20,color: Colors.grey,),
                      SizedBox(
                        width: appPadding,
                      ),
                      Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              widget.profesional.email ?? 'Sin email',
                              maxLines: 2,
                              style: AppFonts.nannic(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: appPadding,
            ),
            //nombre+apellidos
            Row(
              children: [
                Icon(Icons.person,size: 20,color: Colors.grey,),
                SizedBox(
                  width: appPadding,
                ),

                Center(
                  child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          widget.profesional.nombre ?? 'Sin nombre',
                          maxLines: 2,
                          style: AppFonts.nannic(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      )),
                ),
                SizedBox(
                  width: appPadding / 2,
                ),
                Center(
                  child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          widget.profesional.apellidos ?? 'Sin apellidos',
                          maxLines: 2,
                          style: AppFonts.nannic(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      )),
                ),

              ],
            ),
            Row(
              children: [
                Text(
                  'cambiarpass'.tr(),
                  style: AppFonts.nannic(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                Center(
                  child: CambiarPassProfesionalIconButton(
                    email: widget.profesional.email,
                  ),
                ),
                Spacer(),

              ],
            ),
            SizedBox(
              height: appPadding,
            ),
            //activo, terms
            Row(
              children: [
                Text(
                  'usuarioactivo'.tr()+"?",
                  style: AppFonts.nannic(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                SizedBox(
                  width: appPadding,
                ),

                Checkbox(
                  value:
                  usuarioActivo, // Cambia el valor según el estado del checkbox
                  onChanged: (bool? value) {
                    // Maneja el cambio de estado del checkbox aquí
                    setState(() {
                      usuarioActivo = !usuarioActivo;
                      if(usuarioActivo == false){

                        ApiService().cambiarActivoProfesional(widget.profesional.id!, "0");
                      }
                      else {

                        ApiService().cambiarActivoProfesional(widget.profesional.id!, "1");

                      }
                    });
                  },
                ),
                Spacer(),
                Text(
                  usuarioActivo?'usuarioactivo'.tr():'usuariobloqueado'.tr(),
                  style: AppFonts.nannic(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  width: appPadding,
                ),


              ],
            ),
            SizedBox(
              height: appPadding,
            ),
            Row(
              children: [
                Text(
                  'terminos'.tr()+"?",
                  style: AppFonts.nannic(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                SizedBox(
                  width: appPadding,
                ),


                Spacer(),

                SizedBox(
                  width: appPadding,
                ),

              ],
            ),
            SizedBox(
              height: appPadding,
            ),

            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      child: Text(
                        usuarioAceptaTerms ? 'usuarioaceptaterms'.tr() : 'usuarionoaceptaterms'.tr(),
                        maxLines: 2,
                        style: AppFonts.nannic(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: appPadding,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      'ultimosoydispo'.tr()+": ",
                      maxLines: 2,
                      style: AppFonts.nannic(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )

              ],
            ),
            SizedBox(
              height: appPadding,
            ),
            Row(
              children: [
                Text(
                  widget.profesional.so_dispositivo!+" "+widget.profesional.modelo_dispositivo!,
                  style: AppFonts.nannic(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )

              ],
            ),
            SizedBox(
              height: appPadding,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      'ultimosoydispover'.tr()+": ",
                      maxLines: 2,
                      style: AppFonts.nannic(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )

              ],
            ),
            SizedBox(
              height: appPadding,
            ),
            Row(
              children: [
                Text(
                  'v'+widget.profesional.version_app!,
                  style: AppFonts.nannic(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )

              ],
            )



          ],
        ),
      ),
    );
  }
}
