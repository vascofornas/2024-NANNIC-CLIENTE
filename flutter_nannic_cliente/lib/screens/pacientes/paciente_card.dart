import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nannic_cliente/api_services/api_services.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:flutter_nannic_cliente/constants/responsive.dart';
import 'package:flutter_nannic_cliente/models/paciente_modelo.dart';
import 'package:flutter_nannic_cliente/models/profesional_modelo.dart';
import 'package:flutter_nannic_cliente/screens/components/imagenes/avatar_from_url.dart';
import 'package:flutter_nannic_cliente/screens/funciones/cambiar_pass_profesional_icon_button.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/datos_paciente/paciente_datos.dart';
import 'package:flutter_nannic_cliente/screens/pacientes/editar_paciente_screen.dart';
import 'package:http/http.dart' as http;

class PacienteCard extends StatefulWidget {
  const PacienteCard({super.key, required this.paciente});

  final Paciente paciente;

  @override
  State<PacienteCard> createState() => _PacienteCardState();
}

class _PacienteCardState extends State<PacienteCard> {
  bool usuarioActivo = false;
  bool usuarioAceptaTerms = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var esActivo = widget.paciente.activo;


    if (esActivo == "1") {
      usuarioActivo = true;
    } else {
      usuarioActivo = false;
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('confirmarborradopaciente'.tr()),
          content: Text('seguroconfirmarborradopaciente'.tr()),
          actions: <Widget>[
            TextButton(
              child: Text('cancelar'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('confirmarborradopaciente'.tr()),
              onPressed: () {
                // Llama a la función para marcar al paciente como inactivo
                _deletePatient(widget.paciente.id_paciente!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deletePatient(String patientId) async {
    final url = Uri.parse(URLProyecto+APICarpeta+"cambiar_estado_no_activo_paciente.php");
    final response = await http.post(
      url,
      body: {
        'id': patientId.toString(),
      },
    );

    if (response.statusCode == 200) {
      print('Paciente eliminado exitosamente');
      // Actualiza el estado local si es necesario
    } else {
      print('Error al eliminar el paciente: ${response.reasonPhrase}');
      // Maneja el error
    }
  }


  @override
  Widget build(BuildContext context) {
    //  print("imagen del usuario es ${carpetaAdminUsuarios}${widget.profesional.imagen}");

    return GestureDetector(
      onTap: (){
        print("datos del paciente para editar: imagen ${widget.paciente.imagen_paciente}");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>DatosPaciente(paciente: widget.paciente,)),
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
                        '${carpetaAdminPacientes}${widget.paciente.imagen_paciente ?? ''}',
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
                                widget.paciente.email_paciente ?? 'Sin email',
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
                            widget.paciente.nombre ?? 'Sin nombre',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //editar paciente
                  GestureDetector(
                    onTap: (){
                      //alert dialog para borrar paciente(pasar a activo=0)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>EditarPacientePage(paciente: widget.paciente,)),
                      );

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.edit,size: 40,color: Colors.grey,),
                        SizedBox(
                          width: appPadding,
                        ),
                      ],
                    ),
                  ),
                  //borrar paciente
                  GestureDetector(
                    onTap: (){
                      //alert dialog para borrar paciente(pasar a activo=0)
                      _showDeleteConfirmationDialog(context);

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.delete,size: 40,color: Colors.red,),
                        SizedBox(
                          width: appPadding,
                        ),
                      ],
                    ),
                  ),

                ],
              )









            ],
          ),
        ),
      ),
    );
  }
}
