// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  Future<void> _confirmExit(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('¿Desea salir de la aplicación?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Sí'),
              ),
            ],
          ),
    );
    if (result == true) {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TablApp de Daimoku'),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () => _confirmExit(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a tu App de Budismo Soka',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Registra tu información inicial, accede al aliento diario o consulta tu práctica.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              child: const Text('Ingresar/Modificar Datos Iniciales'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  () => Navigator.pushNamed(context, '/horario_y_objetivos'),
              child: const Text('Cargar objetivos y horario de práctica'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/bienvenida'),
              child: const Text('Invocar - Aliento Diario'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/informe'),
              child: const Text('Informe de mi práctica'),
            ),
          ],
        ),
      ),
    );
  }
}
