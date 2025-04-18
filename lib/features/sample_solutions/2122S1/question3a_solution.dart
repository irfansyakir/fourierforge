import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class Question3ASolutionCard extends StatelessWidget {
  const Question3ASolutionCard({super.key});

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
            
            // Part (i): Express the signal in harmonically related form
            const Text(
              'Part (i): Express the signal in a form where all terms are harmonically related',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Step 1: Expand the cos²(3t/7) term
            const Text(
              'Step 1: Expand cos²(3t/7) using the identity cos²(θ) = (1+cos(2θ))/2',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Original signal
            const Text(
              'Original signal:',
              style: TextStyle(fontSize: 16),
            ),
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Math.tex(
                  r'p(t) = -1 + \sin\left(\frac{6}{7}t\right) - 2\cos^2\left(\frac{3}{7}t\right) + 4\cos\left(\frac{6}{5}t + \frac{\pi}{3}\right)',
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Expansion steps
            const Text(
              'Expanding the cos² term:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'\cos^2\left(\frac{3}{7}t\right) = \frac{1 + \cos\left(\frac{6}{7}t\right)}{2}',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            
            // Substituting and simplifying
            const Text(
              'Substituting and simplifying:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'p(t) = -1 + \sin\left(\frac{6}{7}t\right) - 2\left[\frac{1 + \cos\left(\frac{6}{7}t\right)}{2}\right] + 4\cos\left(\frac{6}{5}t + \frac{\pi}{3}\right)',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'= -1 + \sin\left(\frac{6}{7}t\right) - 1 - \cos\left(\frac{6}{7}t\right) + 4\cos\left(\frac{6}{5}t + \frac{\pi}{3}\right)',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'= -2 + \sin\left(\frac{6}{7}t\right) - \cos\left(\frac{6}{7}t\right) + 4\cos\left(\frac{6}{5}t + \frac{\pi}{3}\right)',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Step 2: Find the fundamental frequency
            const Text(
              'Step 2: Find the fundamental frequency by determining the HCF of the frequencies',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The frequencies in the signal are 6/7 and 6/5.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Converting to a common denominator:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\frac{6}{7} = \frac{30}{35} \quad \text{and} \quad \frac{6}{5} = \frac{42}{35}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'The HCF of 30 and 42 is 6, so the fundamental frequency is:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\omega_0 = \frac{6}{35}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 3: Express frequencies as multiples of ω₀
            const Text(
              'Step 3: Express all frequencies as multiples of the fundamental frequency',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'\frac{6}{7} = \frac{30}{35} = 5 \times \frac{6}{35} = 5\omega_0',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'\frac{6}{5} = \frac{42}{35} = 7 \times \frac{6}{35} = 7\omega_0',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Step 4: Final harmonically related form
            const Text(
              'Step 4: Rewrite the signal in harmonically related form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The signal p(t) in harmonically related form is:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'p(t) = -2 + \sin(5\omega_0 t) - \cos(5\omega_0 t) + 4\cos(7\omega_0 t + \frac{\pi}{3})',
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'\text{where } \omega_0 = \frac{6}{35}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 24),
            
            // Part (ii): Amplitude-phase form
            const Text(
              'Part (ii): Determine the Fourier series coefficients in amplitude-phase form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Step 1: Identify the DC component
            const Text(
              'Step 1: Identify the DC component',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'From the harmonically related form:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'A_0 = -2',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 2: Convert sin-cos terms to amplitude-phase form
            const Text(
              'Step 2: Convert sin(5ω₀t) - cos(5ω₀t) to amplitude-phase form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Using the identity a·sin(θ) + b·cos(θ) = √(a² + b²)·sin(θ + arctan(b/a)):',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'\sin(5\omega_0 t) - \cos(5\omega_0 t) = \sqrt{1^2 + (-1)^2} \cdot \sin(5\omega_0 t + \arctan(-1))',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'= \sqrt{2} \cdot \sin(5\omega_0 t - \frac{\pi}{4})',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Converting to cosine form:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'= \sqrt{2} \cdot \cos(5\omega_0 t - \frac{\pi}{4} - \frac{\pi}{2})',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'= \sqrt{2} \cdot \cos(5\omega_0 t - \frac{3\pi}{4})',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Therefore:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'A_5 = \sqrt{2} \approx 1.414 \quad \text{and} \quad \phi_5 = \frac{3\pi}{4} = 135°',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 3: Handle the cosine term
            const Text(
              'Step 3: Determine amplitude and phase for 4cos(7ω₀t + π/3)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'For the amplitude-phase form cos(ω₀t - φ):',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'4\cos(7\omega_0 t + \frac{\pi}{3}) = 4\cos(7\omega_0 t - (-\frac{\pi}{3}))',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Therefore:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'A_7 = 4 \quad \text{and} \quad \phi_7 = -\frac{\pi}{3} = -60°',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 4: Final amplitude-phase form
            const Text(
              'Step 4: Final amplitude-phase form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The Fourier series in amplitude-phase form is:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'p(t) = -2 + \sqrt{2}\cos(5\omega_0 t - \frac{3\pi}{4}) + 4\cos(7\omega_0 t - (-\frac{\pi}{3}))',
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'= -2 + \sqrt{2}\cos(5\omega_0 t - \frac{3\pi}{4}) + 4\cos(7\omega_0 t + \frac{\pi}{3})',
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
