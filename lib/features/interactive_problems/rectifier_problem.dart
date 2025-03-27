import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:fl_chart/fl_chart.dart';
import 'rectifier_solver.dart';

class RectifierProblemScreen extends StatefulWidget {
  const RectifierProblemScreen({super.key});

  @override
  RectifierProblemScreenState createState() => RectifierProblemScreenState();
}

class RectifierProblemScreenState extends State<RectifierProblemScreen> {
  // Default parameters
  double amplitude = 1.0;
  double frequency = 1.0;
  String waveType = 'cos';
  final double threshold = 0.0; // Fixed at 0 - not modifiable
  
  // Input controllers
  final TextEditingController amplitudeController = TextEditingController(text: '1.0');
  final TextEditingController frequencyController = TextEditingController(text: '1.0');
  
  // Calculated values
  late List<FlSpot> inputSignalPoints;
  late List<FlSpot> outputSignalPoints;
  late List<FlSpot> spectraPoints;
  late RectifierSolution solution;
  
  @override
  void initState() {
    super.initState();
    amplitudeController.text = amplitude.toString();
    frequencyController.text = frequency.toString();
    calculateSolution();
  }
  
  @override
  void dispose() {
    amplitudeController.dispose();
    frequencyController.dispose();
    super.dispose();
  }
  
  void calculateSolution() {
    RectifierSolver solver = RectifierSolver(
      amplitude: amplitude,
      frequency: frequency,
      waveType: waveType,
      threshold: threshold,
    );
    
    setState(() {
      inputSignalPoints = solver.getInputSignalPoints();
      outputSignalPoints = solver.getOutputSignalPoints();
      spectraPoints = solver.getMagnitudeSpectrumPoints();
      solution = solver.getSolution();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full-Wave Rectifier'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Problem statement
              _buildProblemDescriptionCard(),
              
              const SizedBox(height: 16),
              
              // Parameters input card - simplified
              _buildSimplifiedParametersCard(),
              
              const SizedBox(height: 16),
              
              // Signal visualization
              _buildSignalVisualizationCard(),
              
              const SizedBox(height: 16),
              
              // Calculated solution
              _buildSolutionCard(),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildProblemDescriptionCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Problem Statement',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            const Text(
              'A sinusoidal signal x(t) is passed through a full-wave rectifier to produce y(t):',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            // Formatted equation with blanks filled with current values
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  'x(t) = ${amplitude.toStringAsFixed(1)}$waveType(${frequency.toStringAsFixed(1)}\\pi t)',
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Rectifier definition
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  'y(t) = \\begin{cases} x(t), & \\text{if } x(t) \\geq 0 \\\\ -x(t), & \\text{if } x(t) < 0 \\end{cases}',
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            const Text(
              'Find the Fourier series of the output signal.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSimplifiedParametersCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Parameters',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Input signal equation with blanks
            Row(
              children: [
                const Text('x(t) = ', style: TextStyle(fontSize: 18)),
                
                // Amplitude input
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: amplitudeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      double? parsed = double.tryParse(value);
                      if (parsed != null && parsed > 0) {
                        setState(() {
                          amplitude = parsed;
                        });
                      }
                    },
                  ),
                ),
                
                const SizedBox(width: 8),
                
                // Wave type toggle
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          waveType = 'sin';
                          calculateSolution();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: waveType == 'sin' ? Colors.blue : Colors.grey.shade300,
                        foregroundColor: waveType == 'sin' ? Colors.white : Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: const Text('sin'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          waveType = 'cos';
                          calculateSolution();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: waveType == 'cos' ? Colors.blue : Colors.grey.shade300,
                        foregroundColor: waveType == 'cos' ? Colors.white : Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: const Text('cos'),
                    ),
                  ],
                ),
                
                const SizedBox(width: 8),
                const Text('(', style: TextStyle(fontSize: 18)),
                
                // Frequency input
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: frequencyController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      double? parsed = double.tryParse(value);
                      if (parsed != null && parsed > 0) {
                        setState(() {
                          frequency = parsed;
                        });
                      }
                    },
                  ),
                ),
                
                const Text('π·t)', style: TextStyle(fontSize: 18)),
              ],
            ),        
            const SizedBox(height: 24),
            
            // Calculate button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateSolution,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.indigo,
                ),
                child: const Text(
                  'Calculate Solution',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignalVisualizationCard() {
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
            const SizedBox(height: 16),
            
            // Input signal visualization
            const Text(
              'Input Signal x(t):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: true,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 0.5,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toStringAsFixed(1));
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1.0,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: inputSignalPoints,
                      isCurved: false,
                      color: Colors.blue,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                  minX: 0,
                  maxX: 2,
                  minY: -amplitude * 1.2,
                  maxY: amplitude * 1.2,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Output signal visualization
            const Text(
              'Rectified Output Signal y(t):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: true,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 0.5,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toStringAsFixed(1));
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1.0,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: outputSignalPoints,
                      isCurved: false,
                      color: Colors.orange,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                  minX: 0,
                  maxX: 2,
                  minY: -amplitude * 0.2,
                  maxY: amplitude * 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSolutionCard() {
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
            
            // DC component
            const Text(
              'DC Component (a₀):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                solution.a0Formula,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Cosine coefficients
            const Text(
              'Cosine Coefficients (aₙ):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                solution.anFormula,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Sine coefficients
            const Text(
              'Sine Coefficients (bₙ):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                solution.bnFormula,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // First few terms
            const Text(
              'First Few Terms:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                solution.firstFewTerms,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Complete Fourier series
            const Text(
              'Complete Fourier Series:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                solution.fourierSeries,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}