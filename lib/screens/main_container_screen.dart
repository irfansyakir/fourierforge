import 'package:flutter/material.dart';
import 'package:fourier_forge/themes/colours.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'wave_visualisation_screen.dart';
import 'problem_solvers_screen.dart';
import 'sample_solution_screen.dart';
import 'cheat_sheet_screen.dart';

class MainContainerScreen extends StatefulWidget {
  final int initialIndex;
  
  const MainContainerScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainContainerScreen> createState() => _MainContainerScreenState();
}

class _MainContainerScreenState extends State<MainContainerScreen> {
  late int _currentIndex;
  
  // Keep track of the screens for state preservation
  final List<Widget> _screens = [];
  
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    
    // Initialize the screens
    _screens.addAll([
      const WaveVisualisationScreen(),
      const ProblemsScreen(),
      const SampleSolutionScreen(),
      const CheatSheetScreen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
  
  PreferredSizeWidget _buildAppBar() {
    String title;
    Color backgroundColor;
    
    switch (_currentIndex) {
      case 0:
        title = 'Wave Visualisation';
        backgroundColor = AppColours.primaryLight;
        break;
      case 1:
        title = 'Problem Solver';
        backgroundColor = AppColours.primaryLight;
        break;
      case 2:
        title = 'Sample Solutions';
        backgroundColor = AppColours.primaryLight;
        break;
      case 3:
        title = 'Fourier Series Cheat Sheet';
        backgroundColor = AppColours.primaryLight;
        break;
      default:
        title = 'Fourier Forge';
        backgroundColor = AppColours.primaryLight;
    }
    
    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      centerTitle: true
    );
  }
}
