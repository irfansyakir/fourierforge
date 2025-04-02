import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../../themes/colours.dart';
import 'package:fl_chart/fl_chart.dart';

class SolutionBCard extends StatelessWidget {
  const SolutionBCard({super.key});

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
              'Solution (b): Two-sided Magnitude and Phase Spectra',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Explanation of the spectra
            const Text(
              'From part (a), we found that all Fourier coefficients have the same value:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'c_n = \frac{1}{T_0} \quad \text{for all } n',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            const Text(
              'The magnitude and phase spectra are:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'|c_n| = \frac{1}{T_0} \quad \text{for all } n',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'\angle c_n = 0 \quad \text{for all } n',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 24),
            
            // Magnitude spectrum visualization
            const Text(
              'Magnitude Spectrum:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: MagnitudeSpectrumChart(),
            ),
            
            const SizedBox(height: 24),
            
            // Phase spectrum visualization
            const Text(
              'Phase Spectrum:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: PhaseSpectrumChart(),
            ),
            
            const SizedBox(height: 16),
            
            // Key observations
            const Text(
              'Key Observations:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• The magnitude spectrum is flat (constant value of 1/T₀)',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• This means all frequency components have equal importance',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• The phase spectrum is zero for all frequencies',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• This indicates that the signal is symmetric about t = 0',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• The impulse train has infinite bandwidth as all harmonics are present',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class MagnitudeSpectrumChart extends StatelessWidget {
  const MagnitudeSpectrumChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Create magnitude spectrum points
    final List<FlSpot> magnitudePoints = [];
    for (int n = -3; n <= 3; n++) {
      magnitudePoints.add(FlSpot(n.toDouble(), 1.0));
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            if (value == 0) {
              return FlLine(
                color: AppColours.gridLine,
                strokeWidth: 2,
              );
            }
            return FlLine(
              color: AppColours.gridLine,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: AppColours.gridLine,
              strokeWidth: 1,
            );
          },
        ),
        lineTouchData: const LineTouchData(enabled: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value.toInt() == value) {
                  return Text('${value.toInt()}f₀');
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == 0 || value == 1) {
                  return Text(value == 0 ? '0' : '1/T₀');
                }
                return const Text('');
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        minX: -3.5,
        maxX: 3.5,
        minY: 0,
        maxY: 1.2,
        lineBarsData: [
          LineChartBarData(
            spots: magnitudePoints,
            isCurved: false,
            color: Colors.blue,
            barWidth: 0,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 6,
                  color: Colors.blue,
                  strokeWidth: 1,
                  strokeColor: Colors.blue,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PhaseSpectrumChart extends StatelessWidget {
  const PhaseSpectrumChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Create phase spectrum points (all zeros)
    final List<FlSpot> phasePoints = [];
    for (int n = -3; n <= 3; n++) {
      phasePoints.add(FlSpot(n.toDouble(), 0.0));
    }

    return LineChart(
      LineChartData(
        lineTouchData: const LineTouchData(enabled: false),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            if (value == 0) {
              return FlLine(
                color: AppColours.gridLine,
                strokeWidth: 2,
              );
            }
            return FlLine(
              color: AppColours.gridLine,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: AppColours.gridLine,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value.toInt() == value) {
                  return Text('${value.toInt()}f₀');
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == 0) {
                  return const Text('0');
                }
                return const Text('');
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        minX: -3.5,
        maxX: 3.5,
        minY: -0.5,
        maxY: 0.5,
        lineBarsData: [
          LineChartBarData(
            spots: phasePoints,
            isCurved: false,
            color: Colors.red,
            barWidth: 0,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 6,
                  color: Colors.red,
                  strokeWidth: 1,
                  strokeColor: Colors.red,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}