import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/constants/app_fonts.dart';
import 'package:flutter_nannic_cliente/screens/funciones/registrar_skintype_paciente.dart';

enum SkinType {
  dehydrated,
  normal,
  oily,
  combination,
  localDehydrated,
}


class SkinTypeSelector extends StatefulWidget {

  final String pacienteId;
  final String skinTypeRecibido;

   SkinTypeSelector({super.key, required this.pacienteId, required this.skinTypeRecibido});
  @override
  _SkinTypeSelectorState createState() => _SkinTypeSelectorState();
}

class _SkinTypeSelectorState extends State<SkinTypeSelector> {
  SkinType? _selectedSkinType;
  String valorSkinType = "0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valorSkinType = widget.skinTypeRecibido;
    print("valor recibido de skin type ${valorSkinType} en skinselector");
    _selectedSkinType = getSkinTypeFromValue(valorSkinType);
  }

  SkinType? getSkinTypeFromValue(String value) {
    switch (value) {
      case "1":
        return SkinType.dehydrated;
      case "2":
        return SkinType.normal;
      case "3":
        return SkinType.oily;
      case "4":
        return SkinType.combination;
      case "5":
        return SkinType.localDehydrated;
      default:
        return null; // O algún valor por defecto si es necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRadioListTile(SkinType.dehydrated, 'dehydrated'.tr()),
        _buildRadioListTile(SkinType.normal, 'normal'.tr()),
        _buildRadioListTile(SkinType.oily, 'oily'.tr()),
        _buildRadioListTile(SkinType.combination, 'combination'.tr()),
        _buildRadioListTile(SkinType.localDehydrated, 'localdehydrated'.tr()),
      ],
    );
  }

  Widget _buildRadioListTile(SkinType skinType, String title) {
    return RadioListTile<SkinType>(
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
      groupValue: _selectedSkinType,
      onChanged: (SkinType? value) async {
        setState(()  {
          _selectedSkinType = value;
          print("has seleccionado ${_selectedSkinType}");
          if (_selectedSkinType == SkinType.dehydrated){
            valorSkinType = "1";

          }
          if (_selectedSkinType == SkinType.normal){
            valorSkinType = "2";
          }
          if (_selectedSkinType == SkinType.oily){
            valorSkinType = "3";
          }
          if (_selectedSkinType == SkinType.combination){
            valorSkinType = "4";
          }
          if (_selectedSkinType == SkinType.localDehydrated){
            valorSkinType = "5";
          }
          print("valor skinType ${valorSkinType} paciente ${widget.pacienteId}");



        });
        final now = DateTime.now();
        final formatter = DateFormat('yyyy-MM-dd');
        final formattedDate = formatter.format(now);
        await registrarSkinTypePaciente(
        idPaciente: widget.pacienteId,
        valor: valorSkinType,
        fechaActualizacion: formattedDate,
        );
      },
    );
  }

}
