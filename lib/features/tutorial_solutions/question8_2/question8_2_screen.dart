import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class Question802Screen extends StatefulWidget {
  const Question802Screen({super.key});

  @override
  Question802ScreenState createState() => Question802ScreenState();
}

class Question802ScreenState extends State<Question802Screen> {
  // For the input signal visualization
  List<FlSpot> inputSignalPoints = [];
  List<FlSpot> outputSignalPoints = [];
  
  @override
  void initState() {
    super.initState();
    _generateSignalPoints();
  }
  
  void _generateSignalPoints() {
    inputSignalPoints = [];
    outputSignalPoints = [];
    
    // Generate points for one full period
    for (double x = -1.25; x <= 1.25; x += 0.01) {
      // Input signal: x(t) = cos(2πt)
      double inputY = math.cos(2 * math.pi * x);
      inputSignalPoints.add(FlSpot(x, inputY));
      
      // Output signal (after full-wave rectification)
      double outputY = inputY >= 0 ? inputY : -inputY;
      outputSignalPoints.add(FlSpot(x, outputY));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question 8.2'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Question 8.2',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Math.tex(
                      r'A\ sinusoidal\ signal\ x(t) = \cos(2\pi t)\ is\ passed\ through\ full\text{-}wave\ rectifier\ circuits\ to\ produce:',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Math.tex(
                      r'y(t) = \begin{cases}x(t), & x(t) \geq 0, \\ -x(t), & x(t) < 0.\end{cases}',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '(a) Find the trigonometric Fourier series representation of y(t).',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '(b) Plot its two-sided line spectra.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '(c) What can we conclude from the magnitude spectrum?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Signal visualization
            Card(
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
                          minY: -1.1,
                          maxY: 1.1,
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
                          minY: -0.1,
                          maxY: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Solution part (a) - Fourier series
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Solution (a): Trigonometric Fourier Series',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    const Text(
                      'Step 1: Observe signal properties',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Since y(t) is a full-wave rectified cosine signal:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Math.tex(
                      r'y(t) = |\cos(2\pi t)|',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'By examining the shape of y(t), we can observe:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '• y(t) is an even function',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '• The period of y(t) is T₀ = 0.5s (twice the frequency of input)',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '• The fundamental angular frequency is ω₀ = 2π/T₀ = 4π',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'For even functions, bₙ = 0 (no sine terms)',
                      style: TextStyle(fontSize: 16),
                    ),
                    
                    const SizedBox(height: 16),
                    const Text(
                      'Step 2: Calculate a₀ (DC component)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Math.tex(
                      r'a_0 = \frac{1}{T_0}\int_{-T_0/2}^{T_0/2}y(t)dt = \frac{1}{0.5}\int_{-0.25}^{0.25}\cos(2\pi t)dt',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Math.tex(
                      r'= \frac{1}{0.5} \cdot \frac{1}{2\pi}\sin(2\pi t)\Big|_{-0.25}^{0.25} = \frac{1}{0.5\pi}[\sin(0.5\pi) - \sin(-0.5\pi)]',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Math.tex(
                      r'= \frac{1}{0.5\pi}[1 - (-1)] = \frac{2}{0.5\pi} = \frac{4}{\pi} \cdot \frac{1}{2} = \frac{2}{\pi}',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    
                    const SizedBox(height: 16),
                    const Text(
                      'Step 3: Calculate aₙ (cosine coefficients)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Math.tex(
                      r'a_n = \frac{2}{T_0}\int_{-T_0/2}^{T_0/2}y(t)\cos(n\omega_0 t)dt = \frac{2}{0.5}\int_{-0.25}^{0.25}\cos(2\pi t)\cos(4\pi n t)dt',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Using the trigonometric identity:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Math.tex(
                      r'\cos A \cos B = \frac{1}{2}[\cos(A+B) + \cos(A-B)]',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Math.tex(
                      r'a_n = 4 \int_{-0.25}^{0.25}\frac{1}{2}[\cos(2\pi(2n-1)t) + \cos(2\pi(2n+1)t)]dt',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Math.tex(
                      r'= \frac{2}{2\pi(2n-1)}\sin(2\pi(2n-1)t)\Big|_{-0.25}^{0.25} + \frac{2}{2\pi(2n+1)}\sin(2\pi(2n+1)t)\Big|_{-0.25}^{0.25}',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Math.tex(
                      r'= \frac{4}{\pi(2n-1)}((-1)^{n+1}) + \frac{4}{\pi(2n+1)}((-1)^n)',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Solution part (b) - Spectrum
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Solution (b): Two-sided Line Spectra',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Math.tex(
                      r'y(t) = a_0 + \sum_{n=1}^{\infty} a_n \cos(n\omega_0 t) + b_n \sin(n\omega_0 t)',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Math.tex(
                      r'= \frac{2}{\pi} + \sum_{n=1}^{\infty} \left\{\frac{4}{\pi(2n-1)} \times (-1)^{n+1} + \frac{4}{\pi(2n+1)} \times (-1)^n\right\}\cos(n\omega_0 t).',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    
                    const Text(
                      'Converting to complex form:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Math.tex(
                      r'c_0 = a_0, c_n = \frac{a_n-jb_n}{2} = \frac{a_n}{2}',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Math.tex(
                      r'c_0 = \frac{2}{\pi} = 0.64, c_1 = c_{-1} = \frac{1}{2}\left(\frac{4}{2\pi} - \frac{4}{6\pi}\right) = 0.21,',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Math.tex(
                      r'c_2 = c_{-2} = \frac{1}{2}\left(-\frac{4}{6\pi} + \frac{4}{10\pi}\right) = -0.04,',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Math.tex(
                      r'c_3 = c_{-3} = \frac{1}{2}\left(\frac{4}{10\pi} - \frac{4}{14\pi}\right) = 0.018.',
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    
                    const Text(
                      'The amplitude spectrum is symmetric:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '• DC component (c₀) = 0.64',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '• c₁ and c₋₁ = 0.21',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '• c₂ and c₋₂ = -0.04',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '• c₃ and c₋₃ = 0.018',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    
                    const Text(
                      'The phase spectrum shows:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '• 0° phase for c₁ and c₋₁',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '• 180° phase for c₂ and c₋₂ (due to negative value)',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '• 0° phase for c₃ and c₋₃',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Solution part (c) - Conclusion
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Solution (c): Conclusion from Magnitude Spectrum',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    const Text(
                      'From the magnitude spectrum, we can conclude:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. The frequency of the output signal is doubled compared to the input signal.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '2. The spectrum has a significant DC component (0.64) indicating the signal has a non-zero average value.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '3. The spectrum contains both even and odd harmonics, with the first harmonic (c₁) being the largest after the DC component.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '4. The spectrum is symmetric (c₁ = c₋₁, c₂ = c₋₂, etc.) because the time domain signal is real.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '5. The phase is either 0° or 180° for all components, which is characteristic of signals with even symmetry.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}