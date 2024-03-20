//IMPORTS FLUTTER
import 'package:flutter/material.dart';

class UsuarioProvider extends ChangeNotifier {
  //VARIABLES
  String telefonoUsuario = "";
  String fotoUsuario = "";
  String pantallaSeleccionada = "dashboard";
  int numeroProfesionales = 0;
  int numeroProfesionalesAdministradores = 0;

  bool activado = false;

  //PROVIDER PARA NOTIFICAR SI USUARIO ESTA ACTIVADO O NO
  void changeActivado(bool avatar) {
    activado = avatar;
   notifyListeners();
  }
  //PROVIDER PARA NOTIFICAR SI USUARIO HA CAMBIADO SU TEL
  void cambiarTelUsuarioState(String s) {
    telefonoUsuario = s;
    notifyListeners();
  }
  //PROVIDER PARA NOTIFICAR SI USUARIO HA CAMBIADO SU FOTO
  void cambiarFotoUsuarioState(String s) {
    fotoUsuario = s;
    notifyListeners();
  }
  //PROVIDER PARA NOTIFICAR SI USUARIO HA CAMBIADO LA PANTALLA ABIERTA
  void cambiarPantallaState(String s) {
    pantallaSeleccionada = s;
    notifyListeners();
  }

  //PROVIDER PARA NOTIFICAR EL NUMERO DE PROFESIONALES
  void cambiarNumProfesionalesState(int s) {
    numeroProfesionales = s;
    notifyListeners();
  }
  //PROVIDER PARA NOTIFICAR EL NUMERO DE PROFESIONALES ADM
  void cambiarNumProfesionalesAdministradoresState(int s) {
    numeroProfesionalesAdministradores = s;
    notifyListeners();
  }
}