import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class WaveGraph extends StatelessWidget {
  final List<FlSpot> points;
  final double graphWidth;

  const WaveGraph({
    super.key,
    required this.points,
    this.graphWidth = 6.28, // Default to 2π
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: graphWidth,
            minY: -2,
            maxY: 2,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: const Color(0xffe7e8ec),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: const Color(0xffe7e8ec),
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xffe7e8ec)),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: points,
                isCurved: false,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
                color: Colors.blue,
                barWidth: 3,
              ),
            ],
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: pi / 2,
                  getTitlesWidget: (value, meta) {
                    String text;
                    if (value == 0) {
                      text = '0';
                    } else if (value == pi / 2) {
                      text = 'π/2';
                    } else if (value == pi) {
                      text = 'π';
                    } else if (value == 3 * pi / 2) {
                      text = '3π/2';
                    } else if (value == 2 * pi) {
                      text = '2π';
                    } else {
                      return const Text('');
                    }
                    return Text(text);
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    if (value == -2 || value == -1 || value == 0 || value == 1 || value == 2) {
                      return Text(value.toInt().toString());
                    }
                    return const Text('');
                  },
                  reservedSize: 30,
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
          ),
        ),
      ),
    );
  }
}