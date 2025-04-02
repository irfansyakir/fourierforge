import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class SolutionCard extends StatelessWidget {
  const SolutionCard({super.key});

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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Step 1: Identify the signal properties
            const Text(
              'Step 1: Identify the signal properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The rectangular signal x(t) is periodic with period T₀. The signal has an amplitude of 2A and consists of rectangular pulses.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'The pulse width is T₀/2 and is centered at each integer multiple of T₀.',
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 2: Define the signal mathematically
            const Text(
              'Step 2: Define the signal mathematically',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'For one period, we can define the signal as:',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'x(t) = \begin{cases} 2A, & -\frac{T_0}{4} < t < \frac{T_0}{4} \\ 0, & \frac{T_0}{4} \leq |t| \leq \frac{T_0}{2} \end{cases}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 3: Calculate the Fourier series coefficients
            const Text(
              'Step 3: Calculate the Fourier series coefficients',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The complex exponential Fourier series coefficients are given by:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'c_n = \frac{1}{T_0}\int_{-T_0/2}^{T_0/2}x(t)e^{-j2\pi nf_0t}dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 8),
            const Text(
              'Since the signal is non-zero only from -T₀/4 to T₀/4, we can simplify the integral:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'c_n = \frac{1}{T_0}\int_{-T_0/4}^{T_0/4}2A \cdot e^{-j2\pi nf_0t}dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'= \frac{2A}{T_0}\int_{-T_0/4}^{T_0/4}e^{-j2\pi nf_0t}dt',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 4: Solve the integral
            const Text(
              'Step 4: Solve the integral',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'c_n = \frac{2A}{T_0}\left[ \frac{e^{-j2\pi nf_0t}}{-j2\pi nf_0} \right]_{-T_0/4}^{T_0/4}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            // For n ≠ 0
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'For n ≠ 0:',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'c_n = \frac{2A}{T_0} \cdot \frac{1}{-j2\pi nf_0} \left[ e^{-j2\pi nf_0 \cdot T_0/4} - e^{-j2\pi nf_0 \cdot (-T_0/4)} \right]',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'= \frac{2A}{T_0} \cdot \frac{1}{-j2\pi nf_0} \left[ e^{-j\pi n/2} - e^{j\pi n/2} \right]',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'= \frac{2A}{T_0} \cdot \frac{1}{-j2\pi nf_0} \cdot \left( -2j \sin(\pi n/2) \right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'= \frac{2A}{T_0} \cdot \frac{2j \sin(\pi n/2)}{j2\pi nf_0}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'= \frac{2A}{\pi n} \sin(\pi n/2)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 12),
            
            // For n = 0
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'For n = 0 (DC component):',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'c_0 = \frac{1}{T_0}\int_{-T_0/4}^{T_0/4}2A \cdot dt = \frac{2A}{T_0} \cdot \frac{T_0}{2} = A',
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
              r'x(t) = A + \sum_{n=-\infty, n\neq0}^{\infty} \frac{2A}{\pi n} \sin(\pi n/2) e^{j2\pi nf_0t}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            // Simplification
            const Text(
              'Note: For n = odd, sin(πn/2) = ±1, and for n = even, sin(πn/2) = 0',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Therefore, only odd harmonics contribute to the Fourier series.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'x(t) = A + \sum_{n=-\infty, n\neq0, n \text{ odd}}^{\infty} \frac{2A}{\pi n} \sin(\pi n/2) e^{j2\pi nf_0t}',
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
