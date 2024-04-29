import 'package:flutter_nannic_cliente/constants/constants.dart';
import 'package:http/http.dart' as http;

Future<void> guardarDatosDispositivo(String soDispositivo, String versionApp, String modeloDispositivo,String id) async {
  // URL del script PHP en el servidor remoto
  String url = URLProyecto + APICarpeta +'actualizar_datos_usuario_uno.php';


  try {
    // Realizar la solicitud HTTP POST al script PHP
    var response = await http.post(
      Uri.parse(url),
      body: {
        'so_dispositivo': soDispositivo,
        'version_app': versionApp,
        'modelo_dispositivo': modeloDispositivo,
        'id': id,
      },
    );

    // Verificar el estado de la respuesta
    if (response.statusCode == 200) {
      print('Datos del dispositivo guardados correctamente en la base de datos. ${response.body}');
    } else {
      print('Error al guardar los datos del dispositivo. Código de estado: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al enviar los datos del dispositivo al servidor: $e');
  }
}