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
              'Question 7.1',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Question with inline math
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Consider the periodic impulse train ',
                  ),
                  WidgetSpan(
                    child: Math.tex(
                      r'\delta_{T_0}(t) = \sum_{k=-\infty}^{\infty} \delta(t - kT_0)',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(
                    text: ' shown in Figure Q7.1.',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Using the CustomPainter instead of image
            Center(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: CustomPaint(
                      painter: ImpulseTrainPainter(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Figure Q7.1',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Part (a)
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Determine the complex exponential Fourier series of ',
                    //text: '(a) Determine the complex exponential Fourier series of ',
                  ),
                  WidgetSpan(
                    child: Math.tex(
                      r'\delta_{T_0}(t)',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Part (b)
            // RichText(
            //   text: TextSpan(
            //     style: const TextStyle(fontSize: 16, color: Colors.black),
            //     children: [
            //       const TextSpan(
            //         text: '(b) Sketch the two-sided plot of the magnitude and phase spectra of ',
            //       ),
            //       WidgetSpan(
            //         child: Math.tex(
            //           r'\delta_{T_0}(t)',
            //           textStyle: const TextStyle(fontSize: 16),
            //         ),
            //         alignment: PlaceholderAlignment.middle,
            //       ),
            //       const TextSpan(text: '.'),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ImpulseTrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    
    // Draw x-axis
    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.7),
      paint,
    );
    
    // Draw impulses
    final numImpulses = 7;
    final spacing = size.width / (numImpulses + 1);
    
    for (int i = 0; i < numImpulses; i++) {
      final x = spacing * (i + 1);
      
      // Draw arrow
      canvas.drawLine(
        Offset(x, size.height * 0.7),
        Offset(x, size.height * 0.2),
        paint,
      );
      
      // Draw arrowhead
      final path = Path();
      path.moveTo(x, size.height * 0.2);
      path.lineTo(x - 5, size.height * 0.25);
      path.lineTo(x + 5, size.height * 0.25);
      path.close();
      canvas.drawPath(path, Paint()..color = Colors.blue..style = PaintingStyle.fill);
      
      // Draw label
      final label = i - 3; // -3T₀ to 3T₀
      textPainter.text = TextSpan(
        text: label == 0 ? '0' : '${label}T₀',
        style: TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height * 0.75));
    }
    
    // Draw t label at end of x-axis
    textPainter.text = TextSpan(
      text: 't',
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - 15, size.height * 0.72));
    
    // Draw ellipses to indicate continuation
    final dotPaint = Paint()..color = Colors.black;
    // Left ellipsis
    canvas.drawCircle(Offset(spacing * 0.3, size.height * 0.7), 2, dotPaint);
    canvas.drawCircle(Offset(spacing * 0.5, size.height * 0.7), 2, dotPaint);
    canvas.drawCircle(Offset(spacing * 0.7, size.height * 0.7), 2, dotPaint);
    
    // Right ellipsis
    canvas.drawCircle(Offset(size.width - spacing * 0.3, size.height * 0.7), 2, dotPaint);
    canvas.drawCircle(Offset(size.width - spacing * 0.5, size.height * 0.7), 2, dotPaint);
    canvas.drawCircle(Offset(size.width - spacing * 0.7, size.height * 0.7), 2, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}