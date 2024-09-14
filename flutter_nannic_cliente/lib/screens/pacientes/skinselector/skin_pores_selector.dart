import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_skin_pores_type_paciente.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_skintype_paciente.dart';

enum SkinPoresType {
 small,
  normal,
  large
}


class SkinPoresSelector extends StatefulWidget {

  final String pacienteId;
  final String skinPoresTypeRecibido;

   SkinPoresSelector({super.key, required this.pacienteId, required this.skinPoresTypeRecibido});
  @override
  _SkinPoresSelectorState createState() => _SkinPoresSelectorState();
}

class _SkinPoresSelectorState extends State<SkinPoresSelector> {
  SkinPoresType? _selectedSkinPoresType;
  String valorSkinPoresType = "0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valorSkinPoresType = widget.skinPoresTypeRecibido;
    print("valor recibido de skin type ${valorSkinPoresType} en skinselector");
    _selectedSkinPoresType = getSkinPoresTypeFromValue(valorSkinPoresType);
  }

  SkinPoresType? getSkinPoresTypeFromValue(String value) {
    switch (value) {
      case "1":
        return SkinPoresType.small;
      case "2":
        return SkinPoresType.normal;
      case "3":
        return SkinPoresType.large;
           default:
        return null; // O algún valor por defecto si es necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRadioListTile(SkinPoresType.small, 'small'.tr()),
        _buildRadioListTile(SkinPoresType.normal, 'normal'.tr()),
        _buildRadioListTile(SkinPoresType.large, 'large'.tr()),

      ],
    );
  }

  Widget _buildRadioListTile(SkinPoresType skinType, String title) {
    return RadioListTile<SkinPoresType>(
      title: Text(
        title,
        style: AppFonts.nannic(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey

        )
      ),
      activeColor: Colors.grey,
      value: skinType,
      groupValue: _selectedSkinPoresType,
      onChanged: (SkinPoresType? value) async {
        setState(()  {
          _selectedSkinPoresType = value;
          print("has seleccionado ${_selectedSkinPoresType}");
          if (_selectedSkinPoresType == SkinPoresType.small){
            valorSkinPoresType = "1";

          }
          if (_selectedSkinPoresType == SkinPoresType.normal){
            valorSkinPoresType = "2";
          }
          if (_selectedSkinPoresType == SkinPoresType.large){
            valorSkinPoresType = "3";
          }





        });
        final now = DateTime.now();
        final formatter = DateFormat('yyyy-MM-dd');
        final formattedDate = formatter.format(now);
        await registrarSkinPoresTypePaciente(
        idPaciente: widget.pacienteId,
        valor: valorSkinPoresType,
        fechaActualizacion: formattedDate,
        );
      },
    );
  }

}
