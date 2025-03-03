import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class SpectraVisualizationCard extends StatelessWidget {
  final List<FlSpot> magnitudeSpectraPoints;
  final List<FlSpot> phaseSpectraPoints;

  const SpectraVisualizationCard({
    super.key,
    required this.magnitudeSpectraPoints,
    required this.phaseSpectraPoints,
  });

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
              'Two-Sided Line Spectra Visualization',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Magnitude spectrum visualization
            const Text(
              'Magnitude Spectrum |cₙ|:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: true,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          // Only show integer values
                          if (value == 0) {
                            return const Text('0');
                          } else if (value.toInt() == value && value.abs() <= 3) {
                            return Text(value.toInt().toString());
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 0.2,
                        getTitlesWidget: (value, meta) {
                          if (value == 0) {
                            return const Text('0');
                          } else if (value == 0.64) {
                            return const Text('0.64');
                          } else if (value == 0.2) {
                            return const Text('0.2');
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: magnitudeSpectraPoints.map((point) {
                    // Create vertical line for each frequency component
                    return LineChartBarData(
                      spots: [
                        FlSpot(point.x, 0),  // Start from x-axis
                        point,                // Up to the magnitude value
                      ],
                      isCurved: false,
                      color: Colors.black,
                      barWidth: 1.5,
                      isStrokeCapRound: false,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) {
                          // Only show dot at the top of the line
                          if (index == 1) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: Colors.black,
                              strokeWidth: 1,
                              strokeColor: Colors.black,
                            );
                          }
                          return FlDotCirclePainter(
                            radius: 0,
                            color: Colors.transparent,
                            strokeWidth: 0,
                            strokeColor: Colors.transparent,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(show: false),
                    );
                  }).toList()..add(
                    // Add a dotted line for extension beyond n=±3
                    LineChartBarData(
                      spots: const [
                        FlSpot(-4, 0.01),
                        FlSpot(-3.5, 0.01),
                      ],
                      isCurved: false,
                      color: Colors.black,
                      barWidth: 1,
                      isStrokeCapRound: false,
                      dotData: const FlDotData(show: false),
                      dashArray: [5, 5], // Create a dotted line
                    ),
                  )..add(
                    LineChartBarData(
                      spots: const [
                        FlSpot(3.5, 0.01),
                        FlSpot(4, 0.01),
                      ],
                      isCurved: false,
                      color: Colors.black,
                      barWidth: 1,
                      isStrokeCapRound: false,
                      dotData: const FlDotData(show: false),
                      dashArray: [5, 5], // Create a dotted line
                    ),
                  ),
                  minX: -4,
                  maxX: 4,
                  minY: -0.05,
                  maxY: 0.7,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Phase spectrum visualization
            const Text(
              'Phase Spectrum:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: true,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          // Only show integer values
                          if (value == 0) {
                            return const Text('0');
                          } else if (value.toInt() == value && value.abs() <= 3) {
                            return Text(value.toInt().toString());
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        interval: math.pi,
                        getTitlesWidget: (value, meta) {
                          if (value.abs() < 0.1) {
                            return const Text('0°');
                          } else if ((value - math.pi).abs() < 0.1) {
                            return const Text('180°');
                          } else if ((value + math.pi).abs() < 0.1) {
                            return const Text('-180°');
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: phaseSpectraPoints.map((point) {
                    // Create vertical line for each frequency component
                    return LineChartBarData(
                      spots: [
                        FlSpot(point.x, 0),  // Start from x-axis
                        point,                // Up to the phase value
                      ],
                      isCurved: false,
                      color: Colors.black,
                      barWidth: 1.5,
                      isStrokeCapRound: false,
                      dotData: FlDotData(
                        show: point.y != 0, // Only show dot for non-zero phases
                        getDotPainter: (spot, percent, bar, index) {
                          // Only show dot at the top of the line for non-zero phases
                          if (index == 1 && spot.y != 0) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: Colors.black,
                              strokeWidth: 1,
                              strokeColor: Colors.black,
                            );
                          }
                          return FlDotCirclePainter(
                            radius: 0,
                            color: Colors.transparent,
                            strokeWidth: 0,
                            strokeColor: Colors.transparent,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(show: false),
                    );
                  }).toList(),
                  minX: -4,
                  maxX: 4,
                  minY: -math.pi - 0.5,
                  maxY: math.pi + 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}