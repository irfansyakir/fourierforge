import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:fl_chart/fl_chart.dart';
import 'equation_term.dart';


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
  
  // Maximum number of terms allowed
  final int maxTerms = 4;

  @override
  void initState() {
    super.initState();
    
    // Initialize with default terms based on the example
    terms = [
      // Term 1: -3 cos(7πt + 30°) = -3 cos(7πt + π/6)
      EquationTerm(
        amplitude: 3.0,
        hasTrigFunction: true,
        functionType: 'cos',
        frequencyNumerator: 7,
        frequencyDenominator: 1,
        phaseShiftNumerator: 1,
        phaseShiftDenominator: 6,
        isPositive: false, // Negative sign
      ),
      
      // Term 2: 4 sin(11πt - 60°) = 4 sin(11πt - π/3)
      EquationTerm(
        amplitude: 4.0,
        hasTrigFunction: true,
        functionType: 'sin',
        frequencyNumerator: 11,
        frequencyDenominator: 1,
        phaseShiftNumerator: -1,
        phaseShiftDenominator: 3,
        isPositive: true,
      ),
      
      // Term 3: -9 cos(16πt/3 - 70°) = -9 cos(16πt/3 - 7π/18)
      EquationTerm(
        amplitude: 9.0,
        hasTrigFunction: true,
        functionType: 'cos',
        frequencyNumerator: 16,
        frequencyDenominator: 3,
        phaseShiftNumerator: -7,
        phaseShiftDenominator: 18,
        isPositive: false,
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
    
    String latex = '';
    for (int i = 0; i < terms.length; i++) {
      String termLatex = terms[i].toLatexString();
      // For first term, we don't need a sign prefix
      if (i == 0) {
        if (terms[i].isPositive) {
          latex += termLatex.substring(1); // Remove the + sign
        } else {
          latex += termLatex; // Keep the - sign
        }
      } else {
        latex += termLatex; // Include the sign
      }
    }
    
    return latex;
  }

  // Add a new term to the equation
  void addTerm() {
    if (terms.length < maxTerms) {
      setState(() {
        terms.add(EquationTerm(
          amplitude: 1.0,
          hasTrigFunction: true,
          functionType: 'cos',
          frequencyNumerator: 1,
          frequencyDenominator: 1,
          phaseShiftNumerator: 0,
          phaseShiftDenominator: 1,
          isPositive: true,
        ));
        
        // Add new controllers
        controllers.add([
          TextEditingController(text: '1.0'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equation Problem'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProblemDescriptionCard(),
              const SizedBox(height: 16),
              _buildParametersCard(),
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
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Amplitude',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    double? parsed = double.tryParse(value);
                    if (parsed != null && parsed > 0) {
                      setState(() {
                        terms[index].amplitude = parsed;
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

            const Text(
              'Note: The frequency includes the constant 2',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(height: 8),
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
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        int? parsed = int.tryParse(value);
                        if (parsed != null && parsed > 0) {
                          setState(() {
                            terms[index].frequencyNumerator = parsed;
                            terms[index].simplifyFraction();
                          });
                        }
                      },
                    ),
                  ),
                  
                  const Text(' π·t / ', style: TextStyle(fontSize: 16)),
                  
                  // Frequency denominator
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: TextField(
                      controller: controllers[index][2],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        int? parsed = int.tryParse(value);
                        if (parsed != null && parsed > 0) {
                          setState(() {
                            terms[index].frequencyDenominator = parsed;
                            terms[index].simplifyFraction();
                          });
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
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      int? parsed = int.tryParse(value);
                      if (parsed != null) {
                        setState(() {
                          terms[index].phaseShiftNumerator = parsed;
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
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      int? parsed = int.tryParse(value);
                      if (parsed != null && parsed > 0) {
                        setState(() {
                          terms[index].phaseShiftDenominator = parsed;
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
}