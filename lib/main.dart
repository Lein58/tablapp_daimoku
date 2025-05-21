import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para configurar orientación
import 'app.dart';

void main() async {
  // Asegura la inicialización de bindings de Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Configuración inicial del sistema
  await _setupAppConfig();

  runApp(const TablAppDeDaimoku());
}

Future<void> _setupAppConfig() async {
  // Bloquea la orientación a portrait (opcional)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Configura el estilo de la barra de estado (opcional)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
