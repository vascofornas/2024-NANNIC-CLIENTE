//IMPORTS FLUTTER
import 'package:flutter/material.dart';

//IMPORTS PUB DEV
import 'package:provider/provider.dart';

//IMPORTS PROYECTO
import 'package:flutter_admin_dashboard/inicio_total.dart';
import 'package:flutter_admin_dashboard/providers/usuario_provider.dart';
import 'package:flutter_admin_dashboard/theme/theme_provider.dart';
import 'package:flutter_admin_dashboard/auth_shared_preferences/auth_manager.dart';


void main() {
  AuthManager authManager = AuthManager();
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthManager>(
          create: (_) => AuthManager(),
        ),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),



      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MiWidget(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
