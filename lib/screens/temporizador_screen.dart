// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'dart:async';

class TemporizadorScreen extends StatefulWidget {
  static const routeName = '/temporizador';
  const TemporizadorScreen({super.key});

  @override
  State<TemporizadorScreen> createState() => _TemporizadorScreenState();
}

class _TemporizadorScreenState extends State<TemporizadorScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _running = false;

  void _startTimer() {
    if (_running) return;
    setState(() {
      _running = true;
      _seconds = 0;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds++);
    });
  }

  void _stopTimer() {
    if (!_running) return;
    _timer?.cancel();
    setState(() {
      _running = false;
    });
    // Aquí podrías preguntar si hizo gongyo y registrar
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temporizador Daimoku')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_formatTime(_seconds), style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _running ? null : _startTimer,
                  child: const Text('Iniciar'),
                ),
                ElevatedButton(
                  onPressed: _running ? _stopTimer : null,
                  child: const Text('Detener'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
