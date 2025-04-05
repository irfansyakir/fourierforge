import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../routes/routes.dart';

class FeatureScaffold extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final int currentIndex;

  const FeatureScaffold({
    super.key,
    required this.body,
    this.appBar,
    required this.currentIndex,
  });

  @override
  State<FeatureScaffold> createState() => _FeatureScaffoldState();
}

class _FeatureScaffoldState extends State<FeatureScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: widget.body,
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          if (index != widget.currentIndex) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, AppRoutes.waveVisualisation);
                break;
              case 1:
                Navigator.pushReplacementNamed(context, AppRoutes.interactiveProblemSolver);
                break;
              case 2:
                Navigator.pushReplacementNamed(context, AppRoutes.sampleSolutionScreen);
                break;
              case 3:
                Navigator.pushReplacementNamed(context, AppRoutes.cheatSheet);
                break;
            }
          }
        },
      ),
    );
  }
}
