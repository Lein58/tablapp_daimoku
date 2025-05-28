// frase_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';

/// Modelo para representar el aliento diario
class FraseDiaria {
  final String texto;
  final String referencia;

  FraseDiaria({required this.texto, required this.referencia});
}

/// Service para cargar y obtener el aliento del día desde aliento_diario.json
class FraseService {
  static Future<FraseDiaria> obtenerAlientoDelDia() async {
    final jsonStr =
        await rootBundle.loadString('assets/json/aliento_diario.json');
    final data = json.decode(jsonStr) as Map<String, dynamic>;

    final now = DateTime.now().toLocal();
    String key = '${now.month}-${now.day}';

    Map<String, dynamic>? entry;
    if (data.containsKey(key)) {
      entry = data[key] as Map<String, dynamic>;
    } else {
      // Fallback: buscar la última fecha anterior o igual a hoy
      final dates = data.keys.map((k) {
        final parts = k.split('-');
        return DateTime(now.year, int.parse(parts[0]), int.parse(parts[1]));
      }).toList()
        ..sort((a, b) => a.compareTo(b));
      DateTime? fallback;
      for (var d in dates.reversed) {
        if (!d.isAfter(now)) {
          fallback = d;
          break;
        }
      }
      if (fallback != null) {
        key = '${fallback.month}-${fallback.day}';
        entry = data[key] as Map<String, dynamic>?;
      }
    }

    if (entry == null) {
      return FraseDiaria(texto: 'Frase no disponible', referencia: '');
    }

    return FraseDiaria(
      texto: entry['frase'] as String,
      referencia: entry['referencia'] as String? ?? '',
    );
  }
}
