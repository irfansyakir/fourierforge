import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../themes/colours.dart';

class WaveTransformationCard extends StatefulWidget {
  final String title;
  
  const WaveTransformationCard({
    super.key,
    this.title = 'Full-Wave Rectification Animation',
  });

  @override
  State<WaveTransformationCard> createState() => _WaveTransformationCardState();
}

class _WaveTransformationCardState extends State<WaveTransformationCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  // Wave properties
  final double _frequency = 1.0; // Frequency in Hz
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Faster animation
    );
    
    // Make the animation repeat
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Animation container
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: WaveTransformationPainter(
                      animationValue: _animationController.value,
                      frequency: _frequency,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveTransformationPainter extends CustomPainter {
  final double animationValue;
  final double frequency;
  
  WaveTransformationPainter({
    required this.animationValue,
    required this.frequency,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final double verticalCenter1 = height * 0.3;
    final double verticalCenter2 = height * 0.7;
    final double amplitude = height * 0.1;
    
    // Set up paints
    final axisPaint = Paint()
      ..color = AppColours.black
      ..strokeWidth = 1.0;
    
    final originalWavePaint = Paint()
      ..color = AppColours.originalSignal
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    
    final rectifiedWavePaint = Paint()
      ..color = AppColours.transformedSignal
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    
    final markerPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    
    final connectionPaint = Paint()
      ..color = AppColours.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    
    // Draw axes for the first graph (original)
    // X-axis
    canvas.drawLine(
      Offset(0, verticalCenter1),
      Offset(width, verticalCenter1),
      axisPaint,
    );
    
    // Y-axis
    canvas.drawLine(
      Offset(width / 2, verticalCenter1 - amplitude * 1.5),
      Offset(width / 2, verticalCenter1 + amplitude * 1.5),
      axisPaint,
    );
    
    // Draw axes for the second graph (rectified)
    // X-axis
    canvas.drawLine(
      Offset(0, verticalCenter2),
      Offset(width, verticalCenter2),
      axisPaint,
    );
    
    // Y-axis
    canvas.drawLine(
      Offset(width / 2, verticalCenter2 - amplitude * 1.5),
      Offset(width / 2, verticalCenter2),
      axisPaint,
    );
    
    // Draw graph labels
    textPainter.text = const TextSpan(
      text: 'x(t) = cos(2πt)',
      style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(10, verticalCenter1 - amplitude * 1.5 - 20));
    
    textPainter.text = const TextSpan(
      text: 'y(t) = |cos(2πt)|',
      style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.bold),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(10, verticalCenter2 - amplitude * 1.5 - 20));
    
    // Draw axis values - show the full range including -1.25 and 1.25
    final axisLabels = [-1.25, -1.0, -0.75, -0.5, -0.25, 0, 0.25, 0.5, 0.75, 1.0, 1.25];
    final axisPositions = [];
    
    // Calculate positions evenly based on the -1.25 to 1.25 range
    for (int i = 0; i < axisLabels.length; i++) {
      // Convert the label value to the position within our -1.25 to 1.25 range
      final positionInRange = (axisLabels[i] + 1.25) / 2.5;
      axisPositions.add(positionInRange * width);
    }
    
    for (int i = 0; i < axisLabels.length; i++) {
      // Draw tick marks
      canvas.drawLine(
        Offset(axisPositions[i], verticalCenter1 - 3),
        Offset(axisPositions[i], verticalCenter1 + 3),
        axisPaint,
      );
      
      canvas.drawLine(
        Offset(axisPositions[i], verticalCenter2 - 3),
        Offset(axisPositions[i], verticalCenter2 + 3),
        axisPaint,
      );
      
      // Draw labels
      textPainter.text = TextSpan(
        text: axisLabels[i].toStringAsFixed(2),
        style: TextStyle(color: Colors.black, fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(
        canvas, 
        Offset(axisPositions[i] - textPainter.width / 2, verticalCenter1 + 5)
      );
      
      textPainter.paint(
        canvas, 
        Offset(axisPositions[i] - textPainter.width / 2, verticalCenter2 + 5)
      );
    }
    
    // Draw the value 1 on y-axis for both graphs
    textPainter.text = const TextSpan(
      text: '1',
      style: TextStyle(color: Colors.black, fontSize: 10),
    );
    textPainter.layout();
    textPainter.paint(
      canvas, 
      Offset(width / 2 + 5, verticalCenter1 - amplitude - textPainter.height / 2)
    );
    
    textPainter.paint(
      canvas, 
      Offset(width / 2 + 5, verticalCenter2 - amplitude - textPainter.height / 2)
    );
    
    // Draw the value -1 on y-axis for the first graph only
    textPainter.text = const TextSpan(
      text: '-1',
      style: TextStyle(color: Colors.black, fontSize: 10),
    );
    textPainter.layout();
    textPainter.paint(
      canvas, 
      Offset(width / 2 + 5, verticalCenter1 + amplitude - textPainter.height / 2)
    );
    
    // Draw arrows for axes - horizontal arrows at the end of x-axis
    _drawArrow(canvas, Offset(width - 10, verticalCenter1), Offset(width, verticalCenter1), axisPaint);
    _drawArrow(canvas, Offset(width - 10, verticalCenter2), Offset(width, verticalCenter2), axisPaint);
    
    // Vertical arrows pointing upward for y-axis
    _drawArrow(canvas, Offset(width / 2, verticalCenter1 - amplitude * 1.5 + 10), Offset(width / 2, verticalCenter1 - amplitude * 1.5), axisPaint);
    _drawArrow(canvas, Offset(width / 2, verticalCenter2 - amplitude * 1.5 + 10), Offset(width / 2, verticalCenter2 - amplitude * 1.5), axisPaint);
    
    // Add 't' labels at the end of x-axes
    textPainter.text = const TextSpan(
      text: 't',
      style: TextStyle(color: Colors.black, fontSize: 14, fontStyle: FontStyle.italic),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(width - 15, verticalCenter1 - 5));
    textPainter.paint(canvas, Offset(width - 15, verticalCenter2 - 5));
    
    // Draw static curves
    
    // Draw the original cosine wave (x(t) = cos(2πt))
    final originalPath = Path();
    bool firstPoint = true;
    
    for (double i = 0; i <= width; i++) {
      // Map x position to time (-1.25 to 1.25)
      double time = (i / width) * 2.5 - 1.25;
      
      // Calculate y value (cosine wave)
      double y = math.cos(2 * math.pi * frequency * time);
      
      // Map to screen coordinates
      double screenY = verticalCenter1 - y * amplitude;
      
      if (firstPoint) {
        originalPath.moveTo(i, screenY);
        firstPoint = false;
      } else {
        originalPath.lineTo(i, screenY);
      }
    }
    
    canvas.drawPath(originalPath, originalWavePaint);
    
    // Draw the rectified cosine wave (y(t) = |cos(2πt)|)
    final rectifiedPath = Path();
    firstPoint = true;
    
    for (double i = 0; i <= width; i++) {
      // Map x position to time (-1.25 to 1.25)
      double time = (i / width) * 2.5 - 1.25;
      
      // Calculate y value (rectified cosine wave)
      double y = math.cos(2 * math.pi * frequency * time).abs();
      
      // Map to screen coordinates
      double screenY = verticalCenter2 - y * amplitude;
      
      if (firstPoint) {
        rectifiedPath.moveTo(i, screenY);
        firstPoint = false;
      } else {
        rectifiedPath.lineTo(i, screenY);
      }
    }
    
    canvas.drawPath(rectifiedPath, rectifiedWavePaint);
    
    // Calculate position of markers based on animation
    // animationValue goes from 0 to 1, map to -1.25 to 1.25
    final markerTime = animationValue * 2.5 - 1.25;
    
    // Map time to x-position on screen
    final markerXPos = ((markerTime + 1.25) / 2.5) * width;
    
    // Calculate y values for the current marker position
    final originalY = math.cos(2 * math.pi * frequency * markerTime);
    final rectifiedY = originalY.abs();
    
    final originalMarkerPos = Offset(
      markerXPos,
      verticalCenter1 - originalY * amplitude
    );
    
    final rectifiedMarkerPos = Offset(
      markerXPos,
      verticalCenter2 - rectifiedY * amplitude
    );
    
    // Draw the markers (yellow dots)
    canvas.drawCircle(originalMarkerPos, 6, markerPaint);
    canvas.drawCircle(rectifiedMarkerPos, 6, markerPaint);
    
    // Draw connection line between markers
    canvas.drawLine(originalMarkerPos, rectifiedMarkerPos, connectionPaint);
  }
  
  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    canvas.drawLine(start, end, paint);
    
    // Calculate the arrow head
    final double arrowSize = 7.0;
    final double angle = math.atan2(end.dy - start.dy, end.dx - start.dx);
    
    final path = Path();
    path.moveTo(end.dx, end.dy);
    path.lineTo(
      end.dx - arrowSize * math.cos(angle - math.pi / 6),
      end.dy - arrowSize * math.sin(angle - math.pi / 6)
    );
    path.lineTo(
      end.dx - arrowSize * math.cos(angle + math.pi / 6),
      end.dy - arrowSize * math.sin(angle + math.pi / 6)
    );
    path.close();
    
    canvas.drawPath(path, Paint()..color = paint.color..style = PaintingStyle.fill);
  }
  
  @override
  bool shouldRepaint(covariant WaveTransformationPainter oldDelegate) => 
    oldDelegate.animationValue != animationValue;
}