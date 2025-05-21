import 'dart:convert';
import 'package:flutter/services.dart';

class FraseService {
  static Future<String> obtenerFraseDelDia() async {
    try {
      final archivo = await rootBundle.loadString(
        'assets/json/frase_del_dia.json',
      );
      final data = jsonDecode(archivo);
      final frase = data['frase']?.toString().trim();

      return (frase != null && frase.isNotEmpty)
          ? frase
          : 'Hoy es un buen día para orar con el el corazón.';
    } catch (e) {
      return 'Hoy es un buen día para orar con el corazón.';
    }
  }
}
