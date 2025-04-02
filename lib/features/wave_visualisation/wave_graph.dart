import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../themes/colours.dart';
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
    // Calculate the min and max y values from the points
    // to set the y-axis limits dynamically
    double minY = points.map((point) => point.y).reduce((a, b) => a < b ? a : b);
    double maxY = points.map((point) => point.y).reduce((a, b) => a > b ? a : b);
    
    // Add padding to the min and max y values
    // to ensure the graph is not too close to the edges
    // This padding is 10% of the range of y values
    // and ensures that the graph is not too small
    double padding = (maxY - minY) * 0.1; 
    minY = minY - padding;
    maxY = maxY + padding;
    
    // Ensure that the y-axis range is at least 4 units
    // to avoid a too small graph
    if (maxY - minY < 4) {
      double mid = (maxY + minY) / 2;
      minY = mid - 2;
      maxY = mid + 2;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: graphWidth,
            minY: minY,
            maxY: maxY,
            // Properties of the grid
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              getDrawingHorizontalLine: (value) {
                // Draws a thick black line for y=0
                if (value == 0) {
                  return FlLine(
                    color: Colors.black,
                    strokeWidth: 2.5, // Thicker line 
                    dashArray: [5, 0], 
                  );
                }
                // Regular grid lines
                return FlLine(
                  color: AppColours.gridLine,
                  strokeWidth: 1,
                );
              },
              
            ),
            // Properties of the Actual Graph
            lineBarsData: [
              LineChartBarData(
                spots: points,  // This is where points are used
                dotData: FlDotData(show: false),
                color: Colors.blue,
                barWidth: 3,
              ),
            ],
            // Properties of the titles (top, bottom, left, right)
            titlesData: FlTitlesData(
              // Bottom titles Properties
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  // x-axis are set at intervals of pi/2
                  interval: pi / 2,
                  // lambda function that gets the value of the x-axis
                  // and returns the corresponding title only if it is 0, π/2, π, 3π/2, or 2π
                  // The x-axis ranges from 0 to 2π
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
                    } else if (value == 6.28) {
                      text = '2π';
                    } 
                    else {
                      return const Text('');
                    }
                    return Text(text);
                  },
                ),
              ),
              // Left titles Properties
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                    // The y-axis ranges from -2 to 2, 
                    // lambda function that gets the value of the y-axis
                    // and returns the corresponding title only if it is -2, -1, 0, 1, or 2
                  getTitlesWidget: (value, meta) {
                    if (value == -2 || value == -1 || value == 0 || 
                        value == 1 || value == 2 || 
                        value == value.roundToDouble()) {
                      if (value >= minY && value <= maxY) {
                        return Text(value.toInt().toString());
                      }
                    }
                    // Return an empty widget for other values
                    return const Text('');
                  },
                  // intervals of 1
                  interval: 1.0,
                  reservedSize: 30,
                ),
              ),

              // no top titles or right titles
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
          ),
        ),
      ),
    );
  }
}