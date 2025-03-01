import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'dart:math';
import '../models/wave_model.dart';

class FormulaDisplay extends StatelessWidget {
  final WaveModel waveModel;
  
  const FormulaDisplay({
    super.key,
    required this.waveModel,
  });

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

  // Square wave formula
  Widget _buildSquareWaveFormula() {
    List<String> termsList = [];
    for (int k = 1; k <= min(5, waveModel.terms); k++) {
      int n = 2 * k - 1; // Calculate the odd harmonic
      termsList.add(r'\frac{\sin(' '${n}t' r')}{' '$n' '}');
    }
    if (waveModel.terms > 5) termsList.add(r'\cdots');

    String series = termsList.join(' + '); // Join all terms with " + "

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Math.tex(
              r'f(t) = \frac{4}{\pi} \left(' + series + r'\right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        
        const SizedBox(height: 12.0),
        
        Math.tex(
          r'f(t) = \frac{4}{\pi} \sum_{n=1,3,5,\dots}^\infty \frac{\sin(nt)}{n}',
          textStyle: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Sawtooth wave formula
  Widget _buildSawtoothWaveFormula() {
    List<String> termsList = [];
    for (int k = 1; k <= min(5, waveModel.terms); k++) {
      termsList.add(r'\frac{(-1)^{' '${k+1}' r'}\sin(' '${k}t' r')}{' '$k' '}');
    }
    if (waveModel.terms > 5) termsList.add(r'\cdots');

    String series = termsList.join(' + '); // Join all terms with " + "

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Math.tex(
              r'f(t) = \frac{2}{\pi} \left(' + series + r'\right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        
        const SizedBox(height: 12.0),
        
        Math.tex(
          r'f(t) = \frac{2}{\pi} \sum_{n=1}^{\infty} \frac{(-1)^{n+1}\sin(nt)}{n}',
          textStyle: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTriangleWaveFormula() {
    List<String> termsList = [];
    for (int k = 0; k < min(5, waveModel.terms); k++) {
      int n = 2 * k + 1; // Odd harmonics
      termsList.add(r'\frac{(-1)^{' '$k' r'}\sin(' '${n}t' r')}{' '$n^2' '}');
    }
    if (waveModel.terms > 5) termsList.add(r'\cdots');

    String series = termsList.join(' + '); // Join all terms with " + "

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Math.tex(
              r'f(t) = \frac{8}{\pi^2} \left(' + series + r'\right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        
        const SizedBox(height: 12.0),
        
        Math.tex(
          r'f(t) = \frac{8}{\pi^2} \sum_{k=0}^{\infty} \frac{(-1)^{k}\sin((2k+1)t)}{(2k+1)^2}',
          textStyle: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}