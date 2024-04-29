import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {

  //id
  static Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }
  static Future<String?> setId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
  }
  //email
  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
  static Future<String?> setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }
  //created at
  static Future<String?> getCreatedAt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('created_at');
  }
  static Future<String?> setCreatedAt(String created_at) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('created_at', created_at);
  }
  //updated_at
  static Future<String?> getUpdatedAt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('updated_at');
  }
  static Future<String?> setUpdatedAt(String updated_at) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('updated_at', updated_at);
  }
  //imagen
  static Future<String?> getFoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('imagen');
  }
  static Future<String?> setFoto(String imagen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imagen', imagen);
  }
  //verified
  static Future<String?> getVerified() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('verified');
  }
  static Future<String?> setVerified(String verified) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('verified', verified);
  }
  //nombre
    static Future<String?> getNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombre');
  }
  static Future<String?> setNombre(String nombre) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nombre', nombre);
  }
  //apellidos
  static Future<String?> getApellidos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('apellidos');
  }
  static Future<String?> setApellidos(String apellidos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('apellidos', apellidos);
  }
  //nivel_usuario
  static Future<String?> getNivelUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nivel_usuario');
  }
  static Future<String?> setNivelUsuario(String nivelUsuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nivel_usuario', nivelUsuario);
  }
  //activo
  static Future<String?> getActivo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('activo');
  }
  static Future<String?> setActivo(String activo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('activo', activo);
  }
  //tel
  static Future<String?> getTel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tel');
  }
  static Future<String?> setTel(String tel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tel', tel);
  }
  //token FB
  static Future<String?> getTokenFB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token_firebase');
  }
  static Future<String?> setTokenFB(String tokenFB) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token_firebase', tokenFB);
  }
  //cel_verificado
  static Future<String?> getCelVerificado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cel_verificado');
  }
  static Future<String?> setCelVerificado(String celVerificado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cel_verificado', celVerificado);
  }
//terms
  static Future<String?> getTerms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('terms');
  }
  static Future<String?> setTerms(String terms) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('terms', terms);
  }
//tel_country
  static Future<String?> getTelCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tel_country');
  }
  static Future<String?> setTelCountry(String telCountry) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tel_country', telCountry);
  }
//version_app
  static Future<String?> getVersionApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('version_app');
  }
  static Future<String?> setVersionApp(String versionApp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('version_app', versionApp);
  }



}
