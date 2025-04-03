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
  int _findGCD(int a, int b) {
    a = a.abs();
    b = b.abs();
    return b == 0 ? a : _findGCD(b, a % b);
  }
  
  // Simplify the fraction
  void simplifyFraction() {
    if (frequencyNumerator == 0 || frequencyDenominator == 0) {
      return; // Avoid division by zero
    }
    int gcd = _findGCD(frequencyNumerator, frequencyDenominator);
    if (gcd > 0) {
      frequencyNumerator ~/= gcd;
      frequencyDenominator ~/= gcd;
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
    // If it's just a constant term without trig function
    if (!hasTrigFunction) {
      return isPositive ? amplitude.toDouble() : -amplitude.toDouble();
    }
    
    // Calculate the angle in radians
    double frequency = frequencyNumerator / frequencyDenominator;
    double phaseShift = phaseShiftNumerator * math.pi / phaseShiftDenominator;
    double angle = frequency * math.pi * t + phaseShift;
    
    // Apply the corresponding trig function
    double value;
    if (functionType == 'sin') {
      value = amplitude * math.sin(angle);
    } else { // cos
      value = amplitude * math.cos(angle);
    }
    
    // Apply sign
    return isPositive ? value : -value;
  }
}