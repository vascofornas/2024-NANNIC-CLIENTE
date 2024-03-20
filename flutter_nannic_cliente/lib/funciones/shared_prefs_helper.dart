import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static Future<String?> getNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombre');
  }

  static Future<String?> getFoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('foto');
  }
}
