import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

// This class contains methods to calculate Graph Points
// Signal Properties and Fourier Series Coefficients

class RectifierSolver {
  final double amplitude;
  final double frequency;
  final String waveType;
  final String rectifierType;
  
  RectifierSolver({
    required this.amplitude,
    required this.frequency,
    required this.waveType,
    required this.rectifierType
  });
  
  // Generate points for input signal
  List<FlSpot> getInputSignalPoints() {
    List<FlSpot> points = []; 

    // Generate 200 points for smooth curves
    for (double t = 0; t <= 2; t += 0.01) {
      double y = getInputValue(t);
      points.add(FlSpot(t, y));
    }
    return points;
  }
  
  // Generate points for output signal (rectified)
  List<FlSpot> getOutputSignalPoints() {
    List<FlSpot> points = [];
    
    // Generate 200 points for smooth curves
    for (double t = 0; t <= 2; t += 0.01) {
      double input = getInputValue(t);
      double output = getOutputValue(input);
      points.add(FlSpot(t, output));
    }
    return points;
  }

  // Calculate input signal value at time t
  double getInputValue(double t) {
    double angle = frequency * 2 * math.pi * t; 
    switch (waveType) {
      case 'sin':
        return amplitude * math.sin(angle);
      case 'cos':
        return amplitude * math.cos(angle);
      default:
        return amplitude * math.cos(angle);
    }
  }

  // Retifier Output
  double getOutputValue(double input) {
    double output = 0;
      if (rectifierType == 'full') {
        output = input.abs(); // Full Wave Rectification
      } 
      else {
        output = input > 0 ? input : 0; // Half-wave rectification
      }
      return output;
  }
  
  // Find the Period of the output signal
  String getOutputPeriod() {
    double period;
    // 
    if (rectifierType == 'full') {
      period = 1 / (2 * frequency);
    } else {
      period = 1 / frequency;
    }
    // Round to 4 decimal places first
    String periodString = period.toStringAsFixed(4);
    
    // Remove trailing zeros but keep as String
    if (periodString.contains('.')) {
      // Remove trailing zeros
      periodString = periodString.replaceAll(RegExp(r'0+$'), '');
      // Remove decimal point if it's the last character
      periodString = periodString.replaceAll(RegExp(r'\.$'), '');
    }
    
    return periodString;
  }

  String getOutputFrequency() {
    double period;
    double outputFrequency;
    
    if (rectifierType == 'full') {
      period = 1 / frequency;
    } else {
      period = 2 / frequency;
    }
    outputFrequency = 1 / period;
    
    // Round to 4 decimal places first
    String outputFrequencyString = outputFrequency.toStringAsFixed(4);
    
    // Remove trailing zeros but keep as String
    if (outputFrequencyString.contains('.')) {
      // Remove trailing zeros
      outputFrequencyString = outputFrequencyString.replaceAll(RegExp(r'0+$'), '');
      // Remove decimal point if it's the last character
      outputFrequencyString = outputFrequencyString.replaceAll(RegExp(r'\.$'), '');
    }
    return outputFrequencyString;
  }
}
