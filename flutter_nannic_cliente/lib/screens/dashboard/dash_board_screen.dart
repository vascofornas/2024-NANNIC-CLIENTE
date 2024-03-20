import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard/constants/constants.dart';
import 'package:flutter_admin_dashboard/constants/responsive.dart';
import 'package:flutter_admin_dashboard/funciones/on_will_pop.dart';
import 'package:flutter_admin_dashboard/screens/components/drawer/drawer_menu.dart';
import 'package:flutter_admin_dashboard/screens/dashboard/dashboard_content.dart';

import 'package:provider/provider.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {



    return WillPopScope(
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
                child: DashboardContent(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
