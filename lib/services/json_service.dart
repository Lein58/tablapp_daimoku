import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class JsonService {
  // Guardar datos personales
  static Future<void> savePersonalData(Map<String, dynamic> data) async {
    await _saveToFile('datos_personales.json', data);
  }

  // Guardar datos de invocación
  static Future<void> saveInvocationData(Map<String, dynamic> data) async {
    await _saveToFile('datos_invocacion.json', data);
  }

  // Método PRIVADO para guardar
  static Future<void> _saveToFile(
    String filename,
    Map<String, dynamic> data,
  ) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filename');
      await file.writeAsString(jsonEncode(data));
      if (kDebugMode) {
        debugPrint('✅ Datos guardados en: ${file.path}');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error: $e');
      }
    }
  }

  // Cargar datos personales
  static Future<Map<String, dynamic>> loadPersonalData() async {
    return await _loadFromFile('datos_personales.json');
  }

  // Cargar datos de invocación
  static Future<Map<String, dynamic>> loadInvocationData() async {
    return await _loadFromFile('datos_invocacion.json');
  }

  // Método PRIVADO para cargar
  static Future<Map<String, dynamic>> _loadFromFile(String filename) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filename');
      if (await file.exists()) {
        return jsonDecode(await file.readAsString());
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error: $e');
      }
    }
    return {};
  }
}
