import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class Question3CCard extends StatelessWidget {
  const Question3CCard({super.key});

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
              'Question 3(c)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Question text
            const Text(
              'Identify the duality property from the Appendix and apply it to find the Fourier transform of r(t), given by',
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 8),
            
            // Function definition - using SingleChildScrollView for potential overflow
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  r'r(t) = \frac{2}{9 + t^2}.',
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Second part of the question
            const Text(
              'Sketch the magnitude and phase spectra of r(t).',
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 8),
            const Text(
              '(7 Marks)',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}