import 'package:flutter/material.dart';

class SolutionCCard extends StatelessWidget {
  const SolutionCCard({super.key});

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
              'Solution (c): Conclusion from Magnitude Spectrum',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            const Text(
              'From the magnitude spectrum, we can conclude:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. The frequency of the output signal is doubled compared to the input signal.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '2. The spectrum has a significant DC component (0.64) indicating the signal has a non-zero average value.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '3. The spectrum contains both even and odd harmonics, with the first harmonic (c₁) being the largest after the DC component.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '4. The spectrum is symmetric (c₁ = c₋₁, c₂ = c₋₂, etc.) because the time domain signal is real.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '5. The phase is either 0° or 180° for all components, which is characteristic of signals with even symmetry.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}