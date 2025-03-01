import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'dart:math';

enum WaveType { square, sawtooth, triangle, custom }

class WaveVisualisationScreen extends StatefulWidget {
  const WaveVisualisationScreen({super.key});

  @override
  WaveVisualisationScreenState createState() => WaveVisualisationScreenState();
}

class WaveVisualisationScreenState extends State<WaveVisualisationScreen> {
  int terms = 1; // Number of terms in the Fourier series
  double graphWidth = 6.28; // Width of the graph (2π for periodicity)
  List<FlSpot> points = []; // List of points to plot
  WaveType selectedWaveType = WaveType.square;
  double frequency = 1.0;
  double amplitude = 1.0;
  double phaseShift = 0.0;
  bool showComponentWaves = false;
  List<List<FlSpot>> componentPoints = [];

  // Custom wave coefficients (a_n and b_n)
  List<double> customCoefficients = List.generate(10, (index) => index == 0 ? 1.0 : 0.0);

  @override
  void initState() {
    super.initState();
    updateGraph(); // Initialize graph points
  }

  // Function to update the graph based on the number of terms and wave type
  void updateGraph() {
    points.clear();
    componentPoints.clear();
    
    // Initialize component waves if showing them
    if (showComponentWaves) {
      componentPoints = List.generate(terms, (index) => []);
    }
    
    for (double t = 0; t <= graphWidth; t += 0.01) {
      double x = t;
      double y = 0;
      
      // Apply frequency and phase shift to x
      double adjustedX = frequency * x + phaseShift;
      
      switch (selectedWaveType) {
        case WaveType.square:
          for (int k = 1; k <= terms; k++) {
            int n = 2 * k - 1; // Odd harmonics for square wave
            double term = (4 / (n * pi)) * sin(n * adjustedX);
            y += term;
            
            // If showing component waves, add this term's contribution
            if (showComponentWaves) {
              componentPoints[k-1].add(FlSpot(x, term * amplitude));
            }
          }
          break;
          
        case WaveType.sawtooth:
          for (int k = 1; k <= terms; k++) {
            double term = (2 / (k * pi)) * sin(k * adjustedX) * pow(-1, k+1);
            y += term;
            
            if (showComponentWaves) {
              componentPoints[k-1].add(FlSpot(x, term * amplitude));
            }
          }
          break;
          
        case WaveType.triangle:
          for (int k = 1; k <= terms; k++) {
            int n = 2 * k - 1; // Odd harmonics for triangle wave
            double term = (8 / (n * n * pi * pi)) * cos(n * adjustedX) * pow(-1, (n-1)/2);
            y += term;
            
            if (showComponentWaves) {
              componentPoints[k-1].add(FlSpot(x, term * amplitude));
            }
          }
          break;
          
        case WaveType.custom:
          // For custom wave, use the user-defined coefficients
          for (int n = 0; n < min(terms, customCoefficients.length); n++) {
            double term = 0;
            if (n == 0) {
              // DC component
              term = customCoefficients[0];
            } else {
              // Sine components
              term = customCoefficients[n] * sin(n * adjustedX);
            }
            y += term;
            
            if (showComponentWaves) {
              componentPoints[n].add(FlSpot(x, term * amplitude));
            }
          }
          break;
      }
      
      // Apply amplitude
      y *= amplitude;
      
      points.add(FlSpot(x, y));
    }
    setState(() {});
  }

  // Get the appropriate formula for the selected wave type
  Widget buildFormulaForWaveType() {
    switch (selectedWaveType) {
      case WaveType.square:
        return buildSquareWaveFormula();
      case WaveType.sawtooth:
        return buildSawtoothWaveFormula();
      case WaveType.triangle:
        return buildTriangleWaveFormula();
      case WaveType.custom:
        return buildCustomWaveFormula();
    }
  }

  // Square wave formula
  Widget buildSquareWaveFormula() {
    List<String> termsList = [];
    for (int k = 1; k <= min(5, terms); k++) {
      int n = 2 * k - 1; // Calculate the odd harmonic
      termsList.add(r'\frac{\sin(' '${n}t' r')}{' '$n' '}');
    }
    if (terms > 5) termsList.add(r'\cdots');

    String series = termsList.join(' + '); // Join all terms with " + "

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Square Wave Fourier Series:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            r'f(t) = \frac{4}{\pi} \left(' + series + r'\right)',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        Math.tex(
          r'f(t) = \frac{4}{\pi} \sum_{n=1,3,5,\dots}^\infty \frac{\sin(nt)}{n}',
          textStyle: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Sawtooth wave formula
  Widget buildSawtoothWaveFormula() {
    List<String> termsList = [];
    for (int k = 1; k <= min(5, terms); k++) {
      termsList.add(r'\frac{(-1)^{' + '${k+1}' + r'}\sin(' '${k}t' r')}{' '$k' '}');
    }
    if (terms > 5) termsList.add(r'\cdots');

    String series = termsList.join(' + '); // Join all terms with " + "

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sawtooth Wave Fourier Series:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            r'f(t) = \frac{2}{\pi} \left(' + series + r'\right)',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        Math.tex(
          r'f(t) = \frac{2}{\pi} \sum_{k=1}^{\infty} \frac{(-1)^{k+1}\sin(kt)}{k}',
          textStyle: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Triangle wave formula
  Widget buildTriangleWaveFormula() {
    List<String> termsList = [];
    for (int k = 1; k <= min(5, terms); k++) {
      int n = 2 * k - 1; // Odd harmonics
      termsList.add(r'\frac{(-1)^{' + '${(n-1)/2}' + r'}\cos(' '${n}t' r')}{' '$n^2' '}');
    }
    if (terms > 5) termsList.add(r'\cdots');

    String series = termsList.join(' + '); // Join all terms with " + "

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Triangle Wave Fourier Series:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            r'f(t) = \frac{8}{\pi^2} \left(' + series + r'\right)',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        Math.tex(
          r'f(t) = \frac{8}{\pi^2} \sum_{n=1,3,5,\dots}^{\infty} \frac{(-1)^{(n-1)/2}\cos(nt)}{n^2}',
          textStyle: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Custom wave formula
  Widget buildCustomWaveFormula() {
    List<String> termsList = [];
    if (customCoefficients[0] != 0) {
      termsList.add('${customCoefficients[0].toStringAsFixed(2)}');
    }
    
    for (int n = 1; n < min(5, customCoefficients.length); n++) {
      if (customCoefficients[n] != 0) {
        String sign = customCoefficients[n] > 0 ? '+' : '';
        termsList.add('$sign${customCoefficients[n].toStringAsFixed(2)}\\sin(${n}t)');
      }
    }
    if (terms > 5) termsList.add(r'\cdots');

    String series = termsList.join(' '); // Join all terms

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Custom Wave Fourier Series:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            r'f(t) = ' + series,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // Wave type selector using dropdown instead of buttons
  Widget buildWaveTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wave Type:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<WaveType>(
                value: selectedWaveType,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.blue, fontSize: 16),
                onChanged: (WaveType? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedWaveType = newValue;
                      updateGraph();
                    });
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: WaveType.square,
                    child: Text('Square Wave'),
                  ),
                  DropdownMenuItem(
                    value: WaveType.sawtooth,
                    child: Text('Sawtooth Wave'),
                  ),
                  DropdownMenuItem(
                    value: WaveType.triangle,
                    child: Text('Triangle Wave'),
                  ),
                  DropdownMenuItem(
                    value: WaveType.custom,
                    child: Text('Custom Wave'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Enhanced Slider with gaps and term display
  Widget buildEnhancedSlider(String label, double value, double min, double max, int? divisions, 
                            String Function(double) formatLabel, void Function(double) onChanged) {
    return Column(
      children: [
        Text(
          '$label: ${formatLabel(value)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.grey[300],
            thumbColor: Colors.blueAccent,
            overlayColor: Colors.blue.withOpacity(0.2),
            trackHeight: 8.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
            tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 6.0),
            activeTickMarkColor: Colors.blueAccent,
            inactiveTickMarkColor: Colors.grey,
            showValueIndicator: ShowValueIndicator.always,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: formatLabel(value),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  // Custom coefficients editor
  Widget buildCustomCoefficientsEditor() {
    if (selectedWaveType != WaveType.custom) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Custom Coefficients:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 80,
                child: Column(
                  children: [
                    Text(index == 0 ? 'DC' : 'sin(${index}t)'),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      width: 60,
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.purple,
                            inactiveTrackColor: Colors.grey[300],
                            thumbColor: Colors.purpleAccent,
                            trackHeight: 6.0,
                            showValueIndicator: ShowValueIndicator.always,
                          ),
                          child: Slider(
                            value: customCoefficients[index],
                            min: -1.0,
                            max: 1.0,
                            divisions: 20,
                            label: customCoefficients[index].toStringAsFixed(1),
                            onChanged: (value) {
                              setState(() {
                                customCoefficients[index] = value;
                                updateGraph();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Text(customCoefficients[index].toStringAsFixed(1)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Wave Visualization'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Wave type selector (now a dropdown)
              buildWaveTypeSelector(),
              const SizedBox(height: 16),
              
              // Graph Visualization
              Container(
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
                        // Main waveform
                        LineChartBarData(
                          spots: points,
                          isCurved: false,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                          color: Colors.blue,
                          barWidth: 3,
                        ),
                        // Component waves if enabled
                        if (showComponentWaves)
                          ...List.generate(componentPoints.length, (index) {
                            // Generate different colors for each component
                            final List<Color> colors = [
                              Colors.red,
                              Colors.green,
                              Colors.purple,
                              Colors.orange,
                              Colors.teal,
                              Colors.pink,
                              Colors.indigo,
                              Colors.amber,
                              Colors.brown,
                              Colors.cyan,
                            ];
                            
                            return LineChartBarData(
                              spots: componentPoints[index],
                              isCurved: false,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                              color: colors[index % colors.length].withOpacity(0.5),
                              barWidth: 1.5,
                            );
                          }),
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
              ),
              const SizedBox(height: 16),
              
              // Parameter controls grid
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  // Terms slider
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 600 
                        ? (MediaQuery.of(context).size.width - 48) / 2 
                        : MediaQuery.of(context).size.width - 32,
                    child: buildEnhancedSlider(
                      'Number of Terms',
                      terms.toDouble(),
                      1,
                      20,
                      19,
                      (value) => value.toInt().toString(),
                      (value) {
                        setState(() {
                          terms = value.toInt();
                          updateGraph();
                        });
                      },
                    ),
                  ),
                  
                  // Frequency slider
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 600 
                        ? (MediaQuery.of(context).size.width - 48) / 2 
                        : MediaQuery.of(context).size.width - 32,
                    child: buildEnhancedSlider(
                      'Frequency',
                      frequency,
                      0.1,
                      3.0,
                      29,
                      (value) => value.toStringAsFixed(1),
                      (value) {
                        setState(() {
                          frequency = value;
                          updateGraph();
                        });
                      },
                    ),
                  ),
                  
                  // Amplitude slider
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 600 
                        ? (MediaQuery.of(context).size.width - 48) / 2 
                        : MediaQuery.of(context).size.width - 32,
                    child: buildEnhancedSlider(
                      'Amplitude',
                      amplitude,
                      0.1,
                      2.0,
                      19,
                      (value) => value.toStringAsFixed(1),
                      (value) {
                        setState(() {
                          amplitude = value;
                          updateGraph();
                        });
                      },
                    ),
                  ),
                  
                  // Phase shift slider
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 600 
                        ? (MediaQuery.of(context).size.width - 48) / 2 
                        : MediaQuery.of(context).size.width - 32,
                    child: buildEnhancedSlider(
                      'Phase Shift',
                      phaseShift,
                      0,
                      2 * pi,
                      20,
                      (value) => '${(value / pi).toStringAsFixed(2)}π',
                      (value) {
                        setState(() {
                          phaseShift = value;
                          updateGraph();
                        });
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Show component waves toggle
              SwitchListTile(
                title: const Text('Show Component Waves', style: TextStyle(fontWeight: FontWeight.bold)),
                value: showComponentWaves,
                onChanged: (bool value) {
                  setState(() {
                    showComponentWaves = value;
                    updateGraph();
                  });
                },
                secondary: const Icon(Icons.waves),
              ),
              
              const SizedBox(height: 16),
              
              // Custom coefficients editor (only shown for custom wave type)
              buildCustomCoefficientsEditor(),
              
              const SizedBox(height: 16),
              
              // Formula display
              buildFormulaForWaveType(),
            ],
          ),
        ),
      ),
    );
  }
}