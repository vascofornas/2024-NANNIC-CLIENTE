import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/models/clinica_modelo.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/detalle_clinica_screen.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_pass_profesional_icon_button.dart';

class ClinicaCard extends StatefulWidget {
  const ClinicaCard({super.key, required this.clinica});

  final Clinica clinica;

  @override
  State<ClinicaCard> createState() => _ClinicaCardState();
}

class _ClinicaCardState extends State<ClinicaCard> {
  bool usuarioActivo = false;
  bool usuarioAceptaTerms = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: (){
        print("he pulsado la clinica ${widget.clinica.id}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetalleClinicaScreen(clinicaId: widget.clinica.id!,clinicaTel: widget.clinica.tel_clinica!,clinicaPais: widget.clinica.pais_clinica!,clinicaNombre: widget.clinica.nombre_clinica!,clinicaLogo: widget.clinica.logo_clinica!,clinicaEmail: widget.clinica.email_clinica!,clinicaDireccion: widget.clinica.direccion_clinica!,)),
        );
      },
      child: Card(
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
                        '${carpetaAdminClinicas}${widget.clinica.logo_clinica ?? ''}',
                    size: 60,
                  ),
                  SizedBox(
                    width: appPadding,
                  ),
                  Spacer(),
                  Center(
                    child: Row(
                      children: [
                        Icon(Icons.contact_mail,size: 20,color: Colors.grey,),
                        SizedBox(
                          width: appPadding,
                        ),
                        Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                widget.clinica.email_clinica ?? 'Sin email',
                                maxLines: 2,
                                style: AppFonts.nannic(
                                    fontSize: 16,
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
              //nombre clinica
              Row(
                children: [
                  Icon(Icons.contact_page,size: 20,color: Colors.grey,),
                  SizedBox(
                    width: appPadding,
                  ),

                  Center(
                    child: Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            widget.clinica.nombre_clinica ?? 'Sin nombre',
                            maxLines: 2,
                            style: AppFonts.nannic(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                        )),
                  ),


                ],
              ),
              //direccion clinica
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.pin_drop_outlined,size: 20,color: Colors.grey,),
                  SizedBox(
                    width: appPadding,
                  ),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Container(
                            height: 40,
                            width: 250,
                            child: Text(
                                widget.clinica.direccion_clinica ?? 'Sin dirección',
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                style: AppFonts.nannic(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),

                            ),
                      ),
                   ],
                 ),


                ],
              ),




              //tel clinica
              Row(
                children: [
                  Icon(Icons.contact_phone,size: 20,color: Colors.grey,),
                  SizedBox(
                    width: appPadding,
                  ),

                  Center(
                    child: Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            widget.clinica.tel_clinica ?? 'Sin dirección',
                            maxLines: 2,
                            style: AppFonts.nannic(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                        )),
                  ),


                ],
              ),
              //pais
              //tel clinica
              Row(
                children: [
                  Icon(Icons.flag_outlined,size: 20,color: Colors.grey,),
                  SizedBox(
                    width: appPadding,
                  ),

                  Center(
                    child: Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            widget.clinica.pais_clinica ?? 'Sin  pais',
                            maxLines: 2,
                            style: AppFonts.nannic(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                        )),
                  ),
                  Spacer(),




                ],
              ),






            ],
          ),
        ),
      ),
    );
  }
}
