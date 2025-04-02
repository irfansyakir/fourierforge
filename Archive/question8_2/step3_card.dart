import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class Step3Card extends StatelessWidget {
  const Step3Card({super.key});

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
              'Step 3: Comment on "shaping up" the line spectra',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            const Text(
              'The relationship dn = 3cn e^(-j4πnfx) reveals three important effects:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              '1. Amplitude Effect:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Math.tex(
              r'|d_n| = 3|c_n|',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const Text(
              'The magnitude of each spectral component is scaled by a factor of 3.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              '2. Phase Effect:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Math.tex(
              r'\angle d_n = \angle c_n - 4\pi nf_x',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const Text(
              'The phase is shifted by -4πnfx due to the time shift in the original equation.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              '3. Frequency Compression:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Math.tex(
              r'f_y = 4f_x',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const Text(
              'The spectrum is compressed by a factor of 4 along the frequency axis. This means that the frequency components in y(t) occur at 4 times the frequency of corresponding components in x(t).',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            const Text(
              'Overall, the line spectra of cn is "shaped up" through this linear transformation by:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Amplitude scaling (×3)',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• Frequency compression (×4)',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• Phase shift (due to the time delay of 2)',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              'This linear transformation effectively redistributes the energy in the frequency domain, compressing the spectrum while increasing its amplitude.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}