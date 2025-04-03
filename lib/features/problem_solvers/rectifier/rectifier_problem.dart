import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:fl_chart/fl_chart.dart';
import 'rectifier_solver.dart';
import 'dart:math' as math;


class RectifierProblemScreen extends StatefulWidget {
  const RectifierProblemScreen({super.key});

  @override
  RectifierProblemScreenState createState() => RectifierProblemScreenState();
}

class RectifierProblemScreenState extends State<RectifierProblemScreen> {
  // Default parameters
  double amplitude = 2.0;
  double frequency = 2.0;
  String waveType = 'cos';
  String rectifierType = 'full';

  
  // Input controllers
  final TextEditingController amplitudeController = TextEditingController(text: '1.0');
  final TextEditingController frequencyController = TextEditingController(text: '1.0');
  
  // Calculated values
  late List<FlSpot> inputSignalPoints;
  late List<FlSpot> outputSignalPoints;
  late String outputPeriod = '0';
  late String outputFrequency = '0';
  late int currentSolutionStep = 1;
  // late List<FlSpot> spectraPoints;
  // late RectifierSolution solution;
  
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
      rectifierType: rectifierType
    );


    setState(() {
      inputSignalPoints = solver.getInputSignalPoints();
      outputSignalPoints = solver.getOutputSignalPoints();
      outputPeriod = solver.getOutputPeriod();
      outputFrequency = solver.getOutputFrequency();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rectifier Solver'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Problem statement that describes the question details
              _buildProblemDescriptionCard(),
              
              const SizedBox(height: 16),
              
              // Parameters input card 
              _buildParametersCard(),
              
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
              'Problem',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            Text(
              'A sinusoidal signal x(t) is passed through a $rectifierType-wave rectifier to produce y(t):',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            
            // Equations for input signal with variables
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  r'x(t) = \boxed{' + amplitude.toStringAsFixed(1) + r'}' +
                  waveType + r'(\boxed{' + frequency.toStringAsFixed(1) + r'}\pi t)',
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
                
                child: rectifierType == 'full' 
                  ? Math.tex(
                      'y(t) = \\begin{cases} x(t), & \\text{if } x(t) \\geq 0 \\\\ -x(t), & \\text{if } x(t) < 0 \\end{cases}',
                      textStyle: const TextStyle(fontSize: 20),
                    )
                  : Math.tex(
                      'y(t) = \\begin{cases} x(t), & \\text{if } x(t) \\geq 0 \\\\ 0, & \\text{if } x(t) < 0 \\end{cases}',
                      textStyle: const TextStyle(fontSize: 20),
                    )
                  ,
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
  
  Widget _buildParametersCard() {
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
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
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d?$'))
                      ],

                      onChanged: (value) {
                        double? parsed = double.tryParse(value);

                        if (parsed != null) {
                          // Ensure the value is within (0, 4]
                          double clampedValue = parsed.clamp(0.1, 4.0);

                          if (clampedValue != parsed) {
                            amplitudeController.text = clampedValue.toString();
                            amplitudeController.selection = TextSelection.fromPosition(
                              TextPosition(offset: amplitudeController.text.length), // Keep cursor at end
                            );
                          }

                          setState(() {
                            amplitude = clampedValue;
                          });

                          calculateSolution();
                        }
                      },
                    ),
                  ),

                  
                  const SizedBox(width: 8),
                  
                  // sin / cos buttons to toggle
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
                        calculateSolution();
                      },
                    ),
                  ),
                  
                  const Text('π·t)', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),        
            const SizedBox(height: 24),
            // Rectifier type buttons
            Row(
              children: [
                Expanded(child: 
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        rectifierType = 'full';
                        calculateSolution();
                      });
                    }, 
                    style: ElevatedButton.styleFrom(
                          backgroundColor: rectifierType == 'full' ? Colors.blue : Colors.grey.shade300,
                          foregroundColor: waveType == 'half' ? Colors.white : Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                    child: const Text('Full Wave'))
                ),

                SizedBox(width: 10), 

                Expanded(child: 
                  ElevatedButton(
                  onPressed: () {
                    setState(() {
                      rectifierType = 'half';
                      calculateSolution();
                    });
                  }, 
                  style: ElevatedButton.styleFrom(
                          backgroundColor: rectifierType == 'half' ? Colors.blue : Colors.grey.shade300,
                          foregroundColor: waveType == 'full' ? Colors.white : Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                  child: Text('Half Wave'))
                )
              ],
            )          
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
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                  minX: 0,
                  maxX: 2,
                  minY: -4,
                  maxY: 4,
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
                  minY: -4,
                  maxY: 4,
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Step navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentSolutionStep = index + 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentSolutionStep == index + 1 
                        ? Colors.blue 
                        : Colors.grey.shade300,
                      foregroundColor: currentSolutionStep == index + 1 
                        ? Colors.white 
                        : Colors.black,
                      minimumSize: const Size(40, 40),
                    ),
                    child: Text('${index + 1}'),
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 16),
            
            // Content based on current step
            _buildStepContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentSolutionStep) {
      case 1:
        return _buildStep1Content();
      case 2:
        return _buildStep2Content();
      case 3:
        return _buildStep3Content();
      case 4:
        return _buildStep4Content();
      case 5:
        return _buildStep5Content();
      default:
        return _buildStep1Content();
    }
  }

  Widget _buildStep1Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 1: Find the amplitude, period and fundamental frequency f₀.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text(
          'Based on the graph of the output signal,',
          style: TextStyle(fontSize: 16),
        ),
         const SizedBox(height: 5),
        Text(
          'Amplitude A: ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),

        Math.tex(
          r'A=\boxed{' + amplitude.toString() + r'}',
          textStyle: TextStyle(fontSize: 16),
          ),

        const SizedBox(height: 5),
        Text(
          'Period T₀:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),

        Math.tex(
          r'T_0=\boxed{' + outputPeriod + r'}',
          textStyle: TextStyle(fontSize: 16),
          ),
        const SizedBox(height: 5),
        Text(
          'Fundamental Frequency f₀:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Math.tex(r'f_0=\frac{1}{T_0}'),
        const SizedBox(height: 5),
        Math.tex(
          r'f_0=\boxed{' + outputFrequency + r'}',
          textStyle: TextStyle(fontSize: 16),
          ),
      ],
    );
  }

  Widget _buildStep2Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 2: Calculate a₀.',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        
        Text(
          rectifierType == 'full' 
              ? 'For a full-wave rectified signal:'
              : 'For a half-wave rectified signal:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),

        Math.tex(
          r'a_0= \frac{1\cdot A}{T_0}\int_{-T_0/2}^{T_0/2}y(t) dt',
          textStyle: const TextStyle(fontSize: 16),
          ),

        const SizedBox(height: 8),

        Math.tex(
          r'a_0= \frac{2\cdot A}{T_0}\int_{0}^{T}y(t) dt',
          textStyle: const TextStyle(fontSize: 16),
          ),


        
        const SizedBox(height: 16),
        const Text('Due to symmetry, we can simplify:', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: rectifierType == 'full'
            ? Math.tex(
                r'a_0 = \frac{2}{T_0}\int_{0}^{T_0/2} ' + amplitude.toString() + r'|' + waveType + r'(' + frequency.toString() + r'\pi t)|dt',
                textStyle: const TextStyle(fontSize: 16),
              )
            : Math.tex(
                r'a_0 = \frac{1}{T_0}\int_{0}^{T_0/2} ' + amplitude.toString() + waveType + r'(' + frequency.toString() + r'\pi t)dt',
                textStyle: const TextStyle(fontSize: 16),
              ),
        ),

        const SizedBox(height: 8),
        
        rectifierType == 'full'
          ? Math.tex(r'=\frac{2A}{\pi}')
          : Math.tex(r'=\frac{A}{\pi}'),
        
        const SizedBox(height: 16),
        const Text('Final result:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: rectifierType == 'full'
            ? Math.tex(
                r'a_0 = \frac{2 \cdot ' + amplitude.toString() + r'}{\pi} = \frac{' + (2 * amplitude).toString() + r'}{\pi} = ' + (2 * amplitude / math.pi).toStringAsFixed(4),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            : Math.tex(
                r'a_0 = \frac{' + amplitude.toString() + r'}{\pi} = ' + (amplitude / math.pi).toStringAsFixed(4),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
        ),
      ],
    );
  }

  Widget _buildStep3Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 3: Calculate the cosine coefficients (aₙ)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        
        Text(
          'For ${rectifierType == 'full' ? 'full' : 'half'}-wave rectified signal:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            r'a_n = \frac{2}{T_0}\int_{-T_0/2}^{T_0/2} y(t) \cos(n\omega_0 t)dt',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        
        const SizedBox(height: 12),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: rectifierType == 'full'
            ? Math.tex(
                r'a_n = \begin{cases} \frac{4\cdot\boxed{' + amplitude.toString() + r'}}{\pi(1-4n^2)} & \text{for even } n \neq 0 \\[8pt] 0 & \text{for odd } n \end{cases}',
                textStyle: const TextStyle(fontSize: 16),
              )
            : Math.tex(
              r'a_n = \begin{cases} -\frac{2\cdot\boxed{' + amplitude.toString() + r'}}{\pi(4k^2-1)} & \text{for } n = 2k \quad (k = 1, 2, 3, \ldots), \\[8pt] 0 & \text{for odd } n. \end{cases}',
              textStyle: const TextStyle(fontSize: 16),
            ),
        ),
        
        const SizedBox(height: 16),
        const Text('First few aₙ values:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        
        // Example values for the first few coefficients
        Math.tex(
          rectifierType == 'full'
         // \frac{' + (2 * amplitude).toString() + r'}{\pi} = ' + (2 * amplitude / math.pi).toStringAsFixed(4)
            ? r'a₀ = \frac{' + (2 * amplitude).toString() + r'}{\pi} = ' + (2 * amplitude / math.pi).toStringAsFixed(4)
            : r'a₀ = \frac{' + (amplitude).toString() + r'}{\pi} = ' + (amplitude / math.pi).toStringAsFixed(4),
          textStyle: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        
        Math.tex(
          rectifierType == 'full'
            ? 'a₁ = 0'
            : 'a₁ = 0',
          textStyle: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        
        Math.tex( 
          rectifierType == 'full'
            ? r'a₂ = \frac{' + (4 * amplitude).toString() + r'}{'+ (1 - 4 * (2 * 2)).toString() + r'\pi} = ' + ((4 * amplitude) / (math.pi * (1 - 16))).toStringAsFixed(4)
            : r'a₂ = \frac{' + (-2 * amplitude).toString() + r'}{'+ (3).toString() + r'\pi} = ' + ((2 * amplitude) / (math.pi * (3))).toStringAsFixed(4),
          textStyle: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),

        Math.tex( 
          rectifierType == 'full'
            ? 'a₃ = 0'
            : 'a₃ =  0',
          textStyle: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        
        Math.tex(
          rectifierType == 'full'
            ? r'a₄ = \frac{' + (4 * amplitude).toString() + r'}{'+ (1 - 4 * (4 * 4)).toString() + r'\pi} = ' + ((4 * amplitude) / (math.pi * (1 - 64))).toStringAsFixed(4)
            : r'a₄ = \frac{' + (-2 * amplitude).toString() + r'}{'+ (15).toString() + r'\pi} = ' + ((2 * amplitude) / (math.pi * (15))).toStringAsFixed(4),
          textStyle: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildStep4Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 4: Calculate the sine coefficients (bₙ)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        
        Text(
          'For ${rectifierType == 'full' ? 'full' : 'half'}-wave rectified signal:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            r'b_n = \frac{2}{T_0}\int_{-T_0/2}^{T_0/2} y(t) \sin(n\omega_0 t)dt',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        
        const SizedBox(height: 16),
        
        Text(
          'For the ${rectifierType == 'full' ? 'full' : 'half'}-wave rectified $waveType signal:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            r'b_n = 0 \quad \text{for all } n',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        
        const SizedBox(height: 16),
        const Text('Explanation:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        
        Text(
          rectifierType == 'full'
            ? '• Full-wave rectified signals have even symmetry about t=0'
            : '• Half-wave rectified cosine signals have half-wave symmetry',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        
        const Text(
          '• When integrating an even function multiplied by sin(nω₀t) (odd function)',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        
        const Text(
          '• The result over a symmetric interval is always zero',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        
        const Text(
          '• Therefore: bₙ = 0 for all values of n',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildStep5Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 5: Complete Fourier Series',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        
        const Text(
          'The Fourier series has the general form:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            r'y(t) = a_0 + \sum_{n=1}^{\infty} a_n \cos(n\omega_0 t) + \sum_{n=1}^{\infty} b_n \sin(n\omega_0 t)',
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        
        const SizedBox(height: 16),
        const Text('Substituting our coefficients:', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: rectifierType == 'full'
            ? Math.tex(
                r'y(t) = \frac{' + (2*amplitude).toString() + r'}{\pi} + \sum_{n=1}^{\infty} \frac{' + (4*amplitude).toString() + r'}{\pi(1-4n^2)} \cos(2n\omega_0 t)',
                textStyle: const TextStyle(fontSize: 16),
              )
            : Math.tex(
                // Half-wave formula remains the same
                r'y(t) = \frac{' + amplitude.toString() + r'}{\pi} + \frac{' + amplitude.toString() + r'}{2}\cos(\omega_0 t) + \sum_{n=2}^{\infty} \frac{' + amplitude.toString() + r'}{2(1-n^2)} \cos(n\omega_0 t)',
                textStyle: const TextStyle(fontSize: 16),
              ),
        ),
        
        const SizedBox(height: 16),
        const Text('Final Fourier series:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        
        // Final expressions for each case
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: rectifierType == 'full'
            ? Math.tex(
                r'y(t) = \frac{' + (2*amplitude).toString() + r'}{\pi} - \frac{' + (4*amplitude).toString() + r'}{\pi}\sum_{n=1}^{\infty} \frac{\cos(2n\omega_0 t)}{1-4n^2}',
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            : Math.tex(
                // Half-wave formula remains the same
                r'y(t) = \frac{' + amplitude.toString() + r'}{\pi} + \frac{' + amplitude.toString() + r'}{2}\cos(\omega_0 t) + \frac{' + amplitude.toString() + r'}{2}\sum_{n=2}^{\infty} \frac{\cos(n\omega_0 t)}{1-n^2}',
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
        ),

        
        const SizedBox(height: 16),
        Text(
          'Where ω₀ = $outputFrequencyπ rad/s is the fundamental frequency.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}