// lib/screens/formulario_inicial.dart
// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FormularioInicialScreen extends StatefulWidget {
  static const routeName = '/';
  const FormularioInicialScreen({super.key});

  @override
  State<FormularioInicialScreen> createState() =>
      _FormularioInicialScreenState();
}

class _FormularioInicialScreenState extends State<FormularioInicialScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _partidoController = TextEditingController();
  final TextEditingController _localidadController = TextEditingController();
  final TextEditingController _hanController = TextEditingController();

  DateTime? _fechaNacimiento;
  String? _division;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/datos_personales.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        final data = jsonDecode(content);
        setState(() {
          _apellidoController.text = data['apellido'] ?? '';
          _nombreController.text = data['nombre'] ?? '';
          _partidoController.text = data['partido'] ?? '';
          _localidadController.text = data['localidad'] ?? '';
          _hanController.text = data['han'] ?? '';
          _division = data['division'];
          if (data['fechaNacimiento'] != null) {
            _fechaNacimiento = DateTime.tryParse(data['fechaNacimiento']);
          }
        });
      }
    } catch (_) {
      // Silencio: ignorar error de carga
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _partidoController.dispose();
    _localidadController.dispose();
    _hanController.dispose();
    super.dispose();
  }

  Future<void> _selectFecha() async {
    final ahora = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _fechaNacimiento ?? ahora,
      firstDate: DateTime(1900),
      lastDate: ahora,
    );
    if (picked != null) {
      setState(() => _fechaNacimiento = picked);
    }
  }

  String _fechaTexto() {
    if (_fechaNacimiento == null) return '--/--/----';
    return '${_fechaNacimiento!.day.toString().padLeft(2, '0')}/'
        '${_fechaNacimiento!.month.toString().padLeft(2, '0')}/'
        '${_fechaNacimiento!.year}';
  }

  Future<void> _guardarDatosYVolverInicio() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/datos_personales.json');

    final data = {
      'apellido': _apellidoController.text,
      'nombre': _nombreController.text,
      'fechaNacimiento': _fechaNacimiento?.toIso8601String(),
      'division': _division,
      'partido': _partidoController.text,
      'localidad': _localidadController.text,
      'han': _hanController.text,
    };

    await file.writeAsString(jsonEncode(data));
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  void _mostrarDialogoConfirmacion() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('¿Los datos son correctos?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _guardarDatosYVolverInicio();
                },
                child: const Text('Sí'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            TextFormField(
              controller: _apellidoController,
              decoration: const InputDecoration(labelText: 'Apellido'),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Fecha de nacimiento',
              ),
              child: InkWell(
                onTap: _selectFecha,
                child: Text(
                  _fechaTexto(),
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        _fechaNacimiento == null ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _division,
              decoration: const InputDecoration(labelText: 'División'),
              items: const [
                DropdownMenuItem(value: 'DJM', child: Text('DJM')),
                DropdownMenuItem(value: 'DJF', child: Text('DJF')),
                DropdownMenuItem(value: 'DS', child: Text('DS')),
                DropdownMenuItem(value: 'DD', child: Text('DD')),
                DropdownMenuItem(value: 'MH', child: Text('MH')),
              ],
              onChanged: (v) => setState(() => _division = v),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _partidoController,
              decoration: const InputDecoration(labelText: 'Partido'),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              controller: _localidadController,
              decoration: const InputDecoration(labelText: 'Localidad'),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              controller: _hanController,
              decoration: const InputDecoration(labelText: 'Han'),
              textInputAction: TextInputAction.done,
              onEditingComplete: _mostrarDialogoConfirmacion,
            ),
          ],
        ),
      ),
    );
  }
}
