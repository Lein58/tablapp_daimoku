import 'package:flutter/material.dart';
import '../services/json_service.dart';

class ObjetivosScreen extends StatefulWidget {
  const ObjetivosScreen({super.key});
  static const routeName = '/objetivos';

  @override
  State<ObjetivosScreen> createState() => _ObjetivosScreenState();
}

class _ObjetivosScreenState extends State<ObjetivosScreen> {
  List<String> objetivos = [];
  final TextEditingController objetivoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadObjetivos();
  }

  Future<void> _loadObjetivos() async {
    final data = await JsonService.loadJson('objetivos.json');
    setState(() {
      objetivos = List<String>.from(data ?? []);
    });
  }

  Future<void> _saveObjetivos() async {
    await JsonService.saveJson('objetivos.json', objetivos);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void _addObjetivo() {
    final text = objetivoController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        objetivos.add(text);
        objetivoController.clear();
      });
    }
  }

  void _removeObjetivo(int index) {
    setState(() {
      objetivos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Objetivos de Vida')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: objetivos.length,
                itemBuilder: (ctx, i) => ListTile(
                  title: Text(objetivos[i]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeObjetivo(i),
                  ),
                ),
              ),
            ),
            TextField(
              controller: objetivoController,
              decoration: const InputDecoration(labelText: 'Nuevo objetivo'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addObjetivo,
                ),
                ElevatedButton(
                  onPressed: _saveObjetivos,
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
