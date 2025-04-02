import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class Question3BCard extends StatelessWidget {
  const Question3BCard({super.key});

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
              'Question 3(b)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Question with piecewise function
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Consider a periodic signal ',
                  ),
                  WidgetSpan(
                    child: Math.tex(
                      r'f(t)',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ', which has the fundamental period of 5 seconds and is defined as follows:',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Piecewise function definition
            Center(
              child: Math.tex(
                r'f(t) = \begin{cases} 2, & \text{for } 0 < t \leq 1; \\ 1, & \text{for } 1 < t \leq 2; \\ 0, & \text{for } 2 < t \leq 5. \end{cases}',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Part (i)
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: '(i) Find the Fourier series representation of ',
                  ),
                  WidgetSpan(
                    child: Math.tex(
                      r'f(t)',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' expressed in the ',
                  ),
                  const TextSpan(
                    text: 'complex exponential ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: 'form, i.e., ',
                  ),
                  WidgetSpan(
                    child: Math.tex(
                      r'f(t) = \sum_{n=-\infty}^{+\infty} c_n e^{j n \omega_0 t}',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: '.',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Part (ii)
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: '(ii) Based on the coefficients ',
                  ),
                  WidgetSpan(
                    child: Math.tex(
                      r'c_n',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' (for all n) obtained in part (i) and the relationship of ',
                  ),
                  WidgetSpan(
                    child: Math.tex(
                      r'c_0 = a_0',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' and ',
                  ),
                  WidgetSpan(
                    child: Math.tex(
                      r'c_n = (a_n - j b_n)/2',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' for n > 0, find the Fourier series coefficients in the ',
                  ),
                  const TextSpan(
                    text: 'trigonometric ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: 'form, i.e.,',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Math.tex(
                r'f(t) = a_0 + \sum_{n=1}^{\infty} \{a_n \cos(n\omega_0 t) + b_n \sin(n\omega_0 t)\}',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                '(10 Marks)',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
