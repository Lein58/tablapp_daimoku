import 'package:flutter/material.dart';
import '../services/json_service.dart';

class FormularioInvocacionScreen extends StatefulWidget {
  const FormularioInvocacionScreen({super.key});

  @override
  State<FormularioInvocacionScreen> createState() =>
      _FormularioInvocacionScreenState();
}

class _FormularioInvocacionScreenState
    extends State<FormularioInvocacionScreen> {
  bool _notificaciones = true;
  TimeOfDay _horaPractica = const TimeOfDay(hour: 7, minute: 0);

  Future<void> _guardarConfiguracion() async {
    await JsonService.saveInvocationData({
      'notificaciones': _notificaciones,
      'horaPractica': '${_horaPractica.hour}:${_horaPractica.minute}',
    });
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración de Invocación')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Activar recordatorios'),
              value: _notificaciones,
              onChanged: (value) => setState(() => _notificaciones = value),
            ),
            ListTile(
              title: const Text('Hora preferida de práctica'),
              subtitle: Text(_horaPractica.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final hora = await showTimePicker(
                  context: context,
                  initialTime: _horaPractica,
                );
                if (hora != null) setState(() => _horaPractica = hora);
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _guardarConfiguracion,
              child: const Text('Guardar Configuración'),
            ),
          ],
        ),
      ),
    );
  }
}
