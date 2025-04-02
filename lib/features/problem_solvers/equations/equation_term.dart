// Data structure to represent each term in the equation
class EquationTerm {
  double amplitude;
  bool hasTrigFunction; // Whether the term has a sin/cos function
  String functionType; // 'sin' or 'cos'
  
  // Frequency as a fraction
  int frequencyNumerator;
  int frequencyDenominator;
  
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
    required this.phaseShiftNumerator,
    required this.phaseShiftDenominator,
    this.isPositive = true,
  });

  // Convert the term to LaTeX string for display
  String toLatexString() {
    String sign = isPositive ? '+' : '-';
    // Handle the first term differently (no + sign at the beginning)
    String amplitudeStr = amplitude.abs().toString();
    
    // If there's no trig function, just return the constant term
    if (!hasTrigFunction) {
      return '$sign $amplitudeStr';
    }
    
    // Format phase shift as a fraction of π
    String phaseStr = '';
    if (phaseShiftNumerator != 0) {
      if (phaseShiftDenominator == 1) {
        phaseStr = phaseShiftNumerator > 0 ? '+\\pi' : '-\\pi';
      } else {
        phaseStr = phaseShiftNumerator > 0 
            ? '+\\frac{$phaseShiftNumerator\\pi}{$phaseShiftDenominator}' 
            : '-\\frac{${phaseShiftNumerator.abs()}\\pi}{$phaseShiftDenominator}';
      }
    }
    
    // Handle frequency display as a fraction
    String freqStr;
    if (frequencyNumerator == frequencyDenominator) {
      // If frequency = 1 (n/n)
      freqStr = '\\pi t';
    } else if (frequencyDenominator == 1) {
      // If it's a whole number
      freqStr = '$frequencyNumerator\\pi t';
    } else {
      // It's a proper fraction
      freqStr = '\\frac{$frequencyNumerator\\pi t}{$frequencyDenominator}';
    }
    
    return '$sign $amplitudeStr\\$functionType($freqStr$phaseStr)';
  }
  
  // Helper function to find Greatest Common Divisor
  int _findGCD(int a, int b) {
    return b == 0 ? a : _findGCD(b, a % b);
  }
  
  // Simplify the fraction
  void simplifyFraction() {
    int gcd = _findGCD(frequencyNumerator, frequencyDenominator);
    frequencyNumerator ~/= gcd;
    frequencyDenominator ~/= gcd;
  }
}