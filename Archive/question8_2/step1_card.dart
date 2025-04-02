import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class Step1Card extends StatelessWidget {
  const Step1Card({super.key});

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
              'Step 1: Find the relationship between fy and fx',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            const Text(
              'For a periodic signal x(t) with period Tx, if we apply time scaling to get x(at), the new period becomes Tx/a.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              'Let\'s rewrite the relationship in the standard form:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            Math.tex(
              r'y(t) = 3x(4t - 2) = 3x(4(t - 0.5))',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              'We have a time scaling factor of a = 4, and a time shift of b = 0.5.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              'The time scaling affects the period:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'T_y = \frac{T_x}{4}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              'Since fundamental frequency f = 1/T:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'f_y = \frac{1}{T_y} = \frac{1}{T_x/4} = \frac{4}{T_x} = 4f_x',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            Math.tex(
              r'\boxed{f_y = 4f_x}',
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}