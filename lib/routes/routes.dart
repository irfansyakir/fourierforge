import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/wave_visualisation_screen.dart';

class AppRoutes {
  static const String home = "/";
  static const String waveVisualisation = '/wave_visualisation';

   static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case waveVisualisation:
        return MaterialPageRoute(builder: (_) => const WaveVisualisationScreen());

   
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}