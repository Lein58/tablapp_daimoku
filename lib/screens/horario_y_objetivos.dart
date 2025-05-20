// lib/screens/horario_y_objetivos_screen.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HorarioYObjetivosScreen extends StatefulWidget {
  static const routeName = '/horario_y_objetivos';
  const HorarioYObjetivosScreen({super.key});

  @override
  State<HorarioYObjetivosScreen> createState() =>
      _HorarioYObjetivosScreenState();
}

class _HorarioYObjetivosScreenState extends State<HorarioYObjetivosScreen> {
  // Objetivos
  final TextEditingController _objetivoController = TextEditingController();
  final List<String> _objetivos = [];
  bool _mostrarFormulario = false;

  // Días y horarios
  final List<String> _dias = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];
  final Map<String, List<Map<String, dynamic>>> _horarios = {};

  @override
  void initState() {
    super.initState();
    _consultarObjetivosExistentes();
  }

  // Archivo de objetivos
  Future<File> _getObjetivosFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/objetivos.json');
  }

  Future<void> _consultarObjetivosExistentes() async {
    final file = await _getObjetivosFile();
    if (await file.exists()) {
      final contenido = await file.readAsString();
      final data = jsonDecode(contenido);
      if (data is List && data.isNotEmpty) {
        final decision = await _preguntarQueHacerConObjetivos();
        if (!mounted) return;
        if (decision == 'modificar') {
          setState(() {
            _objetivos.addAll(data.cast<String>());
            _mostrarFormulario = true;
          });
        } else {
          setState(() => _mostrarFormulario = true);
        }
      } else {
        if (!mounted) return;
        setState(() => _mostrarFormulario = true);
      }
    } else {
      if (!mounted) return;
      setState(() => _mostrarFormulario = true);
    }
  }

  Future<void> _guardarObjetivos() async {
    final file = await _getObjetivosFile();
    await file.writeAsString(jsonEncode(_objetivos));
  }

  Future<void> _agregarObjetivo() async {
    final texto = _objetivoController.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _objetivos.add(texto);
      _objetivoController.clear();
    });

    await _guardarObjetivos();
    if (!mounted) return;

    final respuesta = await showDialog<String>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('¿Querés agregar otro objetivo?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop('no'),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop('sí'),
                child: const Text('Sí'),
              ),
            ],
          ),
    );

    if (!mounted) return;

    if (respuesta == 'sí') {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Future<String?> _preguntarQueHacerConObjetivos() {
    return showDialog<String>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Objetivos ya cargados'),
            content: const Text(
              'Ya hay objetivos guardados. ¿Qué querés hacer?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop('modificar'),
                child: const Text('Modificar / Eliminar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop('agregar'),
                child: const Text('Agregar nuevo'),
              ),
            ],
          ),
    );
  }

  void _eliminarObjetivo(int index) async {
    setState(() => _objetivos.removeAt(index));
    await _guardarObjetivos();
  }

  // Archivo de horarios
  Future<void> _guardarHorarios() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/horarios_de_practica.json');
    await file.writeAsString(jsonEncode(_horarios));
  }

  // Formulario de horarios por día
  Future<void> _mostrarFormularioHorario(String dia) async {
    TimeOfDay? hora1;
    TimeOfDay? hora2;
    final duracion1 = TextEditingController();
    final duracion2 = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (_) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Horarios para $dia',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) hora1 = picked;
                        },
                        child: Text(
                          hora1 == null
                              ? 'Seleccionar hora 1'
                              : 'Hora 1: ${hora1!.format(context)}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: duracion1,
                        decoration: const InputDecoration(
                          labelText: 'Duración 1 (min)',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) hora2 = picked;
                        },
                        child: Text(
                          hora2 == null
                              ? 'Seleccionar hora 2'
                              : 'Hora 2: ${hora2!.format(context)}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: duracion2,
                        decoration: const InputDecoration(
                          labelText: 'Duración 2 (min)',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (hora1 == null ||
                          duracion1.text.isEmpty ||
                          hora2 == null ||
                          duracion2.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Debés completar ambos horarios'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      final horariosDia = <Map<String, dynamic>>[
                        {
                          'hora': hora1!.format(context),
                          'duracion': int.tryParse(duracion1.text) ?? 0,
                        },
                        {
                          'hora': hora2!.format(context),
                          'duracion': int.tryParse(duracion2.text) ?? 0,
                        },
                      ];
                      setState(() => _horarios[dia] = horariosDia);

                      if (dia == 'Lunes') {
                        final repetir = await showDialog<bool>(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                title: const Text('Repetir horario'),
                                content: const Text(
                                  '¿Querés usar el mismo horario de lunes a viernes?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(false),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(true),
                                    child: const Text('Sí'),
                                  ),
                                ],
                              ),
                        );
                        if (!mounted) return;
                        if (repetir == true) {
                          for (var d in [
                            'Martes',
                            'Miércoles',
                            'Jueves',
                            'Viernes',
                          ]) {
                            _horarios[d] = List<Map<String, dynamic>>.from(
                              horariosDia,
                            );
                          }
                        }
                      }

                      await _guardarHorarios();
                      if (!mounted) return;
                      Navigator.pop(context);
                    },
                    child: const Text('Guardar horarios'),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horario de Daimoku y Objetivos')),
      body:
          _mostrarFormulario
              ? Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Ingresá tus objetivos de práctica:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _objetivoController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Escribí tu objetivo aquí...',
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _agregarObjetivo,
                      child: const Text('Aceptar / Guardar'),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Objetivos actuales:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView(
                        children: [
                          ..._objetivos.asMap().entries.map(
                            (entry) => Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                title: Text(
                                  entry.value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _eliminarObjetivo(entry.key),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Carga de horarios semanales:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ..._dias.map(
                            (dia) => ListTile(
                              title: Text(dia),
                              subtitle:
                                  _horarios[dia] != null
                                      ? Text(
                                        _horarios[dia]!
                                            .map(
                                              (h) =>
                                                  '${h['hora']} (${h['duracion']} min)',
                                            )
                                            .join('  |  '),
                                      )
                                      : null,
                              trailing: ElevatedButton(
                                onPressed: () => _mostrarFormularioHorario(dia),
                                child: const Text('Agregar horario'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
