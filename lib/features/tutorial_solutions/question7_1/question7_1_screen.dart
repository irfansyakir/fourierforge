import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Import the separate card components
import 'question_card.dart';
import 'solution_a_card.dart';
//import 'solution_b_card.dart';

class Question701Screen extends StatefulWidget {
  const Question701Screen({super.key});

  @override
  Question701ScreenState createState() => Question701ScreenState();
}

class Question701ScreenState extends State<Question701Screen> {
  // For spectrum visualization
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
  
    // Create magnitude spectrum points (constant value of 1/T0)
    for (int n = -3; n <= 3; n++) {
      magnitudeSpectraPoints.add(FlSpot(n.toDouble(), 1.0));
    }
    
    // Phase spectrum is 0 for all n
    for (int n = -3; n <= 3; n++) {
      phaseSpectraPoints.add(FlSpot(n.toDouble(), 0.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Q7.1: Periodic Impulse Train'),
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
            
            // Solution part (a) - Fourier series
            const SolutionACard(),
            
            //const SizedBox(height: 16),
            
            // Solution part (b) - Spectrum
            //const SolutionBCard(),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}