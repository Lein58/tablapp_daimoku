import 'package:flutter/material.dart';

// Pantallas implementadas
import 'package:tablapp_daimoku/screens/home_screen.dart';
import 'package:tablapp_daimoku/screens/ajustes_screen.dart';
import 'package:tablapp_daimoku/screens/mis_datos_screen.dart';
import 'package:tablapp_daimoku/screens/objetivos_screen.dart';
import 'package:tablapp_daimoku/screens/horario_de_daimoku_screen.dart';

class TablAppDeDaimoku extends StatelessWidget {
  const TablAppDeDaimoku({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TablApp de Daimoku',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        AjustesScreen.routeName: (context) => const AjustesScreen(),
        MisDatosScreen.routeName: (context) => const MisDatosScreen(),
        ObjetivosScreen.routeName: (context) => const ObjetivosScreen(),
        HorarioDeDaimokuScreen.routeName: (context) =>
            const HorarioDeDaimokuScreen(),
      },
    );
  }
}
