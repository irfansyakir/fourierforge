import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/main_container_screen.dart';
import '../features/sample_solutions/2122S1/question3_screen.dart';
import '../features/problem_solvers/rectifier/rectifier_problem_screen.dart';
import '../features/problem_solvers/equations/equation_problem_screen.dart';

class AppRoutes {
  static const String home = "/";
  static const String waveVisualisation = '/wave_visualisation';
  static const String sampleSolutionScreen = '/sample_solution_screen';
  static const String pypSolutionScreen = '/pyp_solution_screen';
  static const String cheatSheet = '/cheat_sheet';
  static const String interactiveProblemSolver = '/problem_solvers_solver';
  static const String manim = 'manim';
  static const String rectifierProblem = '/rectifier_problem';
  static const String equationProblem = '/equation_problem';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case waveVisualisation:
        return MaterialPageRoute(builder: (_) => const MainContainerScreen(initialIndex: 0));

      case interactiveProblemSolver:
        return MaterialPageRoute(builder: (_) => const MainContainerScreen(initialIndex: 1));
        
      case sampleSolutionScreen:
        return MaterialPageRoute(builder: (_) => const MainContainerScreen(initialIndex: 2));
        
      case cheatSheet:
        return MaterialPageRoute(builder: (_) => const MainContainerScreen(initialIndex: 3));

      case rectifierProblem:
        return MaterialPageRoute(builder: (_) => const RectifierProblemScreen());
        
      case equationProblem:
        return MaterialPageRoute(builder: (_) => const EquationProblemScreen());
        
      case pypSolutionScreen:
        return MaterialPageRoute(builder: (_) => const AY2122S1Question3Screen());
   
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