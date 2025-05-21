// Widget para mostrar la frase del día en la pantalla de bienvenida

import 'package:flutter/material.dart';
import 'package:tablapp_daimoku/services/frase_service.dart';

class FraseDelDiaWidget extends StatefulWidget {
  const FraseDelDiaWidget({super.key});

  @override
  State<FraseDelDiaWidget> createState() => _FraseDelDiaWidgetState();
}

class _FraseDelDiaWidgetState extends State<FraseDelDiaWidget> {
  String frase = '';

  @override
  void initState() {
    super.initState();
    cargarFrase();
  }

  Future<void> cargarFrase() async {
    final fraseCargada = await FraseService.obtenerFraseDelDia();
    setState(() {
      frase = fraseCargada;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Text(
          frase,
          style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
