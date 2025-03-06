import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class SignalVisualizationCard extends StatelessWidget {
  final List<FlSpot> xSignalPoints;
  final List<FlSpot> ySignalPoints;

  const SignalVisualizationCard({
    super.key,
    required this.xSignalPoints,
    required this.ySignalPoints,
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
              'Signal Visualization',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Input signal x(t)
            const Text(
              'Original Signal x(t):',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) {
                      // Draw a thicker line at y=0
                      if (value == 0) {
                        return FlLine(
                          color: const Color(0xffe7e8ec),
                          strokeWidth: 2.5,
                        );
                      }
                      return FlLine(
                        color: const Color(0xffe7e8ec),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 0.5,
                        getTitlesWidget: (value, meta) {
                          if (value == -2 || value == -1 || value == 0 || 
                              value == 1 || value == 2) {
                            return Text(value.toString());
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1.0,
                        getTitlesWidget: (value, meta) {
                          if (value == -3 || value == -2 || value == -1 || 
                              value == 0 || value == 1 || value == 2 || value == 3) {
                            return Text(value.toString());
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: xSignalPoints,
                      isCurved: false,
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  minX: -2.0,
                  maxX: 2.0,
                  minY: -3.0,
                  maxY: 3.0,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Transformed signal y(t)
            const Text(
              'Transformed Signal y(t) = 3x(4t - 2):',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) {
                      // Draw a thicker line at y=0
                      if (value == 0) {
                        return FlLine(
                          color: const Color(0xffe7e8ec),
                          strokeWidth: 2.5,
                        );
                      }
                      return FlLine(
                        color: const Color(0xffe7e8ec),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 0.5,
                        getTitlesWidget: (value, meta) {
                          if (value == -2 || value == -1 || value == 0 || 
                              value == 1 || value == 2) {
                            return Text(value.toString());
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1.0,
                        getTitlesWidget: (value, meta) {
                          if (value == -3 || value == -2 || value == -1 || 
                              value == 0 || value == 1 || value == 2 || value == 3) {
                            return Text(value.toString());
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: ySignalPoints,
                      isCurved: false,
                      color: Colors.red,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  minX: -2.0,
                  maxX: 2.0,
                  minY: -3.0,
                  maxY: 3.0,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Key observations
            const Text(
              'Key Observations:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• The transformed signal y(t) has a higher frequency (compressed in time)',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• The amplitude is 3 times larger than the original signal',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '• There is a time shift due to the -2 term in the transformation',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}