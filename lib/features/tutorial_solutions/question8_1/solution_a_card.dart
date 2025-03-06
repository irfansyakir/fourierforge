import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class SolutionACard extends StatelessWidget {
  const SolutionACard({super.key});

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
              'Solution (a): Trigonometric Fourier Series',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            const Text(
              'Step 1: Observe signal properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Since y(t) is a full-wave rectified cosine signal:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'y(t) = |\cos(2\pi t)|',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'By examining the shape of y(t), we can observe:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            const Text(
              '• y(t) is an even function',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• The period of y(t) is T₀ = 0.5s (twice the frequency of input)',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• The fundamental angular frequency is ω₀ = 2π/T₀ = 4π',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'For even functions, bₙ = 0 (no sine terms)',
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            const Text(
              'Step 2: Calculate a₀ (DC component)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'a_0 = \frac{1}{T_0}\int_{-T_0/2}^{T_0/2}y(t)dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
              Math.tex(
              r'= \frac{1}{0.5}\int_{-0.25}^{0.25}\cos(2\pi t)dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'= \frac{1}{0.5} \cdot \frac{1}{2\pi}\sin(2\pi t)\Big|_{-0.25}^{0.25}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'= \frac{1}{0.5\pi}[\sin(0.5\pi) - \sin(-0.5\pi)]',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'= \frac{1}{0.5\pi}[1 - (-1)]',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'= \frac{2}{0.5\pi}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'= \frac{4}{\pi} \times \frac{1}{2}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'=\boxed{\frac{2}{\pi}}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Step 3: Calculate aₙ (cosine coefficients)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'a_n = \frac{2}{T_0}\int_{-T_0/2}^{T_0/2}y(t)\cos(n\omega_0 t)dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'= \frac{2}{0.5}\int_{-0.25}^{0.25}\cos(2\pi t)\cos(4\pi n t)dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Using the trigonometric identity:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'\cos A \cos B = \frac{1}{2}[\cos(A+B) + \cos(A-B)]',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'a_n = 4 \times\int_{-0.25}^{0.25}\frac{1}{2}[\cos(2\pi(2n-1)t)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'+ \cos(2\pi(2n+1)t)]dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'= \frac{2}{2\pi(2n-1)}\sin(2\pi(2n-1)t)\Big|_{-0.25}^{0.25}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'+ \frac{2}{2\pi(2n+1)}\sin(2\pi(2n+1)t)\Big|_{-0.25}^{0.25}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Math.tex(
              r'= \boxed{\frac{4}{2\pi(2n-1)}\times(-1)^{n+1} + \frac{4}{2\pi(2n+1)}\times(-1)^n}',
              textStyle: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}