import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'dart:math';
import 'wave_model.dart';

class FormulaDisplay extends StatelessWidget {
  final WaveModel waveModel;
  
  const FormulaDisplay({
    super.key,
    required this.waveModel,
  });

  /// This widget displays the fourier series representation of the selected wave.
  /// and the general formula for the wave.
  /// based on the number of terms specified in the wave model.
  /// 
  /// Switch statement to determine which wave formula to display
  @override
  Widget build(BuildContext context) {
    switch (waveModel.type) {
      case WaveType.square:
        return _buildSquareWaveFormula();
      case WaveType.sawtooth:
        return _buildSawtoothWaveFormula();
      case WaveType.triangle:
        return _buildTriangleWaveFormula();
    }
  }

  // Dynamically builds widgets for the wave selected

  // Square wave formula
  Widget _buildSquareWaveFormula() {
    List<String> termsList = [];
    String f = waveModel.frequency.toStringAsFixed(1);
    double a = double.parse(waveModel.amplitude.toStringAsFixed(1));
    double amplitudeMultiplier = 4 * a;
    
    // Get phase shift term if not zero
    String phaseShiftTerm = '';
    if (waveModel.phaseShift != 0) {
      double phaseShift = waveModel.phaseShift;
      String formattedPhaseShift = _formatPhaseShiftForLatex(phaseShift);
      phaseShiftTerm = phaseShift > 0 ? '+$formattedPhaseShift' : formattedPhaseShift;
    }

    // Generate the fourier series terms for the square wave formula for up to 5 terms
    // The formula is a sum of odd harmonics
    for (int k = 1; k <= min(5, waveModel.terms); k++) {
      int n = 2 * k - 1; // Calculate the odd harmonic

      if (n == 1) {
        if (f == '1.0') {
          termsList.add(r'\sin(t' + phaseShiftTerm + r')');
        } else {
          termsList.add(r'\sin(t \cdot ''$f' + phaseShiftTerm + r')');
        }
        
      } else {
        if (f == '1.0') {
          termsList.add(r'\frac{\sin(' '${n}t' + phaseShiftTerm + r')}{' '$n' r'}');
        } else {
          // Add the term to the list
          termsList.add(r'\frac{\sin(' '${n}t' r' \cdot ''$f' + phaseShiftTerm + r')}{' '$n' r'}');
        }
      }
        
    }
    // If the number of terms is greater than 5, add ellipsis
    // to indicate that there are more terms
    if (waveModel.terms > 5) termsList.add(r'\cdots');

    // Join all terms with " + "
    String series = termsList.join(' + '); 

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the fourier series representation with the terms
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          width: double.infinity,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Math.tex(
              
              r'f(t) = \frac{''$amplitudeMultiplier'r'}{\pi} \left(' + series + r'\right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        
        const SizedBox(height: 12.0),
        // Display the general formula for the square wave
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child:
           Math.tex(
            r'f(t) = \frac{4}{\pi} \sum_{n=1,3,5,\dots}^\infty \frac{\sin(nt \cdot f)}{n}',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // Sawtooth wave formula
  Widget _buildSawtoothWaveFormula() {
    // Generate the fourier series terms for the wave formula for up to 5 terms
    
    List<String> termsList = [];
    String f = waveModel.frequency.toStringAsFixed(1);
    double a = double.parse(waveModel.amplitude.toStringAsFixed(1));
    double amplitudeMultiplier = 4 * a;

    // Get phase shift term if not zero
    String phaseShiftTerm = '';
    if (waveModel.phaseShift != 0) {
      double phaseShift = waveModel.phaseShift;
      String formattedPhaseShift = _formatPhaseShiftForLatex(phaseShift);
      phaseShiftTerm = phaseShift > 0 ? '+$formattedPhaseShift' : formattedPhaseShift;
    }

    for (int k = 1; k <= min(5, waveModel.terms); k++) {
      if (k == 1) {
        if (f == '1.0') {
          termsList.add(r'\sin(t' + phaseShiftTerm + r')');
        } else {
          termsList.add(r'\sin(t \cdot ''$f' + phaseShiftTerm + r')');
        }
      } else {
        if (f == '1.0') {
          termsList.add(r'\frac{(-1)^{' '${k+1}' r'}\sin(' '${k}t' + phaseShiftTerm + r')}{' '$k' '}');
        } else {
          // Add the term to the list
          termsList.add(r'\frac{(-1)^{' '${k+1}' r'}\sin(' '${k}t' r' \cdot ''$f' + phaseShiftTerm + r')}{' '$k' '}');
        }

      }
    }
    // If the number of terms is greater than 5, add ellipsis
    if (waveModel.terms > 5) termsList.add(r'\cdots');

    // Join all terms with " + "
    String series = termsList.join(' + '); 

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the fourier series representation with the terms
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          width: double.infinity,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Math.tex(
              r'f(t) = \frac{''$amplitudeMultiplier'r'}{\pi} \left(' + series + r'\right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        
        const SizedBox(height: 12.0),
        // Display the general formula for the sawtooth wave
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Math.tex(
            r'f(t) = \frac{2}{\pi} \sum_{n=1}^{\infty} \frac{(-1)^{n+1}\sin(nt \cdot f)}{n}',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildTriangleWaveFormula() {
    List<String> termsList = [];
    String f = waveModel.frequency.toStringAsFixed(1);
    double a = double.parse(waveModel.amplitude.toStringAsFixed(1));
    double amplitudeMultiplier = 8 * a;

    // Get phase shift term if not zero
    String phaseShiftTerm = '';
    if (waveModel.phaseShift != 0) {
      double phaseShift = waveModel.phaseShift;
      String formattedPhaseShift = _formatPhaseShiftForLatex(phaseShift);
      phaseShiftTerm = phaseShift > 0 ? '+$formattedPhaseShift' : formattedPhaseShift;
    }

    // Generate the fourier series terms for the triangle wave formula for up to 5 terms
    for (int k = 0; k < min(5, waveModel.terms); k++) {
      int n = 2 * k + 1; // Odd harmonics

      if (n == 1) {
        if (f == '1.0') {
          termsList.add(r'\sin(t' + phaseShiftTerm + r')');
        } else {
          termsList.add(r'\sin(t \cdot ''$f' + phaseShiftTerm + r')');
        }
      } else {
        if (f == '1.0') {
          termsList.add(r'\frac{(-1)^{' '$k' r'}\sin(' '${n}t' + phaseShiftTerm + r')}{' '$n^2' '}');
        } else {
          // Add the term to the list
          termsList.add(r'\frac{(-1)^{' '$k' r'}\sin(' '${n}t' r' \cdot ''$f' + phaseShiftTerm + r')}{' '$n^2' '}');
        }

      }
    }
    // If the number of terms is greater than 5, add ellipsis
    if (waveModel.terms > 5) termsList.add(r'\cdots');

    String series = termsList.join(' + '); // Join all terms with " + "

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the formula with the terms
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          width: double.infinity,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Math.tex(
              r'f(t) = \frac{''$amplitudeMultiplier'r'}{\pi^2} \left(' + series + r'\right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        
        const SizedBox(height: 12.0),      
        // Display the general formula for the triangle wave 
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Math.tex(
            r'f(t) = \frac{8}{\pi^2} \sum_{n=0}^{\infty} \frac{(-1)^{n}\sin((2n+1)t)}{(2n+1)^2}',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
  
  // Add helper function to format phase shift for LaTeX
  String _formatPhaseShiftForLatex(double phaseShift) {
    
    // Check if it's a simple fraction of π
    double phaseInPi = phaseShift / pi;
    
    // Close to integer multiples of π
    if ((phaseInPi - phaseInPi.round()).abs() < 0.05) {
      int multiple = phaseInPi.round();
      if (multiple == 0) return '0';
      if (multiple == 1) return '\\pi';
      if (multiple == -1) return '-\\pi';
      return '$multiple\\pi';
    }
    
    // Check for common fractions of π
    for (int denominator = 2; denominator <= 6; denominator++) {
      for (int numerator = 1; numerator < denominator; numerator++) {
        double fraction = numerator / denominator;
        if ((phaseInPi - fraction).abs() < 0.05) {
          if (numerator == 1) return '\\frac{\\pi}{$denominator}';
          return '\\frac{$numerator\\pi}{$denominator}';
        }
        if ((phaseInPi + fraction).abs() < 0.05) {
          if (numerator == 1) return '-\\frac{\\pi}{$denominator}';
          return '-\\frac{$numerator\\pi}{$denominator}';
        }
      }
    }
    
    // If no simple fraction found, return as radians
    return phaseShift.toStringAsFixed(2);
  }
}