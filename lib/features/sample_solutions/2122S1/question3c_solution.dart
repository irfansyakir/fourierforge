import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import '../../../../themes/colours.dart';

class Question3CSolutionCard extends StatelessWidget {
  const Question3CSolutionCard({super.key});

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
              'Solution',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Step 1: Identify the duality property
            const Text(
              'Step 1: Identify the duality property from the Appendix',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'From the Appendix, the duality property states:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'\text{If } x(t) \leftrightarrow X(\omega), \text{ then } X(t) \leftrightarrow 2\pi x(-\omega)',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'We need to find a known Fourier transform pair and then apply duality.',
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 2: Identify a related transform pair
            const Text(
              'Step 2: Identify a related Fourier transform pair',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'From the Appendix, we can find the following Fourier transform pair:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'e^{-a|t|} \leftrightarrow \frac{2a}{a^2 + \omega^2} \quad \text{for } a > 0',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Note that our function is:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'r(t) = \frac{2}{9 + t^2} = \frac{2}{3^2 + t^2}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is similar to the right side of the transform pair above with a = 3, but with t and ω interchanged.',
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 3: Apply the duality property
            const Text(
              'Step 3: Apply the duality property',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Using the duality property:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'If e^(-a|t|) ↔ 2a/(a² + ω²), then by duality:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'\frac{2a}{a^2 + t^2} \leftrightarrow 2\pi \cdot e^{-a|\omega|}',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'For our function with a = 3:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'r(t) = \frac{2}{9 + t^2} = \frac{2}{3^2 + t^2} = \frac{1}{3} \cdot \frac{2 \cdot 3}{3^2 + t^2}',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'By duality, the Fourier transform is:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'R(\omega) = \frac{1}{3} \cdot 2\pi \cdot e^{-3|\omega|} = \frac{2\pi}{3} \cdot e^{-3|\omega|}',
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Step 4: Determine magnitude and phase spectra
            const Text(
              'Step 4: Determine the magnitude and phase spectra',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The magnitude spectrum:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'|R(\omega)| = \frac{2\pi}{3} \cdot e^{-3|\omega|}',
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Since R(ω) is purely real and positive for all ω, the phase spectrum is:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\angle R(\omega) = 0 \quad \text{for all } \omega',
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 16),
            
            // Visualization of magnitude spectrum
            const Text(
              'Magnitude Spectrum Visualization',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: MagnitudeSpectrumVisualization(),
            ),
            
            const SizedBox(height: 16),
            
            // Visualization of phase spectrum
            const Text(
              'Phase Spectrum Visualization',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: PhaseSpectrumVisualization(),
            ),
            
            const SizedBox(height: 16),
            
            
          ],
        ),
      ),
    );
  }
}

class MagnitudeSpectrumVisualization extends StatelessWidget {
  const MagnitudeSpectrumVisualization({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate points for the magnitude spectrum
    final List<FlSpot> magnitudePoints = List.generate(
      101,
      (index) {
        final double omega = (index - 50) / 10; // Range from -5 to 5
        final double magnitude = (2 * math.pi / 3) * math.exp(-3 * omega.abs());
        return FlSpot(omega, magnitude);
      },
    );

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color.fromRGBO(158, 158, 158, 0.3),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color.fromRGBO(158, 158, 158, 0.3),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 2,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey),
        ),
        minX: -5,
        maxX: 5,
        minY: 0,
        maxY: 3,
        lineBarsData: [
          LineChartBarData(
            spots: magnitudePoints,
            isCurved: true,
            color: AppColours.chartLine,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColours.chartLine.withOpacity(0.2),  
            ),
          ),
        ],
      ),
    );
  }
}

class PhaseSpectrumVisualization extends StatelessWidget {
  const PhaseSpectrumVisualization({super.key});

  @override
  Widget build(BuildContext context) {
    // For phase spectrum, it's just a horizontal line at 0
    final List<FlSpot> phasePoints = List.generate(
      11,
      (index) {
        final double omega = (index - 5); // Range from -5 to 5
        return FlSpot(omega, 0);
      },
    );

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color.fromRGBO(158, 158, 158, 0.3),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color.fromRGBO(158, 158, 158, 0.3),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey),
        ),
        minX: -5,
        maxX: 5,
        minY: -2,
        maxY: 2,
        lineBarsData: [
          LineChartBarData(
            spots: phasePoints,
            isCurved: false,
            color: AppColours.phaseSpectrum,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}