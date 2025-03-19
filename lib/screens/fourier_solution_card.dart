import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:fl_chart/fl_chart.dart';

class FourierSolutionCard extends StatelessWidget {
  const FourierSolutionCard({super.key});

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
            
            // Part (i): Express in harmonically related form
            const Text(
              'Part (i): Express the signal in harmonically related form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Step 1: Simplify the cos² term
            const Text(
              'Step 1: Simplify the cos² term',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Using the identity:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\cos^2(\theta) = \frac{1 + \cos(2\theta)}{2}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'-2\cos^2\left(\frac{3}{7}t\right) = -2 \cdot \frac{1 + \cos\left(\frac{6}{7}t\right)}{2} = -1 - \cos\left(\frac{6}{7}t\right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 2: Convert the phase-shifted cosine
            const Text(
              'Step 2: Convert the phase-shifted cosine term',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Using the identity:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\cos(A+B) = \cos(A)\cos(B) - \sin(A)\sin(B)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'4\cos\left(\frac{6}{5}t + \frac{\pi}{3}\right) = 4\left[\cos\left(\frac{6}{5}t\right)\cos\left(\frac{\pi}{3}\right) - \sin\left(\frac{6}{5}t\right)\sin\left(\frac{\pi}{3}\right)\right]',
              textStyle: const TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'= 4\left[\frac{1}{2}\cos\left(\frac{6}{5}t\right) - \frac{\sqrt{3}}{2}\sin\left(\frac{6}{5}t\right)\right]',
              textStyle: const TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'= 2\cos\left(\frac{6}{5}t\right) - 2\sqrt{3}\sin\left(\frac{6}{5}t\right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 3: Combine all terms
            const Text(
              'Step 3: Combine all terms',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'p(t) = -1 + \sin\left(\frac{6}{7}t\right) + \left(-1 - \cos\left(\frac{6}{7}t\right)\right) + \left(2\cos\left(\frac{6}{5}t\right) - 2\sqrt{3}\sin\left(\frac{6}{5}t\right)\right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'p(t) = -2 + \sin\left(\frac{6}{7}t\right) - \cos\left(\frac{6}{7}t\right) + 2\cos\left(\frac{6}{5}t\right) - 2\sqrt{3}\sin\left(\frac{6}{5}t\right)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 4: Find fundamental frequency
            const Text(
              'Step 4: Find the fundamental frequency',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The frequencies in the signal are:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\frac{6}{7} \text{ and } \frac{6}{5}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'To find the fundamental frequency ω₀, where:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\frac{6}{7} = n_1\omega_0 \text{ and } \frac{6}{5} = n_2\omega_0',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'\frac{n_2}{n_1} = \frac{\frac{6}{5}}{\frac{6}{7}} = \frac{6}{5} \cdot \frac{7}{6} = \frac{7}{5}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'The smallest integer values are n₁ = 5 and n₂ = 7, giving:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\omega_0 = \frac{6}{35}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Verifying:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\frac{6}{7} = 5 \times \frac{6}{35} \text{ and } \frac{6}{5} = 7 \times \frac{6}{35}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 5: Express in terms of fundamental frequency
            const Text(
              'Step 5: Express in terms of fundamental frequency',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'p(t) = -2 + \sin(5\omega_0 t) - \cos(5\omega_0 t) + 2\cos(7\omega_0 t) - 2\sqrt{3}\sin(7\omega_0 t)',
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              'where ω₀ = 6/35',
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 24),
            
            // Part (ii): Find amplitude-phase form
            const Text(
              'Part (ii): Determine Fourier Series coefficients in amplitude-phase form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Step 1: Convert to amplitude-phase form
            const Text(
              'Step 1: Convert to amplitude-phase form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'We need to express p(t) in the form:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'p(t) = A_0 + \sum A_n\cos(n\omega_0 t - \phi_n)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'The DC component:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'A_0 = -2',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 2: Convert the 5ω₀ terms
            const Text(
              'Step 2: Convert the 5ω₀ frequency terms',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'For frequency 5ω₀, we have:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\sin(5\omega_0 t) - \cos(5\omega_0 t)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Converting to amplitude-phase form using:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'a\cos(\theta) + b\sin(\theta) = \sqrt{a^2+b^2}\cos(\theta - \arctan(b/a))',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Here, a = -1 and b = 1, so:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'A_5 = \sqrt{(-1)^2 + 1^2} = \sqrt{2}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\phi_5 = \arctan\left(\frac{1}{-1}\right) = -\frac{\pi}{4}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const Text(
              'Since a < 0 and b > 0 (second quadrant), we adjust:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\phi_5 = -\frac{\pi}{4} + \pi = \frac{3\pi}{4}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'\sin(5\omega_0 t) - \cos(5\omega_0 t) = \sqrt{2}\cos(5\omega_0 t - \frac{3\pi}{4})',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 3: Convert the 7ω₀ terms
            const Text(
              'Step 3: Convert the 7ω₀ frequency terms',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'For frequency 7ω₀, we have:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'2\cos(7\omega_0 t) - 2\sqrt{3}\sin(7\omega_0 t)',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Here, a = 2 and b = -2√3, so:',
              style: TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'A_7 = \sqrt{(2)^2 + (-2\sqrt{3})^2} = \sqrt{4 + 12} = 4',
              textStyle: const TextStyle(fontSize: 16),
            ),
            Math.tex(
              r'\phi_7 = \arctan\left(\frac{-2\sqrt{3}}{2}\right) = \arctan(-\sqrt{3}) = -\frac{\pi}{3}',
              textStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'2\cos(7\omega_0 t) - 2\sqrt{3}\sin(7\omega_0 t) = 4\cos(7\omega_0 t + \frac{\pi}{3})',
              textStyle: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Step 4: Combine the terms
            const Text(
              'Step 4: Final amplitude-phase form',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Math.tex(
              r'p(t) = -2 + \sqrt{2}\cos(5\omega_0 t - \frac{3\pi}{4}) + 4\cos(7\omega_0 t + \frac{\pi}{3})',
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              'where ω₀ = 6/35',
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 24),
            
            // Spectrum visualizations
            const Text(
              'Magnitude and Phase Spectra',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Magnitude spectrum
            const Text(
              'Magnitude Spectrum:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: MagnitudeSpectrumChart(),
            ),
            
            const SizedBox(height: 16),
            
            // Phase spectrum
            const Text(
              'Phase Spectrum:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: PhaseSpectrumChart(),
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
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 4.5,
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 2,
                color: Colors.blue,
                width: 30,
              ),
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 1.414, // √2
                color: Colors.blue,
                width: 30,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 4,
                color: Colors.blue,
                width: 30,
              ),
            ],
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                String text = '';
                switch (value.toInt()) {
                  case 0:
                    text = 'DC (0)';
                    break;
                  case 1:
                    text = '5ω₀';
                    break;
                  case 2:
                    text = '7ω₀';
                    break;
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    text,
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
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                );
              },
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.3),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey),
        ),
      ),
    );
  }
}

class PhaseSpectrumChart extends StatelessWidget {
  const PhaseSpectrumChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        minY: -3.5,
        maxY: 3.5,
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 3.14159, // π (since A₀ is negative)
                color: Colors.red,
                width: 30,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 2.35619, // 3π/4
                color: Colors.red,
                width: 30,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: -1.0472, // -π/3
                color: Colors.red,
                width: 30,
              ),
            ],
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                String text = '';
                switch (value.toInt()) {
                  case 0:
                    text = 'DC (0)';
                    break;
                  case 1:
                    text = '5ω₀';
                    break;
                  case 2:
                    text = '7ω₀';
                    break;
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    text,
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
              getTitlesWidget: (value, meta) {
                String text = '';
                if (value == 0) {
                  text = '0';
                } else if (value == 3.14159) {
                  text = 'π';
                } else if (value == -3.14159) {
                  text = '-π';
                } else if (value == 1.5708) {
                  text = 'π/2';
                } else if (value == -1.5708) {
                  text = '-π/2';
                }
                return Text(
                  text,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                );
              },
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.3),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey),
        ),
      ),
    );
  }
}
