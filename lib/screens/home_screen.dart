import 'package:flutter/material.dart';

import 'ajustes_screen.dart';
import '../widgets/frase_del_dia_widget.dart';

/// Pantalla Home de TablApp de Daimoku
class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Widget de aliento diario reutilizable
              const FraseDelDiaWidget(),
              const SizedBox(height: 24),
              // Botones principales
              NavButton(
                label: '🔧 Ajustes',
                icon: Icons.settings,
                onTap: () =>
                    Navigator.pushNamed(context, AjustesScreen.routeName),
              ),
              const SizedBox(height: 8),
              NavButton(
                label: '🗓️ Agenda',
                icon: Icons.calendar_today,
                onTap: () => Navigator.pushNamed(context, '/horarios'),
              ),
              const SizedBox(height: 8),
              NavButton(
                label: '📊 Estadísticas',
                icon: Icons.bar_chart,
                onTap: () => Navigator.pushNamed(context, '/informe'),
              ),
              const SizedBox(height: 8),
              NavButton(
                label: '🙏 A practicar!',
                icon: Icons.self_improvement,
                onTap: () => Navigator.pushNamed(context, '/invocacion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const NavButton({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 2,
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
      onPressed: onTap,
    );
  }
}
