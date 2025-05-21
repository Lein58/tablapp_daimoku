import 'package:flutter/material.dart';

class InvocacionScreen extends StatelessWidget {
  const InvocacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invocación de Daimoku')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pantalla de práctica espiritual',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/temporizador'),
              child: const Text('Iniciar Temporizador'),
            ),
          ],
        ),
      ),
    );
  }
}
