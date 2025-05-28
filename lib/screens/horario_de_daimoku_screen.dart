import 'package:flutter/material.dart';
import '../services/json_service.dart';

class HorarioDeDaimokuScreen extends StatefulWidget {
  const HorarioDeDaimokuScreen({super.key});
  static const routeName = '/horario_daimoku';

  @override
  State<HorarioDeDaimokuScreen> createState() => _HorarioDeDaimokuScreenState();
}

class _HorarioDeDaimokuScreenState extends State<HorarioDeDaimokuScreen> {
  static const diasSemana = [
    'lunes',
    'martes',
    'miércoles',
    'jueves',
    'viernes',
    'sábado',
    'domingo'
  ];

  static const horas = [
    '05:00',
    '05:30',
    '06:00',
    '06:30',
    '07:00',
    '07:30',
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
    '19:00',
    '19:30',
    '20:00',
    '20:30',
    '21:00',
    '21:30',
    '22:00',
    '22:30',
    '23:00',
    '23:30'
  ];

  List<ScheduleEntry> horarios = [];

  @override
  void initState() {
    super.initState();
    _loadHorarios();
  }

  Future<void> _loadHorarios() async {
    final data = await JsonService.loadJson('horarios_de_practica.json');
    setState(() {
      horarios = (data as List<dynamic>?)
              ?.map((e) => ScheduleEntry.fromMap(e))
              .toList() ??
          [];
    });
  }

  Future<void> _saveHorarios() async {
    await JsonService.saveJson(
      'horarios_de_practica.json',
      horarios.map((e) => e.toMap()).toList(),
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void _addHorario() {
    setState(() {
      horarios.add(ScheduleEntry(dia: diasSemana.first, hora: horas.first));
    });
  }

  void _removeHorario(int index) {
    setState(() {
      horarios.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horarios de Daimoku')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: horarios.length,
                itemBuilder: (ctx, i) {
                  final schedule = horarios[i];
                  return Row(
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          value: schedule.dia,
                          items: diasSemana
                              .map((d) =>
                                  DropdownMenuItem(value: d, child: Text(d)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => schedule.dia = val);
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          value: schedule.hora,
                          items: horas
                              .map((h) =>
                                  DropdownMenuItem(value: h, child: Text(h)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => schedule.hora = val);
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeHorario(i),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar horario'),
                  onPressed: _addHorario,
                ),
                ElevatedButton(
                  onPressed: _saveHorarios,
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleEntry {
  String dia;
  String hora;
  ScheduleEntry({required this.dia, required this.hora});
  Map<String, dynamic> toMap() => {'dia': dia, 'hora': hora};
  factory ScheduleEntry.fromMap(Map<String, dynamic> m) =>
      ScheduleEntry(dia: m['dia'], hora: m['hora']);
}
