import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class Question3ACard extends StatelessWidget {
  const Question3ACard({super.key});

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
              'Question 3(a)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            const Text(
              'Consider the signal:',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            
            const SizedBox(height: 8),
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 64, 
                ),
                child: Math.tex(
                  r'p(t) = -1 + \sin\left(\frac{6}{7}t\right) - 2\cos^2\left(\frac{3}{7}t\right) + 4\cos\left(\frac{6}{5}t + \frac{\pi}{3}\right)',
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            
            const SizedBox(height: 24),

            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: '(i) Express the signal p(t) in the form such that all terms are harmonically related.',
                  ),
                ]

            )),
            
       
            const SizedBox(height: 16),
            
            // Part (ii) 
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: '(ii) Determine the Fourier series coefficients of the signal ',
                  ),
                  WidgetSpan(
                    child: Math.tex(
                      r'p(t)',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' expressed in the amplitude-phase form.',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            const Text(
              '(8 Marks)',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}