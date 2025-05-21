import 'package:flutter/material.dart';
import 'package:tablapp_daimoku/screens/bienvenida_screen.dart';
import 'package:tablapp_daimoku/screens/formulario_personal.dart';
import 'package:tablapp_daimoku/screens/home_screen.dart';
import 'package:tablapp_daimoku/screens/horario_y_objetivos.dart';
import 'package:tablapp_daimoku/screens/invocacion_screen.dart'; // Nuevo archivo
import 'package:tablapp_daimoku/screens/temporizador_screen.dart';

class TablAppDeDaimoku extends StatelessWidget {
  const TablAppDeDaimoku({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TablApp de Daimoku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BienvenidaScreen(),
        '/home': (context) => const HomeScreen(),
        '/datos-personales': (context) => const FormularioPersonalScreen(),
        '/objetivos': (context) => const HorarioYObjetivosScreen(),
        '/invocacion': (context) => const InvocacionScreen(), // Pantalla nueva
        '/temporizador': (context) => const TemporizadorScreen(),
      },
    );
  }
}
