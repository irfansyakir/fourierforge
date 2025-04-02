import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class SolutionBCard extends StatelessWidget {
  const SolutionBCard({super.key});

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
              'Solution (b): Two-sided Line Spectra',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Math.tex(
              r'y(t) = a_0 + \sum_{n=1}^{\infty} a_n \cos(n\omega_0 t) + b_n \sin(n\omega_0 t)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'= \frac{2}{\pi} + \sum_{n=1}^{\infty}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'\left\{\frac{4}{\pi(2n-1)} \times (-1)^{n+1} + \frac{4}{\pi(2n+1)} \times (-1)^n\right\}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'\cos(n\omega_0 t).',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            // Converting to complex form
            const Text(
              'Converting to complex form:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'c_0 = a_0, c_n = \frac{a_n-jb_n}{2} = \frac{a_n}{2}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),   
            // First coefficient calculation
            Math.tex(
              r'c_0 = \frac{2}{\pi} = 0.64',
              textStyle: const TextStyle(fontSize: 16),
            ),
             const SizedBox(height: 16),
            Math.tex(
              r'c_1 = c_{-1} = \frac{1}{2}\left(\frac{4}{2\pi} - \frac{4}{6\pi}\right) = 0.21',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            // Second coefficient calculation
            Math.tex(
              r'c_2 = c_{-2} = \frac{1}{2}\left(-\frac{4}{6\pi} + \frac{4}{10\pi}\right) = -0.04',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            // Third coefficient calculation
            Math.tex(
              r'c_3 = c_{-3} = \frac{1}{2}\left(\frac{4}{10\pi} - \frac{4}{14\pi}\right) = 0.018',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            // Amplitude spectrum section
            const Text(
              'The amplitude spectrum is symmetric:',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• DC component (c₀) = 0.64',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• c₁ and c₋₁ = 0.21',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• c₂ and c₋₂ = -0.04',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• c₃ and c₋₃ = 0.018',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            // Phase spectrum section
            const Text(
              'The phase spectrum shows:',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• 0° phase for c₁ and c₋₁',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• 180° phase for c₂ and c₋₂ (due to negative value)',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const Text(
              '• 0° phase for c₃ and c₋₃',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}