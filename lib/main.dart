import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart'; // Asegurate de que existe y exporta TablAppDeDaimoku

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloquea la orientación a portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Estilo barra de estado
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const TablAppDeDaimoku());
}
