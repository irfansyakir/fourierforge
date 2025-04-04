import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../themes/colours.dart';
import 'dart:math' as math;

import 'question_card.dart';
import 'video_card.dart';
import 'solution_a_card.dart';


class Question801Screen extends StatefulWidget {
  const Question801Screen({super.key});

  @override
  Question801ScreenState createState() => Question801ScreenState();
}

class Question801ScreenState extends State<Question801Screen> {
  // For the input signal visualization
  List<FlSpot> inputSignalPoints = [];
  List<FlSpot> outputSignalPoints = [];
  List<FlSpot> magnitudeSpectraPoints = [];
  List<FlSpot> phaseSpectraPoints = [];
  
  @override
  void initState() {
    super.initState();
    _generateSpectraPoints();
  }
  
 
  void _generateSpectraPoints() {
    // Clear existing points
    magnitudeSpectraPoints = [];
    phaseSpectraPoints = [];
  
    // Create the spectrum points 
    magnitudeSpectraPoints = [
      const FlSpot(-3, 0.018),  // n = -3
      const FlSpot(-2, 0.04),   // n = -2
      const FlSpot(-1, 0.21),   // n = -1
      const FlSpot(0, 0.64),    // n = 0 (DC)
      const FlSpot(1, 0.21),    // n = 1
      const FlSpot(2, 0.04),    // n = 2
      const FlSpot(3, 0.018),   // n = 3
    ];
    
    phaseSpectraPoints = [
      const FlSpot(-3, 0),       // n = -3, 0°
      const FlSpot(-2, -math.pi), // n = -2, -180°
      const FlSpot(-1, 0),       // n = -1, 0°
      const FlSpot(0, 0),        // n = 0, 0°
      const FlSpot(1, 0),        // n = 1, 0°
      const FlSpot(2, math.pi),  // n = 2, 180°
      const FlSpot(3, 0),        // n = 3, 0°
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question 8.1'),
        backgroundColor: AppColours.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question card
            const QuestionCard(),
            
            const SizedBox(height: 16),
            
            // Signal visualization card
             VideoCard(
              videoName: 'Signal Visualization',
              videoPath: 'lib/assets/animations/Tutorial8.mp4'),
            
            const SizedBox(height: 16),
            
            // Solution part (a) - Fourier series
            const SolutionACard(),
            
            const SizedBox(height: 16),

            VideoCard(
              videoName: 'Fourier Series Visualisation',
              videoPath: 'lib/assets/animations/FourierVisualiser.mp4'),
          ],
        ),
      ),
    );
  }
}