import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:fl_chart/fl_chart.dart';
import 'equation_solver.dart';

class EquationProblemScreen extends StatefulWidget {
  const EquationProblemScreen({super.key});

  @override
  State<EquationProblemScreen> createState() => EquationProblemScreenState();
}

class EquationProblemScreenState extends State<EquationProblemScreen> {
  // List of terms in the equation
  late List<EquationTerm> terms;
  
  // Controllers for each term
  late List<List<TextEditingController>> controllers;
  
  // Maximum number of terms allowed = 4
  final int maxTerms = 4;

  @override
  void initState() {
    super.initState();
    
    // Initialize terms with example values
    terms = [
      // Term 1: 4cos(3πt/5 + π/3)
      EquationTerm(
        amplitude: 4,
        hasTrigFunction: true,
        functionType: 'cos',
        frequencyNumerator: 3,
        frequencyDenominator: 5,
        includesPi: true,
        phaseShiftNumerator: 1,
        phaseShiftDenominator: 3,
        isPositive: true,
      ),
      
      // Term 2: 3sin(t/7) 
      EquationTerm(
        amplitude: 3,
        hasTrigFunction: true,
        functionType: 'sin',
        frequencyNumerator: 1,
        frequencyDenominator: 7,
        includesPi: false, 
        phaseShiftNumerator: 0,
        phaseShiftDenominator: 1,
        isPositive: true,
      ),
    ];
    
    // Initialize controllers for each term
    initializeControllers();
  }
  
  void initializeControllers() {
    controllers = [];
    for (int i = 0; i < terms.length; i++) {
      controllers.add([
        TextEditingController(text: terms[i].amplitude.toString()),
        TextEditingController(text: terms[i].frequencyNumerator.toString()),
        TextEditingController(text: terms[i].frequencyDenominator.toString()),
        TextEditingController(text: terms[i].phaseShiftNumerator.toString()),
        TextEditingController(text: terms[i].phaseShiftDenominator.toString()),
      ]);
    }
  }
  
  // Update the controllers with current values from the terms
  void updateControllers(int index) {
    controllers[index][0].text = terms[index].amplitude.toString();
    controllers[index][1].text = terms[index].frequencyNumerator.toString();
    controllers[index][2].text = terms[index].frequencyDenominator.toString();
    controllers[index][3].text = terms[index].phaseShiftNumerator.toString();
    controllers[index][4].text = terms[index].phaseShiftDenominator.toString();
  }
  
  @override
  void dispose() {
    // Dispose all controllers
    for (var controllerList in controllers) {
      for (var controller in controllerList) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  // Get the latex string representation of the entire equation
  String getEquationLatex() {
    if (terms.isEmpty) {
      return '0';
    }
    
    // Filter out invalid terms
    List<EquationTerm> validTerms = terms.where((term) => term.isValid()).toList();
    
    if (validTerms.isEmpty) {
      return '0';
    }
    
    String latex = '';
    for (int i = 0; i < validTerms.length; i++) {
      String termLatex = validTerms[i].toLatexString();
      if (termLatex.isEmpty) continue; // Skip empty terms
      
      // No positive sign for the first term
      if (i == 0) {
        if (validTerms[i].isPositive) {
          latex += termLatex.substring(1); // Remove the + sign
        } else {
          latex += termLatex; // Keep the - sign
        }
      } else {
        latex += termLatex; // Include the sign
      }
    }
    
    return latex.isEmpty ? '0' : latex;
  }

  // Add a new term to the equation
  void addTerm() {
    if (terms.length < maxTerms) {
      setState(() {
        terms.add(EquationTerm(
          amplitude: 1,
          hasTrigFunction: true,
          functionType: 'cos',
          frequencyNumerator: 1,
          frequencyDenominator: 1,
          includesPi: true,
          phaseShiftNumerator: 0,
          phaseShiftDenominator: 1,
          isPositive: true,
        ));
        
        // Add new controllers
        controllers.add([
          TextEditingController(text: '1'),
          TextEditingController(text: '1'),
          TextEditingController(text: '1'),
          TextEditingController(text: '0'),
          TextEditingController(text: '1'),
        ]);
      });
    }
  }

  // Remove the last term from the equation
  void removeLastTerm() {
    if (terms.length > 1) {
      setState(() {
        // Dispose controllers for the removed term
        for (var controller in controllers.last) {
          controller.dispose();
        }
        
        terms.removeLast();
        controllers.removeLast();
      });
    }
  }
  
  // Remove a specific term
  void removeTerm(int index) {
    if (terms.length > 1) {
      setState(() {
        // Dispose controllers for the removed term
        for (var controller in controllers[index]) {
          controller.dispose();
        }
        
        terms.removeAt(index);
        controllers.removeAt(index);
      });
    } else {
      // If there is only 1 term left, reset it to default values
      setState(() {
        terms[index] = EquationTerm(
          amplitude: 1,
          hasTrigFunction: true,
          functionType: 'cos',
          frequencyNumerator: 1,
          frequencyDenominator: 1,
          includesPi: true,
          phaseShiftNumerator: 0,
          phaseShiftDenominator: 1,
          isPositive: true,
        );
        updateControllers(index);
      });
    }
  }

  List<FlSpot> getCombinedSignalPoints(double startX, double endX, double step) {
    // Calculate the number of points
    int numPoints = ((endX - startX) / step).ceil() + 1;
    List<double> combinedYValues = List.filled(numPoints, 0.0);
    
    // For each term, add its contribution
    for (var term in terms) {
      List<FlSpot> termPoints = term.getSignalPoints(startX, endX, step);
      for (int i = 0; i < termPoints.length && i < numPoints; i++) {
        combinedYValues[i] += termPoints[i].y;
      }
    }
    
    // Convert back to FlSpot list
    List<FlSpot> combinedPoints = [];
    for (int i = 0; i < numPoints; i++) {
      double x = startX + i * step;
      combinedPoints.add(FlSpot(x, combinedYValues[i]));
    }
    
    return combinedPoints;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equation Solver'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProblemDescriptionCard(),
              const SizedBox(height: 16),
              _buildParametersCard(),
              const SizedBox(height: 16),
              _buildSignalVisualisationCard(),
            ],
          ),
        )
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
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'f(t)=' + getEquationLatex(),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Determine if the signal f(t) is periodic.',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'If so, find the Fourier series of f(t).',
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
            
            // List of term input rows
            ...List.generate(terms.length, (index) => _buildTermInputRow(index)),
            
            const SizedBox(height: 24),
            
            // Add and Remove term buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: terms.length < maxTerms ? addTerm : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: terms.length < maxTerms ? Colors.blue : Colors.grey.shade300,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    child: const Text('Add Term'),
                  ),
                ),
                
                const SizedBox(width: 10),
                
                Expanded(
                  child: ElevatedButton(
                    onPressed: terms.length > 1 ? removeLastTerm : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: terms.length > 1 ? Colors.red : Colors.grey.shade300,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    child: const Text('Remove Last Term'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermInputRow(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        // Title row with term number and sign
        // Update only the sign toggle button section in _buildTermInputRow
        // Title row with term number and sign
        Row(
          children: [
            Text(
              'Term ${index + 1}:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            
            // Added "Sign:" label before the button
            const Text('Sign: ', style: TextStyle(fontSize: 16)),
            
            // Sign toggle button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  terms[index].isPositive = !terms[index].isPositive;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: terms[index].isPositive ? Colors.green : Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: const Size(40, 36),
                shape: const CircleBorder(),
              ),
              child: Text(
                terms[index].isPositive ? '+' : '-',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
          
          const SizedBox(height: 8),
          
          // Amplitude row with function toggle
          Row(
            children: [
              // Amplitude input on the left
              Expanded(
                flex: 2,
                child: TextField(
                  controller: controllers[index][0],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amplitude (1-10)',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Only allow digits
                  ],
                  onChanged: (value) {
                    if (value.isEmpty) return;
                    
                    int? parsed = int.tryParse(value);
                    if (parsed != null) {
                      if (parsed < 1) {
                        // If amplitude < 1, remove the term or reset it
                        removeTerm(index);
                        return;
                      } else if (parsed > 10) {
                        parsed = 10; // Clamp to max 10
                        controllers[index][0].text = '10';
                        controllers[index][0].selection = TextSelection.fromPosition(
                          const TextPosition(offset: 2), // Position at end of "10"
                        );
                      }
                      
                      setState(() {
                        terms[index].amplitude = parsed!;
                      });
                    }
                  },
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Toggle button for trig function
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      terms[index].hasTrigFunction = !terms[index].hasTrigFunction;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: terms[index].hasTrigFunction ? Colors.purple : Colors.grey.shade300,
                    foregroundColor: terms[index].hasTrigFunction ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    terms[index].hasTrigFunction ? 'Has Trig Function' : 'Constant Term',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          
          // Only show these controls if the term has a trig function
          if (terms[index].hasTrigFunction) ...[
            const SizedBox(height: 8),
            
            // Function type toggle (sin/cos)
            Row(
              children: [
                const Text('Function: ', style: TextStyle(fontSize: 16)),
                
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                terms[index].functionType = 'sin';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: terms[index].functionType == 'sin' ? Colors.blue : Colors.grey.shade300,
                              foregroundColor: terms[index].functionType == 'sin' ? Colors.white : Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                ),
                              ),
                            ),
                            child: const Text('sin'),
                          ),
                        ),
                        
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                terms[index].functionType = 'cos';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: terms[index].functionType == 'cos' ? Colors.blue : Colors.grey.shade300,
                              foregroundColor: terms[index].functionType == 'cos' ? Colors.white : Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                              ),
                            ),
                            child: const Text('cos'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Pi toggle row
            Row(
              children: [
                const Text('Frequency includes π: ', style: TextStyle(fontSize: 16)),
                
                Switch(
                  value: terms[index].includesPi,
                  activeColor: Colors.purple,
                  onChanged: (value) {
                    setState(() {
                      terms[index].includesPi = value;
                    });
                  },
                ),
              ],
            ),
            
            // Frequency row 
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text('Frequency: ', style: TextStyle(fontSize: 16)),
                  
                  // Frequency numerator
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: TextField(
                      controller: controllers[index][1],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '1-200',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.isEmpty) return;
                        
                        int? parsed = int.tryParse(value);
                        if (parsed != null) {
                          if (parsed == 0) {
                            // Reset both the numerator and denominator to defaults
                            setState(() {
                              terms[index].frequencyNumerator = 1;
                              terms[index].frequencyDenominator = 1;
                              controllers[index][1].text = '1';
                              controllers[index][2].text = '1';
                            });
                          } else if (parsed > 200) {
                            parsed = 200; // Clamp to max 20
                            controllers[index][1].text = '200';
                            controllers[index][1].selection = TextSelection.fromPosition(
                              const TextPosition(offset: 2), // Position at end of "20"
                            );
                            setState(() {
                              terms[index].frequencyNumerator = parsed!;
                              terms[index].simplifyFraction();
                            });
                          } else {
                            setState(() {
                              terms[index].frequencyNumerator = parsed!;
                              terms[index].simplifyFraction();
                            });
                          }
                        }
                      },
                    ),
                  ),
                  
                  Text(
                    terms[index].includesPi ? ' π·t / ' : ' t / ', 
                    style: const TextStyle(fontSize: 16)
                  ),
                  
                  // Frequency denominator
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: TextField(
                      controller: controllers[index][2],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '1-200',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.isEmpty) return;
                        
                        int? parsed = int.tryParse(value);
                        if (parsed != null) {
                          if (parsed == 0) {
                            // Reset both numerator and denominator to defaults
                            setState(() {
                              terms[index].frequencyNumerator = 1;
                              terms[index].frequencyDenominator = 1;
                              controllers[index][1].text = '1';
                              controllers[index][2].text = '1';
                            });
                          } else if (parsed > 200) {
                            parsed = 200; // Clamp to max 20
                            controllers[index][2].text = '200';
                            controllers[index][2].selection = TextSelection.fromPosition(
                              const TextPosition(offset: 2), // Position at end of "20"
                            );
                            setState(() {
                              terms[index].frequencyDenominator = parsed!;
                              terms[index].simplifyFraction();
                            });
                          } else {
                            setState(() {
                              terms[index].frequencyDenominator = parsed!;
                              terms[index].simplifyFraction();
                            });
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Phase shift row
            Row(
              children: [
                const Text('Phase (in radians): ', style: TextStyle(fontSize: 16)),
                
                // Phase numerator
                SizedBox(
                  width: 80,
                  height: 40,
                  child: TextField(
                    controller: controllers[index][3],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '≤ 360',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    ),
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')), // Allow negative numbers
                    ],
                    onChanged: (value) {
                      if (value.isEmpty || value == '-') return;
                      
                      int? parsed = int.tryParse(value);
                      if (parsed != null) {
                        if (parsed.abs() > 360) {
                          // Clamp to -360 to 360 range
                          parsed = parsed.isNegative ? -360 : 360;
                          controllers[index][3].text = parsed.toString();
                          controllers[index][3].selection = TextSelection.fromPosition(
                            TextPosition(offset: parsed.toString().length),
                          );
                        }
                        
                        setState(() {
                          terms[index].phaseShiftNumerator = parsed!;
                        });
                      }
                    },
                  ),
                ),
                
                const Text(' π / ', style: TextStyle(fontSize: 16)),
                
                // Phase denominator
                SizedBox(
                  width: 80,
                  height: 40,
                  child: TextField(
                    controller: controllers[index][4],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '1-180',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    ),
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      if (value.isEmpty) return;
                      
                      int? parsed = int.tryParse(value);
                      if (parsed != null) {
                        if (parsed == 0) {
                          // If denominator is 0, reset to 1
                          controllers[index][4].text = '1';
                          parsed = 1;
                        } else if (parsed > 180) {
                          // Clamp to max 180
                          parsed = 180;
                          controllers[index][4].text = '180';
                          controllers[index][4].selection = TextSelection.fromPosition(
                            const TextPosition(offset: 3), // Position at end of "180"
                          );
                        }
                        
                        setState(() {
                          terms[index].phaseShiftDenominator = parsed!;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSignalVisualisationCard() {
    // Calculate combined signal points
    List<FlSpot> signalPoints = getCombinedSignalPoints(0, 2 * math.pi, 0.01);
    
    // Determine Y-axis limits
    double minY = double.infinity;
    double maxY = double.negativeInfinity;
    
    if (signalPoints.isNotEmpty) {
      for (var point in signalPoints) {
        if (point.y < minY) minY = point.y;
        if (point.y > maxY) maxY = point.y;
      }
    } else {
      // Default if no points
      minY = -5;
      maxY = 5;
    }
    
    // Add some padding to the Y-axis
    double padding = (maxY - minY) * 0.1;
    minY -= padding;
    maxY += padding;
    
    // Ensure minimum range
    if (maxY - minY < 4) {
      double mid = (maxY + minY) / 2;
      minY = mid - 2;
      maxY = mid + 2;
    }
    
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
            
            // Signal visualization
            SizedBox(
              height: 250,
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
                        interval: math.pi / 2,
                        getTitlesWidget: (value, meta) {
                          String text = '';
                          if (value.abs() < 0.1) {
                            text = '0';
                          } else if ((value - math.pi / 2).abs() < 0.1) {
                            text = 'π/2';
                          } else if ((value - math.pi).abs() < 0.1) {
                            text = 'π';
                          } else if ((value - 3 * math.pi / 2).abs() < 0.1) {
                            text = '3π/2';
                          } else if ((value - 2 * math.pi).abs() < 0.1) {
                            text = '2π';
                          }
                          return Text(text);
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 2.0,
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
                      spots: signalPoints,
                      color: Colors.blue,
                      barWidth: 2,
                      isCurved: false,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                  minX: 0,
                  maxX: 2 * math.pi,
                  minY: minY,
                  maxY: maxY,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}