import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'wave_model.dart';

class WaveCalculator {
  static const double graphWidth = 6.28; 

  /// Calculates the points for a wave based on the given model.
  /// The [model] parameter contains the properties of the wave such as type, frequency, amplitude, and phase shift.
  /// The function returns a list of [FlSpot] objects representing the points on the graph.
  /// The [graphWidth] parameter defines the width of the graph in terms of the x-axis.
  /// The function uses a step size of 0.01 for the x-axis to ensure smoothness.
  /// The y-axis values are calculated based on the wave type and the number of terms specified in the model.
  /// The function also adjusts the y-axis values based on the amplitude and phase shift.
  static List<FlSpot> calculateWave(WaveModel model) {
    final List<FlSpot> points = [];
    
    for (double t = 0; t <= graphWidth; t += 0.01) {

      double x = t;
      double y = 0;
      
      // Adjust the x value based on frequency and phase shift
      double adjustedX = model.frequency * x + model.phaseShift;
      
      // Calculate the wave based on its type
      // and the number of terms specified in the model
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
          for (int k = 0; k < model.terms; k++) {
            int n = 2 * k + 1; 
            double term = (8 / (pi * pi)) * pow(-1, k) / (n * n) * sin(n * adjustedX);
            y += term;
          }
          break;
      }
      
      y *= model.amplitude;
      
      points.add(FlSpot(x, y));
    }
    
    return points;
  }
}