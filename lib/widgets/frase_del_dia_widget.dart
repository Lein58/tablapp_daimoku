// lib/widgets/frase_del_dia_widget.dart
// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:tablapp_daimoku/services/frase_service.dart';

class FraseDelDiaWidget extends StatelessWidget {
  const FraseDelDiaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FraseDiaria?>(
      future: FraseService.obtenerFraseDelDia(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data;
        if (data == null) {
          return const Text(
            'Aún no hay frase cargada para hoy.',
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          );
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.frase,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
              Text(
                data.referencia,
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        );
      },
    );
  }
}
