import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToastWidget extends StatelessWidget {
  final String message;

  const CustomToastWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: showToast(),
      builder: (context, snapshot) {
        // No necesitas devolver ningún widget aquí, ya que el toast se mostrará y desaparecerá automáticamente.
        return SizedBox.shrink();
      },
    );
  }

  Future<void> showToast() async {
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

