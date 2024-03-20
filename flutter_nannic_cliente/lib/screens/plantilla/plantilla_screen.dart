import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/constants/constants.dart';
import 'package:flutter_admin_dashboard/constants/responsive.dart';
import 'package:flutter_admin_dashboard/funciones/on_will_pop.dart';


import 'package:flutter_admin_dashboard/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_admin_dashboard/screens/plantilla/plantilla_content.dart';
import 'package:flutter_admin_dashboard/screens/profesionales/profesionales_content.dart';

import 'package:provider/provider.dart';

class PlantillaScreen extends StatelessWidget {
  const PlantillaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop:  () => onWillPop(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
          drawer: DrawerMenu(),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context)) Expanded(child: DrawerMenu(),),
                Expanded(
                  flex: 5,
                  child: PlantillaContent(),
                )
              ],
            ),
        ),
      ),
    );
  }
}

_onBackButtonPressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context)
  {
    return AlertDialog(
      title: Text("¿Cerrar la app?"),
      content: Text("¿Realmente quieres cerrar la app?"),
      actions: <Widget>[
        TextButton(onPressed: () {
          Navigator.of(context).pop(false);
        },
            child: Text("No")),
        TextButton(onPressed: () {
          Navigator.of(context).pop(true);
        },
            child: Text("Si"))

      ],
    );
  });
  return exitApp ?? false;
}


