

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'dart:math';

class WaveVisualisationScreen extends StatefulWidget {
  const WaveVisualisationScreen({super.key});

  @override
  WaveVisualisationScreenState createState() => WaveVisualisationScreenState();
}

class WaveVisualisationScreenState extends State<WaveVisualisationScreen> {
  int terms = 1; // Number of terms in the Fourier series
  double graphWidth = 6.28; // Width of the graph (2π for periodicity)
  List<FlSpot> points = []; // List of points to plot

  @override
  void initState() {
    super.initState();
    updateGraph(); // Initialize graph points
  }

  // Function to update the graph based on the number of terms
  void updateGraph() {
    points.clear();
    for (double t = 0; t <= graphWidth; t += 0.01) {
      double y = 0;
      for (int k = 1; k <= terms; k++) {
        int n = 2 * k - 1; // Odd harmonics
        y += (4 / pi) * (1 / n) * sin(n * t); // Fourier series formula
      }
      points.add(FlSpot(t, y));
    }
    setState(() {});
  }

  // Dynamic Fourier series formula
  Widget buildDynamicFormula() {
    List<String> termsList = [];
    for (int k = 1; k <= terms; k++) {
      int n = 2 * k - 1; // Calculate the odd harmonic
      termsList.add(r'\frac{\sin(' '${n}t' r')}{' '$n' '}');
    }

    String series = termsList.join(' + '); // Join all terms with " + "

    return Math.tex(
      r'f(t) = \frac{4}{\pi} \left(' + series + r'\right)',
      textStyle: const TextStyle(fontSize: 16),
    );
  }

  // Static general Fourier series formula with label
  Widget buildLabeledGeneralFormula() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'General Fourier Series Formula for a Square Wave:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Math.tex(
          r'f(t) = \frac{4}{\pi} \sum_{n=1,3,5,\dots}^\infty \frac{\sin(nt)}{n}',
          textStyle: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  // Enhanced Slider with gaps and term display
  Widget buildEnhancedSlider() {
    return Column(
      children: [
        Text(
          'Number of Terms: $terms',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.grey[300],
            thumbColor: Colors.blueAccent,
            overlayColor: Colors.blue.withOpacity(0.2),
            trackHeight: 8.0, // Make the slider track thicker
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0), // Bigger thumb
            tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 6.0), // Bigger tick marks
            activeTickMarkColor: Colors.blueAccent,
            inactiveTickMarkColor: Colors.grey,
            showValueIndicator: ShowValueIndicator.always,
          ),
          child: Slider(
            value: terms.toDouble(),
            min: 1,
            max: 20,
            divisions: 19,
            label: '$terms',
            onChanged: (value) {
              setState(() {
                terms = value.toInt();
                updateGraph();
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wave Visualization'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Graph Visualization
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4, 
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: graphWidth,
                  minY: -2,
                  maxY: 2,
                  lineBarsData: [
                    LineChartBarData(
                      spots: points,
                      isCurved: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.lightBlue],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Enhanced Slider
            buildEnhancedSlider(),
            const SizedBox(height: 16),
            // Dynamic Fourier series formula
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildDynamicFormula(),
            ),
            const SizedBox(height: 16),
            // General Fourier series formula with label
            buildLabeledGeneralFormula(),
          ],
        ),
      ),
    );
  }
}
