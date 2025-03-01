import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import '../models/wave_model.dart';

class WaveCalculator {
  static const double graphWidth = 6.28; // Width of the graph (2π for periodicity)

  // Calculate the points for the main wave
  static List<FlSpot> calculateWave(WaveModel model) {
    final List<FlSpot> points = [];
    
    for (double t = 0; t <= graphWidth; t += 0.01) {
      double x = t;
      double y = 0;
      
      // Apply frequency and phase shift to x
      double adjustedX = model.frequency * x + model.phaseShift;
      
      switch (model.type) {
        case WaveType.square:
          for (int k = 1; k <= model.terms; k++) {
            int n = 2 * k - 1; // Odd harmonics for square wave
            double term = (4 / (n * pi)) * sin(n * adjustedX);
            y += term;
          }
          break;
          
        case WaveType.sawtooth:
          for (int k = 1; k <= model.terms; k++) {
            double term = (2 / (k * pi)) * sin(k * adjustedX) * pow(-1, k+1);
            y += term;
          }
          break;
          
        case WaveType.triangle:
          for (int k = 1; k <= model.terms; k++) {
            int n = 2 * k - 1; // Odd harmonics for triangle wave
            double term = (8 / (n * n * pi * pi)) * cos(n * adjustedX) * pow(-1, (n-1)/2);
            y += term;
          }
          break;
      }
      
      // Apply amplitude
      y *= model.amplitude;
      
      points.add(FlSpot(x, y));
    }
    
    return points;
  }
}