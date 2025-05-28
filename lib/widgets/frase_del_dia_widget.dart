// frase_del_dia_widget.dart
import 'package:flutter/material.dart';
import '../services/frase_service.dart';

/// Widget que muestra el aliento diario usando FraseService
class FraseDelDiaWidget extends StatelessWidget {
  const FraseDelDiaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FraseDiaria>(
      future: FraseService.obtenerAlientoDelDia(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: \${snapshot.error}'));
        }

        final frase = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Aliento diario.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        frase.texto,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      if (frase.referencia.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          frase.referencia,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
