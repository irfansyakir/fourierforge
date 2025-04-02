// Updated lib/routes/routes.dart to include the new screens

import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/wave_visualisation_screen.dart';
import '../screens/sample_solution_screen.dart';
import '../screens/cheat_sheet_screen.dart';
import '../screens/problem_solvers_screen.dart'; // New import

class AppRoutes {
  static const String home = "/";
  static const String waveVisualisation = '/wave_visualisation';
  static const String sampleSolutionScreen = '/sample_solution_screen';
  static const String pypSolutionScreen = '/pyp_solution_screen';
  static const String cheatSheet = '/cheat_sheet';
  static const String interactiveProblemSolver = '/problem_solvers_solver'; // New route
  static const String manim = 'manim';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case waveVisualisation:
        return MaterialPageRoute(builder: (_) => const WaveVisualisationScreen());

      case sampleSolutionScreen:
        return MaterialPageRoute(builder: (_) => const SampleSolutionScreen());

      
        
      case cheatSheet:
        return MaterialPageRoute(builder: (_) => const CheatSheetScreen());
        
      case interactiveProblemSolver: // New case
        return MaterialPageRoute(builder: (_) => const InteractiveProblemScreen());
   
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