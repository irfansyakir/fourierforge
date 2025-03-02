import 'package:flutter/material.dart';
import '../routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FourierForge'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNavButton(context, 'Waves Visualization', AppRoutes.waveVisualisation),
            _buildNavButton(context, 'Tutorial Solutions', AppRoutes.tutorialSolutionScreen),
            _buildNavButton(context, 'Fourier Series Cheat Sheet', AppRoutes.cheatSheet, 
              icon: Icons.sticky_note_2_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String text, String route, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon),
              const SizedBox(width: 8),
            ],
            Text(text),
          ],
        ),
      ),
    );
  }
}