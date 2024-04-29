//IMPORTS FLUTTER
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nannic_cliente/inicio_total.dart';
import 'package:flutter_nannic_cliente/auth_shared_preferences/auth_manager.dart';
import 'package:flutter_nannic_cliente/inicio_total.dart';
import 'package:flutter_nannic_cliente/providers/usuario_provider.dart';
import 'package:flutter_nannic_cliente/theme/theme_provider.dart';

//IMPORTS PUB DEV
import 'package:provider/provider.dart';

//IMPORTS PROYECTO



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
          fallbackLocale: Locale("en", "EN"),
          saveLocale: true,
          supportedLocales: [Locale("en", "EN"), Locale("sv", "SV"),  Locale("nl", "NL")],


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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: MiWidget(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
