import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/models/clinica_modelo.dart';
import 'package:flutter_nannic_cliente/models/equipo_modelo.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/providers/usuario_provider.dart';
import 'package:flutter_nannic_cliente/screens/clinicas_centros_partners/detalle_clinica_screen.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/equipos/edit_equipo_screen.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_imagen_equipo_icon_button.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_pass_profesional_icon_button.dart';
import 'package:provider/provider.dart';

class EquipoCard extends StatefulWidget {
  const EquipoCard({super.key, required this.equipo, required this.onActualizarEstado});

  final Equipo equipo;

  final VoidCallback onActualizarEstado; // Tipo de la función de actualización

  @override
  State<EquipoCard> createState() => _EquipoCardState();
}

class _EquipoCardState extends State<EquipoCard> {
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditEquipoPage(equipo: widget.equipo,)),
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
              //imagen+nombre
              Row(
                children: [
                  AvatarFromUrl(
                    imageUrl:
                        '${carpetaAdminEquipos}${widget.equipo.imagen_equipo ?? ''}',
                    size: 60,
                  ),


                  Spacer(),
                  Center(
                    child: Row(
                      children: [

                        Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                widget.equipo.nombre_equipo ?? 'Sin nombre',
                                maxLines: 2,
                                style: AppFonts.nannic(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            )),
                        IconButton(onPressed: () async {
                          print("pulsado borrar equipo ${widget.equipo.id}");
                          ApiService().cambiarEstadoEquipo(widget.equipo.id!, "0");

                        var numEquipos =  await Provider.of<UsuarioProvider>(context,listen: false).numeroEquiposNannic;
                          print("numero equipos nannic antes de borrar ${numEquipos}");



                          widget.onActualizarEstado();
                          print("numero equipos nannic antes de borrar ${numEquipos} mas tarde");
                       Provider.of<UsuarioProvider>(context,listen: false).cambiarNumEquiposNannicState(numEquipos - 1);



                        }, icon: Icon(Icons.delete_forever,size: 30,))
                      ],
                    ),
                  ),
                ],
              ),
              //editar nombre
              
                         ],
          ),
        ),
      ),
    );
  }
}
