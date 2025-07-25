import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class JsonService {
  static Future<void> savePersonalData(Map<String, dynamic> data) async {
    await _saveToFile('datos_personales.json', data);
  }

  static Future<void> saveInvocationData(Map<String, dynamic> data) async {
    await _saveToFile('datos_invocacion.json', data);
  }

  static Future<void> saveJson(String archivo, dynamic data) async {
    await _saveToFile(archivo, data);
  }

  static Future<dynamic> loadJson(String archivo) async {
    final contenido = await rootBundle.loadString('assets/json/$archivo');
    return jsonDecode(contenido);
  }

  static Future<Map<String, dynamic>> loadPersonalData() async {
    return await _loadFromFile('datos_personales.json');
  }

  static Future<Map<String, dynamic>> loadInvocationData() async {
    return await _loadFromFile('datos_invocacion.json');
  }

  static Future<void> _saveToFile(
      String filename, Map<String, dynamic> data) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filename');
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      if (kDebugMode) debugPrint('❌ Error guardando $filename: $e');
    }
  }

  static Future<Map<String, dynamic>> _loadFromFile(String filename) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$filename');
      if (await file.exists()) {
        return jsonDecode(await file.readAsString());
      }
    } catch (e) {
      if (kDebugMode) debugPrint('❌ Error leyendo $filename: $e');
    }
    return {};
  }
}
