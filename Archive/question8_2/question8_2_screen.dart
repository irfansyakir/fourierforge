import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

import 'question_card.dart';
import 'step1_card.dart';
import 'step2_card.dart';
import 'step3_card.dart';
import 'signal_visualization_card.dart';

class Question802Screen extends StatefulWidget {
  const Question802Screen({super.key});

  @override
  Question802ScreenState createState() => Question802ScreenState();
}

class Question802ScreenState extends State<Question802Screen> {
  // For signal visualization
  List<FlSpot> xSignalPoints = [];
  List<FlSpot> ySignalPoints = [];
  
  @override
  void initState() {
    super.initState();
    _generateSignalPoints();
  }
  
  void _generateSignalPoints() {
    xSignalPoints = [];
    ySignalPoints = [];
    
    // Example signal: x(t) = cos(2πt)
    for (double t = -2.0; t <= 2.0; t += 0.01) {
      double xValue = math.cos(2 * math.pi * t);
      xSignalPoints.add(FlSpot(t, xValue));
      
      // Using the relationship y(t) = 3x(4t - 2)
      double scaledT = 4 * t - 2;
      double yValue = 3 * math.cos(2 * math.pi * scaledT);
      ySignalPoints.add(FlSpot(t, yValue));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Periodic Signals Relationship'),
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
            
            // Signal visualization card (optional)
            SignalVisualizationCard(
              xSignalPoints: xSignalPoints,
              ySignalPoints: ySignalPoints,
            ),
            
            const SizedBox(height: 16),
            
            // Solution step 1: Find fy in terms of fx
            const Step1Card(),
            
            const SizedBox(height: 16),
            
            // Solution step 2: Find dn in terms of cn
            const Step2Card(),
            
            const SizedBox(height: 16),
            
            // Step 3: Comment on "shaping up" the line spectra
            const Step3Card(),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}