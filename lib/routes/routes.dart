import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/main_container_screen.dart';

class AppRoutes {
  // Define all the routes in the app
  static const String home = "/";
  static const String waveVisualisation = '/wave_visualisation';
  static const String sampleSolutionScreen = '/sample_solution_screen';
  static const String cheatSheet = '/cheat_sheet';
  static const String interactiveProblemSolver = '/problem_solvers_solver';

  // Generate routes based on the route name
  // This function is called when a named route is pushed
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Home Screen
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // Main Container Screen
      // This screen contains the main features of the app
      case waveVisualisation:
        return MaterialPageRoute(builder: (_) => const MainContainerScreen(initialIndex: 0));

      case interactiveProblemSolver:
        return MaterialPageRoute(builder: (_) => const MainContainerScreen(initialIndex: 1));
        
      case sampleSolutionScreen:
        return MaterialPageRoute(builder: (_) => const MainContainerScreen(initialIndex: 2));
        
      case cheatSheet:
        return MaterialPageRoute(builder: (_) => const MainContainerScreen(initialIndex: 3));
  
      default:
        return _errorRoute();
    }
  }

  // Error route for undefined routes
  // This function is called when a route is not found
  // It returns a simple error page
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}