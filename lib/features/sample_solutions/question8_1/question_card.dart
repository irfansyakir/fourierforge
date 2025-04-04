import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'A sinusoidal signal',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'x(t) = \cos(2\pi t)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const Text(
              'is passed through full-wave rectifier circuits to produce:',
              style: TextStyle(fontSize: 16),
            ),
    
            const SizedBox(height: 12),
            Math.tex(
              r'y(t) = \begin{cases}x(t), & x(t) \geq 0, \\ -x(t), & x(t) < 0.\end{cases}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              'Find the trigonometric Fourier series representation of y(t).',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}