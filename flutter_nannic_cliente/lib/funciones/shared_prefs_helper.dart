import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  String nombreClinica = "NoNameClinic";
  String logoClinica = "logo_clinica.png";

  // id
  Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  Future<void> setId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
  }

  // email
  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<void> setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  // created at
  Future<String?> getCreatedAt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('created_at');
  }

  Future<void> setCreatedAt(String created_at) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('created_at', created_at);
  }

  // updated_at
  Future<String?> getUpdatedAt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('updated_at');
  }

  Future<void> setUpdatedAt(String updated_at) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('updated_at', updated_at);
  }

  // imagen
  Future<String?> getFoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('imagen');
  }

  Future<void> setFoto(String imagen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagen', imagen);
  }

  // verified
  Future<String?> getVerified() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('verified');
  }

  Future<void> setVerified(String verified) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('verified', verified);
  }

  // nombre
  Future<String?> getNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombre');
  }

  Future<void> setNombre(String nombre) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', nombre);
  }

  // apellidos
  Future<String?> getApellidos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('apellidos');
  }

  Future<void> setApellidos(String apellidos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apellidos', apellidos);
  }

  // nivel_usuario
  Future<String?> getNivelUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nivel_usuario');
  }

  Future<void> setNivelUsuario(String nivelUsuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nivel_usuario', nivelUsuario);
  }

  // activo
  Future<String?> getActivo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('activo');
  }

  Future<void> setActivo(String activo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('activo', activo);
  }

  // tel
  Future<String?> getTel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tel');
  }

  Future<void> setTel(String tel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tel', tel);
  }

  // token FB
  Future<String?> getTokenFB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token_firebase');
  }

  Future<void> setTokenFB(String tokenFB) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token_firebase', tokenFB);
  }

  // cel_verificado
  Future<String?> getCelVerificado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cel_verificado');
  }

  Future<void> setCelVerificado(String celVerificado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cel_verificado', celVerificado);
  }

  // terms
  Future<String?> getTerms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('terms');
  }

  Future<void> setTerms(String terms) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('terms', terms);
  }

  // sistema operativo
  Future<String?> getSOApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('so_app');
  }

  Future<void> setSOApp(String versionApp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('so_app', versionApp);
  }

  // version_app
  Future<String?> getVersionApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('version_app');
  }

  Future<void> setVersionApp(String versionApp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('version_app', versionApp);
  }

  // modelo_dispositivo
  Future<String?> getModeloDisp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('modelo_dispositivo');
  }

  Future<void> setModeloDisp(String modelo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('modelo_dispositivo', modelo);
  }

  // es profesional de clinica
  Future<bool?> getProfesionalClinica() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('esProfesionalClinica');
  }

  Future<void> setEsProfesionalClinica(bool esProfesionalClinica) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('esProfesionalClinica', esProfesionalClinica);
  }

  // es administrador de clinica
  Future<bool?> getAdministradorClinica() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('esAdministradorClinica');
  }

  Future<void> setEsAdministradorClinica(bool esAdministradorClinica) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('esAdministradorClinica', esAdministradorClinica);
  }

  // id clinica del usuario de la app
  Future<String?> getIdClinica() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id_clinica');
  }

  Future<void> setIdClinica(String idClinica) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id_clinica', idClinica);
  }

  // nombre clinica del usuario de la app
  Future<String?> getNombreClinica() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombre_clinica');
  }

  Future<void> setNombreClinica(String nombreClinica) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre_clinica', nombreClinica);
  }

  // logo clinica del usuario de la app
  Future<String?> getLogoClinica() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('logo_clinica');
  }

  Future<void> setLogoClinica(String logoClinica) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('logo_clinica', logoClinica);
  }

  // usuario logeado
  Future<bool?> getLogeado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('logeado');
  }

  Future<void> setLogeado(bool logeado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logeado', logeado);
  }

  // ultimo uso
  Future<String?> getUltimoUsoApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("ultimo_uso_app");
  }

  Future<void> setUltimoUsoApp(String ultimoUsoApp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ultimo_uso_app', ultimoUsoApp);
  }

  // Clear all shared preferences
  Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
