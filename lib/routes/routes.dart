import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/wave_visualisation_screen.dart';
import '../screens/tutorial_solution_screen.dart';
import '../screens/pyp_solution_screen.dart';
import '../screens/cheat_sheet_screen.dart';

class AppRoutes {
  static const String home = "/";
  static const String waveVisualisation = '/wave_visualisation';
  static const String tutorialSolutionScreen = '/tutorial_solution_screen';
  static const String pypSolutionScreen = '/pyp_solution_screen';
  static const String cheatSheet = '/cheat_sheet';
  static const String manim = 'manim';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case waveVisualisation:
        return MaterialPageRoute(builder: (_) => const WaveVisualisationScreen());

      case tutorialSolutionScreen:
        return MaterialPageRoute(builder: (_) => const TutorialSolutionScreen());

      case pypSolutionScreen:
        return MaterialPageRoute(builder: (_) => const PYPSolutionScreen());
        
      case cheatSheet:
        return MaterialPageRoute(builder: (_) => const CheatSheetScreen());
   
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