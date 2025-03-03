import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SignalVisualizationCard extends StatelessWidget {
  final List<FlSpot> inputSignalPoints;
  final List<FlSpot> outputSignalPoints;

  const SignalVisualizationCard({
    super.key, 
    required this.inputSignalPoints, 
    required this.outputSignalPoints
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
            
            // Input signal
            const Text(
              'Input Signal x(t) = cos(2πt):',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 0.5,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 0.5,
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: inputSignalPoints,
                      isCurved: false,
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  minX: -1.25,
                  maxX: 1.25,
                  minY: -1,
                  maxY: 1,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Output signal after rectification
            const Text(
              'Output Signal y(t) (Full-wave Rectified):',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 0.5,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 0.5,
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: outputSignalPoints,
                      isCurved: false,
                      color: Colors.red,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  minX: -1.25,
                  maxX: 1.25,
                  minY: -0,
                  maxY: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}