import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../themes/colours.dart';
import 'dart:math' as math;

class Question3BSolutionCard extends StatelessWidget {
  const Question3BSolutionCard({super.key});

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
            
            // Signal visualization
            const Text(
              'Signal Visualization',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: SignalVisualization(),
            ),
            const SizedBox(height: 16),
            
            // Part (i): Complex exponential form
            const Text(
              'Part (i): Find the Fourier series in complex exponential form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Step 1: Set up the integral
            const Text(
              'Step 1: Set up the integral for the Fourier coefficients',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'For a periodic signal with period T₀ = 5, the complex exponential Fourier coefficients are:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'c_n = \frac{1}{T_0}\int_{0}^{T_0}f(t)e^{-jn\omega_0 t}dt',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'where ω₀ = 2π/T₀ = 2π/5 is the fundamental frequency.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Given the piecewise definition of f(t), we break the integral into three parts:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'c_n = \frac{1}{5}\left[\int_{0}^{1}2e^{-jn\omega_0 t}dt + \int_{1}^{2}1e^{-jn\omega_0 t}dt + \int_{2}^{5}0e^{-jn\omega_0 t}dt\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The third integral is zero, so we only need to evaluate the first two:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'c_n = \frac{1}{5}\left[\int_{0}^{1}2e^{-jn\omega_0 t}dt + \int_{1}^{2}1e^{-jn\omega_0 t}dt\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Step 2: Evaluate for n=0 (DC component)
            const Text(
              'Step 2: Calculate c₀ (DC component)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'For n = 0, the exponential term becomes 1:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'c_0 = \frac{1}{5}\left[\int_{0}^{1}2dt + \int_{1}^{2}1dt\right] = \frac{1}{5}[2 \cdot 1 + 1 \cdot 1] = \frac{3}{5}',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Step 3: Evaluate for n≠0
            const Text(
              'Step 3: Calculate cₙ for n ≠ 0',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'For n ≠ 0, we evaluate both integrals:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'First integral:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'\int_{0}^{1}2e^{-jn\omega_0 t}dt = 2 \cdot \frac{e^{-jn\omega_0 t}}{-jn\omega_0}\bigg|_{0}^{1} = \frac{2}{-jn\omega_0}[e^{-jn\omega_0} - 1]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Second integral:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'\int_{1}^{2}1e^{-jn\omega_0 t}dt = \frac{e^{-jn\omega_0 t}}{-jn\omega_0}\bigg|_{1}^{2} = \frac{1}{-jn\omega_0}[e^{-jn\omega_0 \cdot 2} - e^{-jn\omega_0}]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Combining and substituting ω₀ = 2π/5:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'c_n = \frac{1}{5}\left[\frac{2}{-jn\frac{2\pi}{5}}(e^{-jn\frac{2\pi}{5}} - 1) + \frac{1}{-jn\frac{2\pi}{5}}(e^{-jn\frac{4\pi}{5}} - e^{-jn\frac{2\pi}{5}})\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'= \frac{1}{-jn2\pi}\left[2(e^{-jn\frac{2\pi}{5}} - 1) + (e^{-jn\frac{4\pi}{5}} - e^{-jn\frac{2\pi}{5}})\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'= \frac{1}{-jn2\pi}\left[e^{-jn\frac{2\pi}{5}} - 2 + e^{-jn\frac{4\pi}{5}}\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Step 4: Final complex exponential form
            const Text(
              'Step 4: Final complex exponential Fourier series',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The complex exponential Fourier series is:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'f(t) = \sum_{n=-\infty}^{+\infty} c_n e^{jn\omega_0 t}',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'where:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'c_0 = \frac{3}{5}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'c_n = \frac{1}{-jn2\pi}\left[e^{-jn\frac{2\pi}{5}} - 2 + e^{-jn\frac{4\pi}{5}}\right] \quad \text{for } n \neq 0',
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Math.tex(
              r'\omega_0 = \frac{2\pi}{5}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 24),
            
            // Part (ii): Trigonometric form
            const Text(
              'Part (ii): Find the Fourier series in trigonometric form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Step 1: Express in terms of sines and cosines
            const Text(
              'Step 1: Express complex exponentials in terms of sines and cosines',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'First, we find the real and imaginary parts of cₙ using Euler\'s formula:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'e^{-j\theta} = \cos\theta - j\sin\theta',
              textStyle: const TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'c_n = \frac{1}{-jn2\pi}\left[\cos(n\frac{2\pi}{5}) - j\sin(n\frac{2\pi}{5}) - 2 + \cos(n\frac{4\pi}{5}) - j\sin(n\frac{4\pi}{5})\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'= \frac{1}{-jn2\pi}\left[\cos(n\frac{2\pi}{5}) + \cos(n\frac{4\pi}{5}) - 2 - j(\sin(n\frac{2\pi}{5}) + \sin(n\frac{4\pi}{5}))\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Step 2: Find real and imaginary parts
            const Text(
              'Step 2: Determine the real and imaginary parts of cₙ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Using 1/-j = j:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'c_n = \frac{j}{n2\pi}\left[\cos(n\frac{2\pi}{5}) + \cos(n\frac{4\pi}{5}) - 2 - j(\sin(n\frac{2\pi}{5}) + \sin(n\frac{4\pi}{5}))\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'= \frac{j}{n2\pi}\left[\cos(n\frac{2\pi}{5}) + \cos(n\frac{4\pi}{5}) - 2\right] + \frac{1}{n2\pi}\left[\sin(n\frac{2\pi}{5}) + \sin(n\frac{4\pi}{5})\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Therefore:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'\text{Re}(c_n) = \frac{1}{n2\pi}\left[\sin(n\frac{2\pi}{5}) + \sin(n\frac{4\pi}{5})\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'\text{Im}(c_n) = \frac{1}{n2\pi}\left[\cos(n\frac{2\pi}{5}) + \cos(n\frac{4\pi}{5}) - 2\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Step 3: Get aₙ and bₙ
            const Text(
              'Step 3: Determine aₙ and bₙ using the relationship',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Using the relationship c₀ = a₀ and cₙ = (aₙ - jbₙ)/2 for n > 0:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'a_0 = c_0 = \frac{3}{5}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'From the relationship, we can determine:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'a_n = 2 \cdot \text{Re}(c_n) = \frac{1}{n\pi}\left[\sin(n\frac{2\pi}{5}) + \sin(n\frac{4\pi}{5})\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'b_n = -2 \cdot \text{Im}(c_n) = \frac{1}{n\pi}\left[2 - \cos(n\frac{2\pi}{5}) - \cos(n\frac{4\pi}{5})\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Step 4: Final trigonometric form
            const Text(
              'Step 4: Final trigonometric Fourier series',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The trigonometric Fourier series is:',
              style: TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'f(t) = a_0 + \sum_{n=1}^{\infty} \left[a_n\cos(n\omega_0 t) + b_n\sin(n\omega_0 t)\right]',
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'where:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'a_0 = \frac{3}{5}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'a_n = \frac{1}{n\pi}\left[\sin(n\frac{2\pi}{5}) + \sin(n\frac{4\pi}{5})\right]',
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'b_n = \frac{1}{n\pi}\left[2 - \cos(n\frac{2\pi}{5}) - \cos(n\frac{4\pi}{5})\right]',
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Math.tex(
              r'\omega_0 = \frac{2\pi}{5}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Coefficient visualization
            const Text(
              'Add Visualisations below',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(height: 8),r
            // SizedBox(
            //   height: 220,R
            //   child: CoefficientVisualization(),
            // ),
          ],
        ),
      ),
    );
  }
}

class SignalVisualization extends StatelessWidget {
  const SignalVisualization({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
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
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                String text = value.toInt().toString();
                return Text(
                  text,
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
        minX: 0,
        maxX: 5,
        minY: 0,
        maxY: 2.5,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 2),
              FlSpot(1, 2),
              FlSpot(1, 1),
              FlSpot(2, 1),
              FlSpot(2, 0),
              FlSpot(5, 0),
            ],
            isCurved: false,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

class CoefficientVisualization extends StatelessWidget {
  const CoefficientVisualization({super.key});

  // Calculate coefficients for visualization
  double calculateA(int n) {
    if (n == 0) return 0.6; // a₀ = 3/5
    
    // Calculate aₙ for n > 0 
    double sum = math.sin(n * 2 * math.pi / 5) + math.sin(n * 4 * math.pi / 5);
    return sum / (n * math.pi);
  }
  
  double calculateB(int n) {
    if (n == 0) return 0; // b₀ doesn't exist
    
    // Calculate bₙ for n > 0
    double sum = 2 - math.cos(n * 2 * math.pi / 5) - math.cos(n * 4 * math.pi / 5);
    return sum / (n * math.pi);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TabBar(
            labelColor: Colors.blue,
            tabs: [
              Tab(text: 'aₙ Coefficients'),
              Tab(text: 'bₙ Coefficients'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // aₙ coefficients visualization
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 0.7,
                      minY: -0.5,
                      barGroups: List.generate(6, (index) {
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: calculateA(index),
                              color: Colors.blue,
                              width: 20,
                            ),
                          ],
                        );
                      }),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              String label = value.toInt() == 0 ? 'a₀' : 'a₍${value.toInt()}₎';
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  label,
                                  style: const TextStyle(color: Colors.black, fontSize: 12),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toStringAsFixed(1),
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
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: AppColours.gridLine,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                
                // bₙ coefficients visualization
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 0.7,
                      minY: -0.1,
                      barGroups: List.generate(6, (index) {
                        // Skip index 0 since b₀ doesn't exist
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: index == 0 ? 0 : calculateB(index),
                              color: Colors.red,
                              width: 20,
                            ),
                          ],
                        );
                      }),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              String label = value.toInt() == 0 ? '-' : 'b₍${value.toInt()}₎';
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  label,
                                  style: const TextStyle(color: Colors.black, fontSize: 12),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toStringAsFixed(1),
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
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: AppColours.gridLine,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
