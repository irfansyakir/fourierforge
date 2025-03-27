import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class RectifierSolution {
  final String a0Formula;
  final String anFormula;
  final String bnFormula;
  final String firstFewTerms;
  final String fourierSeries;
  final String spectrumAnalysis;
  final double maxSpectrumValue;
  final List<double> coefficientValues;
  
  RectifierSolution({
    required this.a0Formula,
    required this.anFormula,
    required this.bnFormula,
    required this.firstFewTerms,
    required this.fourierSeries,
    required this.spectrumAnalysis,
    required this.maxSpectrumValue,
    required this.coefficientValues,
  });
}

class RectifierSolver {
  final double amplitude;
  final double frequency;
  final String waveType;
  final double threshold;
  
  RectifierSolver({
    required this.amplitude,
    required this.frequency,
    required this.waveType,
    required this.threshold,
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
      double output = input >= threshold ? input : -input;
      points.add(FlSpot(t, output));
    }
    
    return points;
  }

  // Calculate input signal value at time t
  double getInputValue(double t) {
    double angle = frequency * math.pi * t; // Adjusted for πt format
    
    switch (waveType) {
      case 'sin':
        return amplitude * math.sin(angle);
      case 'cos':
        return amplitude * math.cos(angle);
      default:
        return amplitude * math.cos(angle);
    }
  }
  
  // Calculate magnitude spectrum points
  List<FlSpot> getMagnitudeSpectrumPoints() {
    List<FlSpot> points = [];
    
    // Calculate DC component
    double a0 = calculateA0();
    points.add(FlSpot(0, a0));
    
    // Calculate first 10 harmonics
    List<double> coefficients = [a0];
    
    for (int n = 1; n <= 10; n++) {
      double an = calculateAn(n);
      double bn = calculateBn(n);
      
      // Magnitude
      double magnitude = math.sqrt(an * an + bn * bn);
      coefficients.add(magnitude);
      
      // Add to the spectrum
      points.add(FlSpot(n.toDouble(), magnitude));
    }
    
    return points;
  }

  // Calculate a0 coefficient (DC component)
  double calculateA0() {
    // For standard full-wave rectifier with threshold 0
    if (threshold == 0) {
      if (waveType == 'cos') {
        // For cosine input: a0 = 2A/π
        return 2 * amplitude / math.pi;
      } else if (waveType == 'sin') {
        // For sine input: a0 = 2A/π
        return 2 * amplitude / math.pi;
      }
    }
    
    // For other cases, use numerical integration
    double sum = 0.0;
    int steps = 1000;
    double period = 1.0 / frequency;
    double dt = period / steps;
    
    for (int i = 0; i < steps; i++) {
      double t = i * dt;
      double input = getInputValue(t);
      double output = input >= threshold ? input : -input;
      sum += output * dt;
    }
    
    return sum / period;
  }
  
  // Calculate an coefficients (cosine terms)
  double calculateAn(int n) {
    // For standard full-wave rectifier with threshold 0
    if (threshold == 0) {
      if (waveType == 'cos') {
        // For cosine input, only even harmonics exist
        if (n % 2 == 0) {
          return 4 * amplitude / (math.pi * (1 - n * n));
        } else {
          return 0.0;
        }
      }
    }
    
    // For other cases, use numerical integration
    double sum = 0.0;
    int steps = 1000;
    double period = 1.0 / frequency;
    double dt = period / steps;
    double omega = 2 * math.pi * frequency;
    
    for (int i = 0; i < steps; i++) {
      double t = i * dt;
      double input = getInputValue(t);
      double output = input >= threshold ? input : -input;
      sum += output * math.cos(n * omega * t) * dt;
    }
    
    return 2 * sum / period;
  }
  
  // Calculate bn coefficients (sine terms)
  double calculateBn(int n) {
    // For standard full-wave rectifier with threshold 0
    if (threshold == 0) {
      if (waveType == 'cos') {
        // For cosine input with threshold 0, all bn are 0 due to even symmetry
        return 0.0;
      }
    }
    
    // For other cases, use numerical integration
    double sum = 0.0;
    int steps = 1000;
    double period = 1.0 / frequency;
    double dt = period / steps;
    double omega = 2 * math.pi * frequency;
    
    for (int i = 0; i < steps; i++) {
      double t = i * dt;
      double input = getInputValue(t);
      double output = input >= threshold ? input : -input;
      sum += output * math.sin(n * omega * t) * dt;
    }
    
    return 2 * sum / period;
  }
  
  // Get full solution
  RectifierSolution getSolution() {
    double a0 = calculateA0();
    List<double> coefficients = [a0];
    double maxCoefficient = a0;
    
    // Calculate coefficients for first few terms
    for (int n = 1; n <= 10; n++) {
      double an = calculateAn(n);
      double bn = calculateBn(n);
      double magnitude = math.sqrt(an * an + bn * bn);
      coefficients.add(magnitude);
      if (magnitude > maxCoefficient) {
        maxCoefficient = magnitude;
      }
    }
    
    // Formulate the solutions based on the parameters
    String a0Formula = '';
    String anFormula = '';
    String bnFormula = '';
    String firstFewTerms = '';
    String fourierSeries = '';
    String spectrumAnalysis = '';
    
    // Standard full-wave rectifier with cosine input
    if (threshold == 0 && waveType == 'cos') {
      a0Formula = '\\frac{2A}{\\pi} = \\frac{2 \\cdot ${amplitude.toStringAsFixed(1)}}{\\pi} = ${a0.toStringAsFixed(4)}';
      anFormula = 'a_{2n} = \\frac{4A}{\\pi(1-4n^2)}, \\quad a_{2n+1} = 0';
      bnFormula = 'b_n = 0 \\text{ for all } n';
      
      // Calculate first few terms
      List<String> terms = [];
      terms.add(a0.toStringAsFixed(3));
      
      for (int n = 1; n <= 5; n++) {
        if (n % 2 == 0) {
          double an = calculateAn(n);
          if (an.abs() > 0.001) {
            terms.add('${an.toStringAsFixed(3)}\\cos($n\\omega_0 t)');
          }
        }
      }
      
      firstFewTerms = terms.join(' + ');
      fourierSeries = '\\frac{2A}{\\pi} + \\sum_{n=1}^{\\infty} \\frac{4A}{\\pi(1-4n^2)}\\cos(2n\\omega_0 t)';
      
      spectrumAnalysis = 'The rectified cosine wave has a DC component of ${a0.toStringAsFixed(3)} ' 'and contains only even harmonics. The magnitude of harmonics decreases as frequency increases.';
    }
    // Standard full-wave rectifier with sine input
    else if (threshold == 0 && waveType == 'sin') {
      a0Formula = '\\frac{2A}{\\pi} = \\frac{2 \\cdot ${amplitude.toStringAsFixed(1)}}{\\pi} = ${a0.toStringAsFixed(4)}';
      anFormula = 'a_{2n} = \\frac{4A}{\\pi(1-4n^2)}, \\quad a_{2n+1} = 0';
      bnFormula = 'b_n = 0 \\text{ for all } n';
      
      // Calculate first few terms
      List<String> terms = [];
      terms.add(a0.toStringAsFixed(3));
      
      for (int n = 1; n <= 5; n++) {
        if (n % 2 == 0) {
          double an = calculateAn(n);
          if (an.abs() > 0.001) {
            terms.add('${an.toStringAsFixed(3)}\\cos($n\\omega_0 t)');
          }
        }
      }
      
      firstFewTerms = terms.join(' + ');
      fourierSeries = '\\frac{2A}{\\pi} + \\sum_{n=1}^{\\infty} \\frac{4A}{\\pi(1-4n^2)}\\cos(2n\\omega_0 t)';
      
      spectrumAnalysis = 'The rectified sine wave has a DC component of ${a0.toStringAsFixed(3)} ' 'and contains only even harmonics. The spectrum is similar to a rectified cosine wave.';
    }
    // Custom cases
    else {
      a0Formula = 'a_0 = \\frac{1}{T}\\int_{0}^{T} y(t) dt = ${a0.toStringAsFixed(4)}';
      anFormula = 'a_n = \\frac{2}{T}\\int_{0}^{T} y(t)\\cos(n\\omega_0 t) dt';
      bnFormula = 'b_n = \\frac{2}{T}\\int_{0}^{T} y(t)\\sin(n\\omega_0 t) dt';
      
      // Calculate first few terms
      List<String> terms = [];
      terms.add(a0.toStringAsFixed(3));
      
      for (int n = 1; n <= 5; n++) {
        double an = calculateAn(n);
        double bn = calculateBn(n);
        
        if (an.abs() > 0.001) {
          terms.add('${an.toStringAsFixed(3)}\\cos($n\\omega_0 t)');
        }
        
        if (bn.abs() > 0.001) {
          terms.add('${bn.toStringAsFixed(3)}\\sin($n\\omega_0 t)');
        }
      }
      
      firstFewTerms = terms.join(' + ');
      fourierSeries = 'a_0 + \\sum_{n=1}^{\\infty} a_n\\cos(n\\omega_0 t) + b_n\\sin(n\\omega_0 t)';
      
      spectrumAnalysis = 'With a threshold of ${threshold.toStringAsFixed(1)}, the spectrum is more complex. ' 'The rectified signal contains both even and odd harmonics, with significant ' 'energy distributed across multiple frequency components.';
    }
    
    return RectifierSolution(
      a0Formula: a0Formula,
      anFormula: anFormula,
      bnFormula: bnFormula,
      firstFewTerms: firstFewTerms,
      fourierSeries: fourierSeries,
      spectrumAnalysis: spectrumAnalysis,
      maxSpectrumValue: maxCoefficient * 1.2,
      coefficientValues: coefficients,
    );
  }
}