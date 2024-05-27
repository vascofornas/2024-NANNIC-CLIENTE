import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<void> guardarDatosDispositivo(String soDispositivo, String versionApp, String modeloDispositivo,String id) async {
  // URL del script PHP en el servidor remoto
  String url = URLProyecto + APICarpeta +'actualizar_datos_usuario_uno.php';
  var ultimo_uso = DateTime.now();
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  print("actualizando datos usuario ${ultimo_uso}");


  try {
    // Realizar la solicitud HTTP POST al script PHP
    var response = await http.post(
      Uri.parse(url),
      body: {
        'so_dispositivo': soDispositivo,
        'version_app': versionApp,
        'modelo_dispositivo': modeloDispositivo,
        'ultimo_uso': formattedDate,
        'id': id,
      },
    );

    // Verificar el estado de la respuesta
    if (response.statusCode == 200) {

    } else {

    }
  } catch (e) {

  }
}