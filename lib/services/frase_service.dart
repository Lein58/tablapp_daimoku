// services/frase_service.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class FraseDiaria {
  final String frase;
  final String referencia;
  FraseDiaria(this.frase, this.referencia);
}

class FraseService {
  static Future<FraseDiaria?> obtenerFraseDelDia() async {
    try {
      final ahora = DateTime.now();
      final clave = '${ahora.month}-${ahora.day}';
      final jsonStr = await rootBundle.loadString(
        'assets/json/aliento_diario.json',
      );
      final Map<String, dynamic> data = json.decode(jsonStr);
      final entry = data[clave] as Map<String, dynamic>?;
      if (entry == null) return null;
      return FraseDiaria(
        entry['frase'] as String,
        entry['referencia'] as String,
      );
    } catch (_) {
      return null;
    }
  }
}
