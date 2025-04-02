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
              'Question 8.2',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // First paragraph with RichText to ensure proper spacing and alignment
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Consider two periodic signals ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'x(t)', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' and ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'y(t)', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' that have the following time-domain relationship:',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Centered equation with larger font and more space
            Center(
              child: Math.tex(
                r'y(t) = 3x(4t - 2).',
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Second paragraph with RichText for better inline math rendering
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Further denote the fundamental frequencies of the signals ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'x(t)', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' and ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'y(t)', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' as ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'f_x', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' and ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'f_y', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Third paragraph for better spacing and readability
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'and their complex exponential Fourier series (FS) coefficients as ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'c_n', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' and ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'd_n', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ', respectively.',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Questions clearly separated for emphasis
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Find ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'f_y', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' in terms of ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'f_x', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ', and ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'd_n', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' in terms of ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'c_n', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: '.',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Final part as separate paragraph
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Comment on how the line spectra of ',
                  ),
                  WidgetSpan(
                    child: Math.tex(r'c_n', textStyle: const TextStyle(fontSize: 16)),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' being "shaped up" via this linear transformation.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}