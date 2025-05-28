import 'package:flutter/material.dart';

class AjustesScreen extends StatelessWidget {
  static const routeName = '/ajustes';

  const AjustesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Mis datos'),
            onTap: () => Navigator.pushNamed(context, '/mis_datos'),
          ),
          ListTile(
            title: const Text('Objetivos de vida'),
            onTap: () => Navigator.pushNamed(context, '/objetivos'),
          ),
          ListTile(
            title: const Text('Horario de Daimoku'),
            onTap: () => Navigator.pushNamed(context, '/horario_daimoku'),
          ),
          ListTile(
            title: const Text('Aliento diario'),
            onTap: () => Navigator.pushNamed(context, '/aliento_diario'),
          ),
          ListTile(
            title: const Text('Informe de práctica'),
            onTap: () => Navigator.pushNamed(context, '/informe_practica'),
          ),
        ],
      ),
    );
  }
}
