// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:tablapp_daimoku/screens/home_screen.dart';
import 'package:tablapp_daimoku/widgets/raspadita_widget.dart';
import 'package:tablapp_daimoku/screens/temporizador_screen.dart';

class BienvenidaScreen extends StatefulWidget {
  static const routeName = '/bienvenida';
  const BienvenidaScreen({super.key});

  @override
  State<BienvenidaScreen> createState() => _BienvenidaScreenState();
}

class _BienvenidaScreenState extends State<BienvenidaScreen> {
  bool _revealed = false;

  void _onReveal() {
    setState(() => _revealed = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenida'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Text(
              '2025: Año de levantar el vuelo hacia una Soka Gakkai juvenil global',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ScratchCardWidget(
              title: 'RASPAR',
              subtitle: 'Aliento de nuestro maestro para hoy',
              onReveal: _onReveal,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      _revealed
                          ? () {
                            Navigator.pushNamed(
                              context,
                              TemporizadorScreen.routeName,
                            );
                          }
                          : null,
                  child: const Text('Invocar'),
                ),
                OutlinedButton(
                  onPressed:
                      _revealed
                          ? () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeScreen.routeName,
                              (route) => false,
                            );
                          }
                          : null,
                  child: const Text('Salir'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
