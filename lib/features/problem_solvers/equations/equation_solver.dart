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
  
  // isPositive is now redundant since amplitude can be negative
  bool isPositive; // Keeping for backward compatibility but will be ignored

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
    // If there's no trig function, just return the constant term
    if (!hasTrigFunction) {
      return amplitude >= 0 ? '+' + amplitude.toString() : amplitude.toString();
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
    if (includesPi) {
      // Format with π next to numerator
      if (frequencyNumerator == frequencyDenominator) {
        // If frequency = 1 (n/n)
        freqStr = '\\pi t';
      } else if (frequencyDenominator == 1) {
        // If it's a whole number
        freqStr = '$frequencyNumerator\\pi t';
      } else if (frequencyNumerator == 1) {
        // Special case for numerator = 1
        freqStr = '\\frac{\\pi t}{$frequencyDenominator}';
      } else {
        // It's a proper fraction
        freqStr = '\\frac{$frequencyNumerator\\pi t}{$frequencyDenominator}';
      }
    } else {
      // Regular format without π
      if (frequencyNumerator == frequencyDenominator) {
        // If frequency = 1 (n/n)
        freqStr = 't';
      } else if (frequencyDenominator == 1) {
        // If it's a whole number
        freqStr = '$frequencyNumerator t';
      } else if (frequencyNumerator == 1) {
        // Special case for numerator = 1
        freqStr = '\\frac{t}{$frequencyDenominator}';
      } else {
        // It's a proper fraction
        freqStr = '\\frac{$frequencyNumerator t}{$frequencyDenominator}';
      }
    }
    
    // Handle amplitude special cases
    String sign = amplitude >= 0 ? '+' : '-';
    int absAmplitude = amplitude.abs();
    
    // For amplitude with absolute value 1, we don't show the 1
    if (absAmplitude == 1) {
      return '$sign\\$functionType($freqStr$phaseStr)';
    } else {
      return '$sign $absAmplitude\\$functionType($freqStr$phaseStr)';
    }
  }
  
  // Helper function to find Greatest Common Divisor
  int _findHcf(int a, int b) {
    a = a.abs();
    b = b.abs();
    return b == 0 ? a : _findHcf(b, a % b);
  }
  
  // Simplify the fraction
  void simplifyFraction() {
    if (frequencyNumerator == 0 || frequencyDenominator == 0) {
      return; // Avoid division by zero
    }
    int hcf = _findHcf(frequencyNumerator, frequencyDenominator);
    if (hcf > 0) {
      frequencyNumerator ~/= hcf;
      frequencyDenominator ~/= hcf;
    }
  }
  
  // Validate and constrain all values to their allowed ranges
  void validate() {
    // Amplitude constraints (-10 to 10, excluding 0)
    if (amplitude > 10) amplitude = 10;
    if (amplitude < -10) amplitude = -10;
    
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
      return amplitude != 0;
    }
    
    return amplitude != 0 && 
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
      return amplitude.toDouble();
    }
    
    // Calculate frequency as a ratio
    double freq = frequencyNumerator / frequencyDenominator;
    
    // Phase shift in radians
    double phase = phaseShiftNumerator * math.pi / phaseShiftDenominator;
    
    // Calculate angle based on whether π is included or not
    double angle;
    if (includesPi) {
      angle = freq * math.pi * t - phase;
    } else {
      angle = freq * t - phase;  // No π multiplication for non-π terms
    }
    
    // Apply the appropriate trig function
    if (functionType == 'sin') {
      return amplitude * math.sin(angle);
    } else { // cos
      return amplitude * math.cos(angle);
    }
  } 
}

/// Checks if the signal represented by the given terms is periodic.
/// Returns a map containing:
/// - 'isPeriodic': Whether the signal is periodic
/// - 'allPiTerms': Whether all terms include pi
/// - 'allNonPiTerms': Whether all terms exclude pi
/// - 'hasFrequencyTerms': Whether any terms have frequency (trig function)
/// - 'hasMixedTerms': Whether the signal has both pi and non-pi terms
Map<String, bool> checkSignalPeriodicity(List<EquationTerm> terms) {
  bool allPiTerms = true;
  bool allNonPiTerms = true;
  bool hasFrequencyTerms = false;
  
  for (var term in terms) {
    if (term.hasTrigFunction) {
      hasFrequencyTerms = true;
      if (term.includesPi) {
        allNonPiTerms = false;
      } else {
        allPiTerms = false;
      }
    }
  }
  
  bool hasMixedTerms = !allPiTerms && !allNonPiTerms;
  bool isPeriodic = hasFrequencyTerms ? !hasMixedTerms : true;
  
  return {
    'isPeriodic': isPeriodic,
    'allPiTerms': allPiTerms,
    'allNonPiTerms': allNonPiTerms,
    'hasFrequencyTerms': hasFrequencyTerms,
    'hasMixedTerms': hasMixedTerms,
  };
}

/// Helper function to find the Highest Common Factor (HCF) or Greatest Common Divisor (GCD)
int findHcf(int a, int b) {
  a = a.abs();
  b = b.abs();
  return b == 0 ? a : findHcf(b, a % b);
}

/// Helper function to find the Lowest Common Multiple (LCM)
int findLcm(int a, int b) {
  if (a == 0 || b == 0) return 0;
  return (a * b) ~/ findHcf(a, b);
}

/// Analyses each term in the equation and extracts frequency and period information
/// Returns a list of maps, each containing analysis for one term
List<Map<String, dynamic>> analyseTermPeriodicity(List<EquationTerm> terms) {
  List<Map<String, dynamic>> termAnalysis = [];
  
  for (int i = 0; i < terms.length; i++) {
    var term = terms[i];
    Map<String, dynamic> analysis = {};
    
    // Constant terms have no frequency
    if (!term.hasTrigFunction) {
      analysis['hasFrequency'] = false;
      termAnalysis.add(analysis);
      continue;
    }
    
    // Get frequency as p/q (possibly * π)
    int p = term.frequencyNumerator;
    int q = term.frequencyDenominator;
    
    // Skip invalid frequencies
    if (p <= 0 || q <= 0) {
      analysis['hasFrequency'] = false;
      termAnalysis.add(analysis);
      continue;
    }
    
    // Simplify the fraction
    int hcf = findHcf(p, q);
    p = p ~/ hcf;
    q = q ~/ hcf;
    
    analysis['hasFrequency'] = true;
    analysis['freqNumerator'] = p;
    analysis['freqDenominator'] = q;
    analysis['includesPi'] = term.includesPi;
    
    // Calculate period
    int periodNum, periodDenom;
    
    if (term.includesPi) {
      // For terms with π: T = 2π/ω = 2π/(pπ/q) = 2q/p
      periodNum = 2 * q;
      periodDenom = p;
    } else {
      // For terms without π: T = 2π/ω = 2π/(p/q) = 2πq/p
      periodNum = 2 * q;
      periodDenom = p;
    }
    
    // Simplify period fraction
    hcf = findHcf(periodNum, periodDenom);
    periodNum = periodNum ~/ hcf;
    periodDenom = periodDenom ~/ hcf;
    
    analysis['periodNumerator'] = periodNum;
    analysis['periodDenominator'] = periodDenom;
    
    termAnalysis.add(analysis);
  }
  
  return termAnalysis;
}

/// Calculates the fundamental period and frequency based on term analyses
/// Returns a map with calculated values for display
Map<String, dynamic> calculateFundamentalPeriodicity(List<Map<String, dynamic>> termAnalysis) {
  List<int> periodNumerators = [];
  List<int> periodDenominators = [];
  
  // Extract period numerators and denominators from valid terms
  for (var analysis in termAnalysis) {
    if (analysis['hasFrequency'] == true) {
      periodNumerators.add(analysis['periodNumerator']);
      periodDenominators.add(analysis['periodDenominator']);
    }
  }
  
  // Calculate LCM of period numerators and HCF of period denominators
  int periodNumLCM = 0;
  int periodDenomHCF = 0;
  
  if (periodNumerators.isNotEmpty) {
    periodNumLCM = periodNumerators[0];
    for (int i = 1; i < periodNumerators.length; i++) {
      periodNumLCM = findLcm(periodNumLCM, periodNumerators[i]);
    }
  }
  
  if (periodDenominators.isNotEmpty) {
    periodDenomHCF = periodDenominators[0];
    for (int i = 1; i < periodDenominators.length; i++) {
      periodDenomHCF = findHcf(periodDenomHCF, periodDenominators[i]);
    }
  }
  
  // Calculate T₀ = LCM(T₁, T₂, ...)
  int fundPeriodNum = periodNumLCM;
  int fundPeriodDenom = periodDenomHCF;
  
  // Simplify
  int periodHcf = findHcf(fundPeriodNum, fundPeriodDenom);
  if (periodHcf > 0) {
    fundPeriodNum = fundPeriodNum ~/ periodHcf;
    fundPeriodDenom = fundPeriodDenom ~/ periodHcf;
  }
  
  // Calculate ω₀ = 2π/T₀
  int fundFreqNum = 2 * fundPeriodDenom;
  int fundFreqDenom = fundPeriodNum;
  
  // Simplify
  int freqHcf = findHcf(fundFreqNum, fundFreqDenom);
  if (freqHcf > 0) {
    fundFreqNum = fundFreqNum ~/ freqHcf;
    fundFreqDenom = fundFreqDenom ~/ freqHcf;
  }
  
  return {
    'fundPeriodNum': fundPeriodNum,
    'fundPeriodDenom': fundPeriodDenom,
    'fundFreqNum': fundFreqNum,
    'fundFreqDenom': fundFreqDenom,
  };
}

int calculatea0(List<EquationTerm> terms) {
    int a0 = 0;
    for (int i = 0; i < terms.length; i++) {
      if (terms[i].hasTrigFunction == false) {
        a0 += terms[i].amplitude;
      }
    }
    return a0;
}

// Helper function to calculate which harmonic a term belongs to
int calculateHarmonicNumber(EquationTerm term, Map<String, dynamic> fundamentalValues) {
  if (!term.hasTrigFunction) return 0; // Constants don't contribute to harmonics
  
  // Get fundamental frequency as a fraction
  int fundFreqNum = fundamentalValues['fundFreqNum'];
  int fundFreqDenom = fundamentalValues['fundFreqDenom'];
  
  // Get term's frequency
  int termFreqNum = term.frequencyNumerator;
  int termFreqDenom = term.frequencyDenominator;
  
  // Calculate harmonic number: n = term_freq / fundamental_freq
  // n = (termFreqNum/termFreqDenom) / (fundFreqNum/fundFreqDenom)
  // n = (termFreqNum * fundFreqDenom) / (termFreqDenom * fundFreqNum)
  int numerator = termFreqNum * fundFreqDenom;
  int denominator = termFreqDenom * fundFreqNum;
  
  // Check if it's an integer harmonic
  if (numerator % denominator == 0) {
    return numerator ~/ denominator;
  }
  
  return 0; // Not an integer harmonic
}

/// Calculates the an coefficients (cosine coefficients) for a given signal
/// Returns a map with harmonic numbers as keys and coefficient values as values
Map<int, double> calculateAnCoefficients(List<EquationTerm> terms, Map<String, dynamic> fundamentalValues) {
  // Map to store an coefficients by harmonic number
  Map<int, double> anCoefficients = {};
  
  // Parse each term to find an contributions
  for (var term in terms) {
    if (!term.hasTrigFunction) continue; // Skip constant terms (they contribute to a0)
    
    // Calculate frequency ratio to determine which harmonic
    int harmonic = calculateHarmonicNumber(term, fundamentalValues);
    
    if (harmonic > 0) {
      // Calculate phase shift in radians
      double phaseShift = term.phaseShiftNumerator * math.pi / term.phaseShiftDenominator;
      
      if (term.functionType == 'cos') {
        // Cos(nωt + φ) = cos(nωt)cos(φ) - sin(nωt)sin(φ)
        // Term contributes A*cos(φ) to an
        double cosPhase = math.cos(phaseShift);
        anCoefficients[harmonic] = (anCoefficients[harmonic] ?? 0) + term.amplitude * cosPhase;
      } 
      else if (term.functionType == 'sin') {
        // Sin(nωt + φ) = sin(nωt)cos(φ) + cos(nωt)sin(φ)
        // Term contributes A*sin(φ) to an
        double sinPhase = math.sin(phaseShift);
        anCoefficients[harmonic] = (anCoefficients[harmonic] ?? 0) + term.amplitude * sinPhase;
      }
    }
  }
  
  // Filter out near-zero coefficients to avoid displaying them
  anCoefficients.removeWhere((_, value) => value.abs() < 0.001);
  
  return anCoefficients;
}

/// Calculates the bn coefficients (sine coefficients) for a given signal
/// Returns a map with harmonic numbers as keys and coefficient values as values
Map<int, double> calculateBnCoefficients(List<EquationTerm> terms, Map<String, dynamic> fundamentalValues) {
  // Map to store bn coefficients by harmonic number
  Map<int, double> bnCoefficients = {};
  
  // Parse each term to find bn contributions
  for (var term in terms) {
    if (!term.hasTrigFunction) continue; // Skip constant terms
    
    // Calculate frequency ratio to determine which harmonic
    int harmonic = calculateHarmonicNumber(term, fundamentalValues);
    
    if (harmonic > 0) {
      // Calculate phase shift in radians
      double phaseShift = term.phaseShiftNumerator * math.pi / term.phaseShiftDenominator;
      
      if (term.functionType == 'cos') {
        // Cos(nωt + φ) = cos(nωt)cos(φ) - sin(nωt)sin(φ)
        // Term contributes -A*sin(φ) to bn
        double sinPhase = math.sin(phaseShift);
        bnCoefficients[harmonic] = (bnCoefficients[harmonic] ?? 0) - term.amplitude * sinPhase;
      } 
      else if (term.functionType == 'sin') {
        // Sin(nωt + φ) = sin(nωt)cos(φ) + cos(nωt)sin(φ)
        // Term contributes A*cos(φ) to bn
        double cosPhase = math.cos(phaseShift);
        bnCoefficients[harmonic] = (bnCoefficients[harmonic] ?? 0) + term.amplitude * cosPhase;
      }
    }
  }
  
  // Filter out near-zero coefficients to avoid displaying them
  bnCoefficients.removeWhere((_, value) => value.abs() < 0.001);
  
  return bnCoefficients;
}

/// Get all harmonics present in the Fourier series
List<int> getAllHarmonics(Map<int, double> anCoefficients, Map<int, double> bnCoefficients) {
  Set<int> harmonicSet = {...anCoefficients.keys, ...bnCoefficients.keys};
  List<int> harmonics = harmonicSet.toList()..sort();
  return harmonics;
}

/// Format a single harmonic term for display in LaTeX
String formatHarmonicTermLatex(int harmonic, double an, double bn) {
  String result = "";
  
  // If both a and b exist, convert to amplitude and phase form
  if (an.abs() > 0.001 && bn.abs() > 0.001) {
    double amplitude = math.sqrt(an * an + bn * bn);
    double phase = math.atan2(bn, an);
    
    String phaseSign = phase >= 0 ? "+" : "-";
    
    result = r"{" + amplitude.toStringAsFixed(2) + r"}\cos(" + harmonic.toString() + 
             r"\omega_0 t " + phaseSign + " " + phase.abs().toStringAsFixed(2) + r")";
  } 
  else if (an.abs() > 0.001) {
    // Only a term exists
    String sign = an >= 0 ? "+" : "-";
    result = sign + r" {" + an.abs().toStringAsFixed(2) + r"}\cos(" + harmonic.toString() + r"\omega_0 t)";
  } 
  else if (bn.abs() > 0.001) {
    // Only b term exists
    String sign = bn >= 0 ? "+" : "-";
    result = sign + r" {" + bn.abs().toStringAsFixed(2) + r"}\sin(" + harmonic.toString() + r"\omega_0 t)";
  }
  
  return result;
}

/// Format the complete Fourier series in LaTeX
String formatFourierSeriesLatex(int a0Value, Map<int, double> anCoeffs, Map<int, double> bnCoeffs) {
  String result = r'f(t) = ';
  
  // Add a0 term only if it's not zero
  if (a0Value != 0) {
    result += a0Value.toString();
  } else if (anCoeffs.isEmpty && bnCoeffs.isEmpty) {
    // If everything is zero, just return zero
    return r'f(t) = 0';
  }
  
  // Get all harmonics
  List<int> harmonics = getAllHarmonics(anCoeffs, bnCoeffs);
  
  // Add each harmonic term
  for (int harmonic in harmonics) {
    double an = anCoeffs[harmonic] ?? 0;
    double bn = bnCoeffs[harmonic] ?? 0;
    
    if (an.abs() > 0.001) {
      // Format coefficient with appropriate precision
      String anCoeffStr = formatCoefficientValue(an.abs());
      
      String sign = an > 0 ? r'+' : r'-';
      // If this is the first term and no a0, don't add + sign
      if (result == r'f(t) = ' && an > 0) sign = '';
      
      result += r' ' + sign + r' {' + anCoeffStr + 
                r'}\cos(' + harmonic.toString() + r'\omega_0 t)';
    }
    
    if (bn.abs() > 0.001) {
      // Format coefficient with appropriate precision
      String bnCoeffStr = formatCoefficientValue(bn.abs());
      
      String sign = bn > 0 ? r'+' : r'-';
      // If this is the first term and no a0, don't add + sign
      if (result == r'f(t) = ' && bn > 0) sign = '';
      
      result += r' ' + sign + r' {' + bnCoeffStr + 
                r'}\sin(' + harmonic.toString() + r'\omega_0 t)';
    }
  }
  return result;
}

/// Format the Fourier series with ω₀ substituted with its actual value
String formatFourierSeriesWithOmega0(int a0Value, Map<int, double> anCoeffs, Map<int, double> bnCoeffs, Map<String, dynamic> fundamentalValues) {
  String result = r'f(t) = ';
  
  // Add a0 term only if it's not zero
  if (a0Value != 0) {
    result += a0Value.toString();
  } else if (anCoeffs.isEmpty && bnCoeffs.isEmpty) {
    // If everything is zero, just return zero
    return r'f(t) = 0';
  }
  
  // Get all harmonics
  List<int> harmonics = getAllHarmonics(anCoeffs, bnCoeffs);
  
  // Extract fundamental frequency values
  int fundFreqNum = fundamentalValues['fundFreqNum'];
  int fundFreqDenom = fundamentalValues['fundFreqDenom'];
  
  // Add each harmonic term
  for (int harmonic in harmonics) {
    double an = anCoeffs[harmonic] ?? 0;
    double bn = bnCoeffs[harmonic] ?? 0;
    
    // Calculate the actual frequency for this harmonic: harmonic * ω₀
    int actualFreqNum = harmonic * fundFreqNum;
    int actualFreqDenom = fundFreqDenom;
    
    // Simplify the fraction
    int gcd = findHcf(actualFreqNum, actualFreqDenom);
    if (gcd > 0) {
      actualFreqNum ~/= gcd;
      actualFreqDenom ~/= gcd;
    }
    
    // Format the frequency term
    String freqTerm;
    if (actualFreqDenom == 1) {
      freqTerm = r'' + actualFreqNum.toString() + r't';
    } else {
      freqTerm = r'\frac{' + actualFreqNum.toString() + r'}{' + actualFreqDenom.toString() + r'}t';
    }
    
    if (an.abs() > 0.001) {
      // Format coefficient with appropriate precision
      String anCoeffStr = formatCoefficientValue(an.abs());
      
      String sign = an > 0 ? r'+' : r'-';
      // If this is the first term and no a0, don't add + sign
      if (result == r'f(t) = ' && an > 0) sign = '';
      
      result += r' ' + sign + r' {' + anCoeffStr + 
                r'}\cos(' + freqTerm + r')';
    }
    
    if (bn.abs() > 0.001) {
      // Format coefficient with appropriate precision
      String bnCoeffStr = formatCoefficientValue(bn.abs());
      
      String sign = bn > 0 ? r'+' : r'-';
      // If this is the first term and no a0, don't add + sign
      if (result == r'f(t) = ' && bn > 0) sign = '';
      
      result += r' ' + sign + r' {' + bnCoeffStr + 
                r'}\sin(' + freqTerm + r')';
    }
  }
  return result;
}

/// Helper function to format coefficient values:
/// - Whole numbers don't have decimal places
/// - Non-whole numbers have exactly 2 decimal places
String formatCoefficientValue(double value) {
  // Check if it's (close to) a whole number
  if ((value - value.round()).abs() < 0.001) {
    return value.round().toString();
  } else {
    return value.toStringAsFixed(2);
  }
}

//***************************************************************************** */
  // Helper method to format the fundamental frequency LaTeX string
  String formatFrequencyLatex(bool includesPi, int num, int denom) {
    String freqStr = r'\omega_0 = \frac{2\pi}{T_0} = ';
    
    // Handle cases with π
    if (includesPi) {
      // Case: denominator is 1
      if (denom == 1) {
        // Case: numerator is also 1
        if (num == 1) {
          freqStr += r'\pi \text{ rad/s}';
        } else {
          freqStr += num.toString() + r'\pi \text{ rad/s}';
        }
      }
      // Case: numerator is 1, denominator is not 1
      else if (num == 1) {
        freqStr += r'\frac{\pi}{' + denom.toString() + r'} \text{ rad/s}';
      }
      // General case
      else {
        freqStr += r'\frac{' + num.toString() + r'\pi}{' + denom.toString() + r'} \text{ rad/s}';
      }
    }
    // Handle cases without π
    else {
      // Case: denominator is 1
      if (denom == 1) {
        freqStr += num.toString() + r' \text{ rad/s}';
      }
      // General case
      else {
        freqStr += r'\frac{' + num.toString() + r'}{' + denom.toString() + r'} \text{ rad/s}';
      }
    }
    
    return freqStr;
  }



  //***************************************************************************** */
  // Helper method to format the fundamental period LaTeX string
  String formatPeriodLatex(bool includesPi, int num, int denom) {
    String periodStr = r'T_0 = \text{LCM}(T_1, T_2, \ldots) = ';
    
    // Handle cases with π
    if (includesPi) {
      // Case: denominator is 1
      if (denom == 1) {
        // Case: numerator is also 1
        if (num == 1) {
          periodStr += r'\pi';
        } else {
          periodStr += num.toString() + r'\pi';
        }
      }
      // Case: numerator is 1, denominator is not 1
      else if (num == 1) {
        periodStr += r'\frac{\pi}{' + denom.toString() + r'}';
      }
      // General case
      else {
        periodStr += r'\frac{' + num.toString() + r'\pi}{' + denom.toString() + r'}';
      }
    } 
    // Handle cases without π
    else {
      // Case: denominator is 1
      if (denom == 1) {
        periodStr += num.toString();
      }
      // General case
      else {
        periodStr += r'\frac{' + num.toString() + r'}{' + denom.toString() + r'}';
      }
    }
    
    return periodStr;
  }
