import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// Pantalla Mis Datos de TablApp de Daimoku
class MisDatosScreen extends StatefulWidget {
  static const String routeName = '/datos-personales';

  const MisDatosScreen({super.key});

  @override
  State<MisDatosScreen> createState() => _MisDatosScreenState();
}

class _MisDatosScreenState extends State<MisDatosScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _regionController;
  late TextEditingController _subregionController;
  late TextEditingController _partidoController;
  late TextEditingController _distritoController;
  late TextEditingController _hanController;
  late TextEditingController _emailController;
  String _countryCode = '';
  String _cityCode = '';
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _apellidoController = TextEditingController();
    _regionController = TextEditingController();
    _subregionController = TextEditingController();
    _partidoController = TextEditingController();
    _distritoController = TextEditingController();
    _hanController = TextEditingController();
    _emailController = TextEditingController();
    _loadDatos();
  }

  Future<File> _getLocalFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/datos_personales.json');
  }

  Future<void> _loadDatos() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        final data =
            json.decode(await file.readAsString()) as Map<String, dynamic>;
        _nombreController.text = data['nombre'] ?? '';
        _apellidoController.text = data['apellido'] ?? '';
        _regionController.text = data['region'] ?? '';
        _subregionController.text = data['subregion'] ?? '';
        _partidoController.text = data['partido'] ?? '';
        _distritoController.text = data['distrito'] ?? '';
        _hanController.text = data['han'] ?? '';
        _emailController.text = data['email'] ?? '';
        final celular = data['celular'] as String? ?? '';
        final parts = celular.split(' ');
        if (parts.length >= 4) {
          _countryCode = parts[0];
          _cityCode = parts[2];
          _phoneNumber = parts.sublist(3).join(' ');
        }
      }
      if (mounted) {
        setState(() {});
      }
    } catch (_) {}
  }

  Future<void> _saveDatos() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    final file = await _getLocalFile();
    final data = {
      'nombre': _nombreController.text,
      'apellido': _apellidoController.text,
      'region': _regionController.text,
      'subregion': _subregionController.text,
      'partido': _partidoController.text,
      'distrito': _distritoController.text,
      'han': _hanController.text,
      'email': _emailController.text,
      'celular': '$_countryCode 9 $_cityCode $_phoneNumber',
    };
    await file.writeAsString(json.encode(data));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos guardados correctamente')),
      );
    }
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese $label';
              }
              return null;
            },
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _regionController.dispose();
    _subregionController.dispose();
    _partidoController.dispose();
    _distritoController.dispose();
    _hanController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Datos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildField(
                label: 'Nombre',
                controller: _nombreController,
                keyboardType: TextInputType.text,
              ),
              _buildField(
                label: 'Apellido',
                controller: _apellidoController,
                keyboardType: TextInputType.text,
              ),
              _buildField(
                label: 'Región',
                controller: _regionController,
                keyboardType: TextInputType.text,
              ),
              _buildField(
                label: 'Subregión',
                controller: _subregionController,
                keyboardType: TextInputType.text,
              ),
              _buildField(
                label: 'Partido o Comunidad',
                controller: _partidoController,
                keyboardType: TextInputType.text,
              ),
              _buildField(
                label: 'Distrito',
                controller: _distritoController,
                keyboardType: TextInputType.text,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Ingrese Distrito';
                  }
                  if (!RegExp(r'^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$').hasMatch(v)) {
                    return 'Solo texto';
                  }
                  return null;
                },
              ),
              _buildField(
                label: 'Han',
                controller: _hanController,
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'usuario@dominio.com',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Ingrese Email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      initialValue: _countryCode,
                      decoration: const InputDecoration(
                        labelText: 'País (+)',
                        hintText: '54',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (v) => _countryCode = v?.trim() ?? '',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('9'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      initialValue: _cityCode,
                      decoration: const InputDecoration(
                        labelText: 'Código ciudad',
                        hintText: '11',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Ingrese código';
                        }
                        if (!RegExp(r'^\d{1,4}$').hasMatch(v)) {
                          return 'Código inválido';
                        }
                        return null;
                      },
                      onSaved: (v) => _cityCode = v?.trim() ?? '',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      initialValue: _phoneNumber,
                      decoration: const InputDecoration(
                        labelText: 'Número',
                        hintText: '12345678',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Ingrese número';
                        }
                        if (!RegExp(r'^\d{8}$').hasMatch(v)) {
                          return 'El número debe tener 8 dígitos';
                        }
                        return null;
                      },
                      onSaved: (v) => _phoneNumber = v?.trim() ?? '',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveDatos,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                  tapTargetSize: MaterialTapTargetSize.padded,
                ),
                child: const Text('Confirmar',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
