//IMPORTS FLUTTER
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

//IMPORTS PUB DEV
import 'package:provider/provider.dart';

//IMPORTS PROYECTO
import 'package:flutter_admin_dashboard/inicio_total.dart';
import 'package:flutter_admin_dashboard/providers/usuario_provider.dart';
import 'package:flutter_admin_dashboard/theme/theme_provider.dart';
import 'package:flutter_admin_dashboard/auth_shared_preferences/auth_manager.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();


  runApp(
    MultiProvider(
      providers: [
        Provider<AuthManager>(
          create: (_) => AuthManager(),
        ),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),



      ],
      child: EasyLocalization(
          path: "idiomas",
          fallbackLocale: Locale("es", "ES"),
          saveLocale: true,
          supportedLocales: [Locale("en", "EN"), Locale("es", "ES"), Locale("fr", "FR"), Locale("nl", "NL"), Locale("de", "DE")],


          child: const MyApp()),
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
