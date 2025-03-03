import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

// Import the separate card components
import 'question_card.dart';
import 'signal_visualization_card.dart';
import 'solution_a_card.dart';
import 'solution_b_card.dart';
import 'spectra_visualization_card.dart';
import 'solution_c_card.dart';

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
    _generateSignalPoints();
    _generateSpectraPoints();
  }
  
  void _generateSignalPoints() {
    inputSignalPoints = [];
    outputSignalPoints = [];
    
    // Generate points for one full period
    for (double x = -1.25; x <= 1.25; x += 0.01) {
      // Input signal: x(t) = cos(2πt)
      double inputY = math.cos(2 * math.pi * x);
      inputSignalPoints.add(FlSpot(x, inputY));
      
      // Output signal (after full-wave rectification)
      double outputY = inputY >= 0 ? inputY : -inputY;
      outputSignalPoints.add(FlSpot(x, outputY));
    }
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
        backgroundColor: Colors.indigo,
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
            SignalVisualizationCard(
              inputSignalPoints: inputSignalPoints,
              outputSignalPoints: outputSignalPoints,
            ),
            
            const SizedBox(height: 16),
            
            // Solution part (a) - Fourier series
            const SolutionACard(),
            
            const SizedBox(height: 16),
            
            // Solution part (b) - Spectrum
            const SolutionBCard(),
            
            const SizedBox(height: 16),
            
            // Spectra visualization
            SpectraVisualizationCard(
              magnitudeSpectraPoints: magnitudeSpectraPoints,
              phaseSpectraPoints: phaseSpectraPoints,
            ),
            
            const SizedBox(height: 16),
            
            // Solution part (c) - Conclusion
            const SolutionCCard(),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}