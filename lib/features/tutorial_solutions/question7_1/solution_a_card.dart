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
              'Solution',
              //'Solution (a): Complex Exponential Fourier Series',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Step 1: Find c₀
            const Text(
              'Step 1: Calculate the DC component c₀',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'c_0 = \frac{1}{T_0}\int_{-T_0/2}^{T_0/2}\delta_{T_0}(t)dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'= \frac{1}{T_0}\int_{-T_0/2}^{T_0/2}\delta(t)dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            // Add bracket to show evaluation
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Math.tex(
                  r'= \frac{1}{T_0}',
                  textStyle: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    Math.tex(
                      r'\underbrace{\int_{-T_0/2}^{T_0/2}\delta(t)dt}_{=1}',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            Math.tex(
              r'= \frac{1}{T_0}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 2: Find cₙ for n ≠ 0
            const Text(
              'Step 2: Calculate the Fourier coefficients cₙ for n ≠ 0',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'c_n = \frac{1}{T_0}\int_{-T_0/2}^{T_0/2}\delta_{T_0}(t)e^{-j2\pi nf_0t}dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'= \frac{1}{T_0}\int_{-T_0/2}^{T_0/2}\delta(t)e^{-j2\pi nf_0t}dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            // Use the property of delta function
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Math.tex(
                  r'= \frac{1}{T_0}e^{-j2\pi nf_0 \cdot 0} = \frac{1}{T_0}',
                  textStyle: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 48),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Math.tex(
                    r'\int f(t)\delta(t-t_0)dt = f(t_0)',
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Conclusion
            const Text(
              'Therefore, all Fourier coefficients have the same value:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'c_n = \frac{1}{T_0} \quad \text{for all } n',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Final Fourier series expression
            const Text(
              'The complex exponential Fourier series is:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'\delta_{T_0}(t) = c_0 + \sum_{n=-\infty, n\neq0}^{\infty} c_n e^{j2\pi nf_0t}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'= \frac{1}{T_0} + \frac{1}{T_0}\sum_{n=-\infty, n\neq0}^{\infty} e^{j2\pi nf_0t}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'= \frac{1}{T_0}\sum_{n=-\infty}^{\infty} e^{j2\pi nf_0t}',
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}