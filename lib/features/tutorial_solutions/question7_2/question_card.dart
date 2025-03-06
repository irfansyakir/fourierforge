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
              'Question 7.2',
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
                    text: 'Consider the periodic rectangular signal shown in Figure Q7.2A.',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Rectangular signal visualization
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
                      painter: RectangularSignalPainter(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Figure Q7.2A',
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
                  ),
                  WidgetSpan(
                    child: Math.tex(
                      r'x(t)',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RectangularSignalPainter extends CustomPainter {
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
    
    // Draw rectangles
    final numPeriods = 5;
    final periodWidth = size.width / numPeriods;
    final pulseWidth = periodWidth * 0.25; // Pulse width is 25% of period
    final height = size.height * 0.3; // Height of rectangular pulse
    
    // Draw 5 rectangular pulses
    for (int i = 0; i < numPeriods; i++) {
      final startX = i * periodWidth + (periodWidth / 2) - (pulseWidth / 2);
      
      // Draw rectangular pulse
      final rect = Rect.fromLTWH(
        startX, 
        size.height * 0.7 - height, 
        pulseWidth, 
        height
      );
      
      canvas.drawRect(rect, paint);
      
      // Fill the rectangle
      canvas.drawRect(
        rect, 
        Paint()..color = const Color.fromRGBO(33, 150, 243, 50)..style = PaintingStyle.fill
      );
    }
    
    // Draw time labels
    final labelPositions = [
      {'x': periodWidth, 'label': '-T₀'},
      {'x': periodWidth * 1.5, 'label': '-T₀/2'},
      {'x': periodWidth * 2.5, 'label': '0'},
      {'x': periodWidth * 3.5, 'label': 'T₀/2'},
      {'x': periodWidth * 4, 'label': 'T₀'},
      {'x': periodWidth * 4.5, 'label': '2T₀'},
    ];
    
    for (var position in labelPositions) {
      textPainter.text = TextSpan(
        text: position['label'].toString(),
        style: const TextStyle(color: Colors.black, fontSize: 12),
      );
      textPainter.layout();
      final x = (position['x'] as double) - textPainter.width / 2;
      final y = size.height * 0.75;
      textPainter.paint(canvas, Offset(x, y));
    }
    
    // Draw amplitude label (2A)
    textPainter.text = const TextSpan(
      text: '2A',
      style: TextStyle(color: Colors.black, fontSize: 12),
    );
    textPainter.layout();
    textPainter.paint(
      canvas, 
      Offset(
        periodWidth * 2.5 - textPainter.width - 5, 
        size.height * 0.7 - height / 2 - textPainter.height / 2
      )
    );
    
    // Draw x(t) label
    textPainter.text = const TextSpan(
      text: 'x(t)',
      style: TextStyle(color: Colors.black, fontSize: 14, fontStyle: FontStyle.italic),
    );
    textPainter.layout();
    textPainter.paint(
      canvas, 
      Offset(
        periodWidth * 2.5 - textPainter.width - 5, 
        size.height * 0.3
      )
    );
    
    // Draw t label at end of x-axis
    textPainter.text = const TextSpan(
      text: 't',
      style: TextStyle(color: Colors.black, fontSize: 14, fontStyle: FontStyle.italic),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - 15, size.height * 0.72));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}