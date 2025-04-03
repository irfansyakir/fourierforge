import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

// Data structure to represent each term in the equation
class EquationTerm {
  int amplitude; 
  bool hasTrigFunction; // Whether the term has a sin/cos function
  String functionType; // 'sin' or 'cos'
  
  // Frequency as a fraction
  int frequencyNumerator;
  int frequencyDenominator;
  
  // Whether π is included in the frequency
  bool includesPi;
  
  // Phase shift as a fraction of π
  int phaseShiftNumerator;
  int phaseShiftDenominator;
  
  bool isPositive; // Whether the term has a + or - sign in the equation

  EquationTerm({
    required this.amplitude,
    this.hasTrigFunction = true,
    required this.functionType,
    required this.frequencyNumerator,
    required this.frequencyDenominator,
    this.includesPi = true,
    required this.phaseShiftNumerator,
    required this.phaseShiftDenominator,
    this.isPositive = true,
  });

  // Convert the term to LaTeX string for display
  String toLatexString() {
    String sign = isPositive ? '+' : '-';
    
    // If there's no trig function, just return the constant term
    if (!hasTrigFunction) {
      return '$sign $amplitude';
    }
    
    // Skip rendering if amplitude, frequency numerator, or denominator is 0 or invalid
    if (amplitude == 0 || frequencyNumerator == 0 || frequencyDenominator == 0) {
      return '';
    }
    
    // Format phase shift as a fraction of π
    String phaseStr = '';
    if (phaseShiftNumerator != 0) {
      // Special case for numerator = 1 or -1
      if (phaseShiftNumerator.abs() == 1 && phaseShiftDenominator == 1) {
        // Just π (or -π) without the 1
        phaseStr = phaseShiftNumerator > 0 ? '+\\pi' : '-\\pi';
      } else if (phaseShiftNumerator.abs() == 1) {
        // π/n (or -π/n) without the 1 in numerator
        phaseStr = phaseShiftNumerator > 0 
            ? '+\\frac{\\pi}{$phaseShiftDenominator}' 
            : '-\\frac{\\pi}{$phaseShiftDenominator}';
      } else if (phaseShiftDenominator == 1) {
        // nπ without the denominator
        phaseStr = phaseShiftNumerator > 0 
            ? '+$phaseShiftNumerator\\pi' 
            : '-${phaseShiftNumerator.abs()}\\pi';
      } else {
        // Regular fraction nπ/m
        phaseStr = phaseShiftNumerator > 0 
            ? '+\\frac{$phaseShiftNumerator\\pi}{$phaseShiftDenominator}' 
            : '-\\frac{${phaseShiftNumerator.abs()}\\pi}{$phaseShiftDenominator}';
      }
    }
    
    // Handle frequency display as a fraction
    String freqStr;
    String piSymbol = includesPi ? '\\pi ' : '';
    
    if (frequencyNumerator == frequencyDenominator) {
      // If frequency = 1 (n/n)
      freqStr = '${piSymbol}t';
    } else if (frequencyDenominator == 1) {
      // If it's a whole number
      freqStr = '$frequencyNumerator${piSymbol}t';
    } else if (frequencyNumerator == 1) {
      // Special case for numerator = 1
      freqStr = '\\frac{${piSymbol}t}{$frequencyDenominator}';
    } else {
      // It's a proper fraction
      freqStr = '\\frac{$frequencyNumerator${piSymbol}t}{$frequencyDenominator}';
    }
    
    // Handle amplitude = 1 case (don't show the 1)
    String amplitudePrefix = "";
    if (amplitude != 1) {
      amplitudePrefix = "$amplitude";
    }
    
    return '$sign $amplitudePrefix\\$functionType($freqStr$phaseStr)';
  }
  
  // Helper function to find Greatest Common Divisor
  int _findhcf(int a, int b) {
    a = a.abs();
    b = b.abs();
    return b == 0 ? a : _findhcf(b, a % b);
  }
  
  // Simplify the fraction
  void simplifyFraction() {
    if (frequencyNumerator == 0 || frequencyDenominator == 0) {
      return; // Avoid division by zero
    }
    int hcf = _findhcf(frequencyNumerator, frequencyDenominator);
    if (hcf > 0) {
      frequencyNumerator ~/= hcf;
      frequencyDenominator ~/= hcf;
    }
  }
  
  // Validate and constrain all values to their allowed ranges
  void validate() {
    // Amplitude constraints (1-10)
    if (amplitude > 10) amplitude = 10;
    
    // Frequency constraints (1-20)
    if (frequencyNumerator > 20) frequencyNumerator = 20;
    if (frequencyDenominator > 20) frequencyDenominator = 20;
    
    // Phase shift constraints
    if (phaseShiftNumerator > 360) phaseShiftNumerator = 360;
    if (phaseShiftNumerator < -360) phaseShiftNumerator = -360;
    if (phaseShiftDenominator > 180) phaseShiftDenominator = 180;
    
    // Simplify fractions
    simplifyFraction();
  }
  
  // Check if this term should be rendered (valid values for each part)
  bool isValid() {
    if (!hasTrigFunction) {
      return amplitude > 0;
    }
    
    return amplitude > 0 && 
           frequencyNumerator > 0 && 
           frequencyDenominator > 0 && 
           phaseShiftDenominator > 0;
  }


  List<FlSpot> getSignalPoints(double startX, double endX, double step) {
    List<FlSpot> points = [];
    
    for (double t = startX; t <= endX; t += step) {
      double y = calculateValueAt(t);
      points.add(FlSpot(t, y));
    }
    
    return points;
  }

  double calculateValueAt(double t) {
    // For constant term without trig function
    if (!hasTrigFunction) {
      return isPositive ? amplitude.toDouble() : -amplitude.toDouble();
    }
    
    // Apply correct sign to amplitude
    double signedAmplitude = isPositive ? amplitude.toDouble() : -amplitude.toDouble();
    
    // Calculate frequency in terms of π
    double freq = frequencyNumerator / frequencyDenominator;
    if (!includesPi) {
      // If π is not included, convert frequency to rad/s
      freq = freq / math.pi;
    }
    
    // Phase shift in radians
    double phase = phaseShiftNumerator * math.pi / phaseShiftDenominator;
    
    // Calculate angle
    double angle = freq * math.pi * t - phase;
    
    // Apply the appropriate trig function
    if (functionType == 'sin') {
      return signedAmplitude * math.sin(angle);
    } else { // cos
      return signedAmplitude * math.cos(angle);
    }
  }
}