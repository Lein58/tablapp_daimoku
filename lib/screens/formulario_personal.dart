import 'package:flutter/material.dart';
import '../services/json_service.dart'; // Asegúrate de importar el servicio

class FormularioPersonalScreen extends StatefulWidget {
  const FormularioPersonalScreen({super.key});

  @override
  State<FormularioPersonalScreen> createState() =>
      _FormularioPersonalScreenState();
}

class _FormularioPersonalScreenState extends State<FormularioPersonalScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final int _metaDiaria = 30; // Campo marcado como final

  Future<void> _guardarDatos() async {
    // Método USADO (lo mantenemos)
    if (_formKey.currentState?.validate() ?? false) {
      await JsonService.savePersonalData({
        'nombre': _nombreController.text,
        'metaDiaria': _metaDiaria,
      });
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datos Personales')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            // child requerido para Form
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<int>(
                value: _metaDiaria,
                items:
                    [10, 30, 50, 100].map((value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value Daimokus diarios'),
                      );
                    }).toList(),
                onChanged: (value) {
                  // Aunque _metaDiaria es final, el Dropdown puede actualizar el estado
                  if (value != null) {
                    setState(() {});
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Meta diaria',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _guardarDatos, // Método referenciado aquí
                child: const Text('Guardar Datos'), // child requerido
              ),
            ],
          ),
        ),
      ),
    );
  }
}
