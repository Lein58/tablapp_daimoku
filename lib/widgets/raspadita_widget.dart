// widgets/raspadita_widget.dart
// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:tablapp_daimoku/widgets/frase_del_dia_widget.dart';

class ScratchCardWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onReveal;

  const ScratchCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onReveal,
  });

  @override
  State<ScratchCardWidget> createState() => _ScratchCardWidgetState();
}

class _ScratchCardWidgetState extends State<ScratchCardWidget> {
  bool _revealed = false;

  void _reveal() {
    if (!_revealed) {
      setState(() => _revealed = true);
      widget.onReveal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _reveal,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              _revealed
                  ? ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 100),
                    child: SingleChildScrollView(
                      child: FraseDelDiaWidget(), // SIN const aquí
                    ),
                  )
                  : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
