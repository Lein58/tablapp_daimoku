// lib/app.dart
// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:tablapp_daimoku/screens/home_screen.dart';
import 'package:tablapp_daimoku/screens/formulario_inicial.dart';
import 'package:tablapp_daimoku/screens/bienvenida_screen.dart';
import 'package:tablapp_daimoku/screens/temporizador_screen.dart';

class TablAppDeDaimoku extends StatelessWidget {
  const TablAppDeDaimoku({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TablApp de Daimoku',
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        FormularioInicialScreen.routeName:
            (_) => const FormularioInicialScreen(),
        BienvenidaScreen.routeName: (_) => const BienvenidaScreen(),
        TemporizadorScreen.routeName: (_) => const TemporizadorScreen(),
        // InformeScreen.routeName: (_) => const InformeScreen(),
      },
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
