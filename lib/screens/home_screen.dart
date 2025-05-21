import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  Future<void> _confirmExit(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('¿Salir de la aplicación?'),
            content: const Text(
              '¿Estás seguro de que deseas cerrar TablApp Daimoku?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Salir'),
              ),
            ],
          ),
    );

    if (shouldExit == true) SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TablApp Daimoku'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          tooltip: 'Salir',
          onPressed: () => _confirmExit(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Acerca de',
            onPressed: () => _showAboutDialog(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botón 1: Datos Personales
            _buildActionButton(
              context,
              icon: Icons.person,
              label: 'Datos Personales',
              description: 'Configura tu información básica',
              route: '/datos-personales',
              color: Colors.blueGrey[700]!,
            ),
            const SizedBox(height: 20),

            // Botón 2: Objetivos y Horario
            _buildActionButton(
              context,
              icon: Icons.flag,
              label: 'Objetivos y Horario',
              description: 'Establece tus metas de práctica',
              route: '/objetivos',
              color: Colors.teal[700]!,
            ),
            const SizedBox(height: 20),

            // Botón 3: Invocación
            _buildActionButton(
              context,
              icon: Icons.self_improvement,
              label: 'Invocación',
              description: 'Comienza tu práctica de Daimoku',
              route: '/invocacion',
              color: Colors.indigo[700]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String description,
    required String route,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, route),
        icon: Icon(icon, size: 28, color: Colors.white),
        label: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 229), // 0.9 * 255 ≈ 229
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Acerca de TablApp Daimoku'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Versión 1.0.0'),
                SizedBox(height: 8),
                Text('Aplicación para el seguimiento de tu práctica budista.'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }
}
