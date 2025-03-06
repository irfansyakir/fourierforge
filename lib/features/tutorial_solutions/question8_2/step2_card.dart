import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class Step2Card extends StatelessWidget {
  const Step2Card({super.key});

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
              'Step 2: Find the relationship between dn and cn',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            const Text(
              'For the complex exponential Fourier series:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'x(t) = \sum_{n=-\infty}^{\infty} c_n e^{j2\pi nf_xt}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'y(t) = \sum_{n=-\infty}^{\infty} d_n e^{j2\pi nf_yt}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              'We need to express dn in terms of cn using the relationship y(t) = 3x(4t - 2):',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            Math.tex(
              r'y(t) = 3x(4t - 2) = 3 \sum_{n=-\infty}^{\infty} c_n e^{j2\pi nf_x(4t-2)}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              'Simplifying the exponent:',
              style: TextStyle(fontSize: 16),
            ),
           Math.tex(
              r'e^{j2\pi nf_x(4t-2)} = e^{j2\pi nf_x \cdot 4t} \cdot e^{-j2\pi nf_x \cdot 2}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            Math.tex(
              r'= e^{j2\pi(4nf_x)t} \cdot e^{-j4\pi nf_x}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              'Since fy = 4fx, we have:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'e^{j2\pi(4nf_x)t} = e^{j2\pi n \cdot f_y \cdot t}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              'Therefore:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'y(t) = 3 \sum_{n=-\infty}^{\infty} c_n e^{-j4\pi nf_x} \cdot e^{j2\pi n \cdot f_y \cdot t}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            const Text(
              'Comparing with:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'y(t) = \sum_{n=-\infty}^{\infty} d_n e^{j2\pi nf_yt}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'we can see:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'\boxed{d_n = 3 e^{-j4\pi nf_x} \cdot c_n}',
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}