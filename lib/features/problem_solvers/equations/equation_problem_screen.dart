import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../themes/colours.dart';
import 'equation_solver.dart';

// This class represents the screen for solving equations
// It allows the user to input parameters for the equation and displays the solution
// It also provides functionality to add or remove terms from the equation
// change term values such as amplitude, frequency, and phase shift
// and calculate the Fourier series of the equation
class EquationProblemScreen extends StatefulWidget {
  const EquationProblemScreen({super.key});

  @override
  State<EquationProblemScreen> createState() => EquationProblemScreenState();
}

class EquationProblemScreenState extends State<EquationProblemScreen> {
  // List of terms in the equation
  late List<EquationTerm> terms;
  
  // Controllers for each term
  // list of a list of TextEditingControllers
  // Each term has 5 parameters, so we need a list of 5 controllers for each term
  // that list of 5 controllers is added to a list
  late List<List<TextEditingController>> controllers;
  
  // Maximum number of terms allowed = 4
  final int maxTerms = 4;
  // Current preset for the equation
  late int preset = 1;
  // Current Fourier step
  late int currentFourierStep = 1;
  
  // Fourier series coefficients
  late int a0; // a0 coefficient
  // an coefficient map where int key is the harmonic number and double value is the coefficient
  late Map<int, double> anCoefficients = {};
  // bn coefficient map where int key is the harmonic number and double value is the coefficient
  late Map<int, double> bnCoefficients = {};
  // List of harmonics
  late List<int> harmonics = [];
  late Map<String, dynamic> fundamentalValues = {};
  late List<Map<String, dynamic>> termAnalysis = [];

  // initialization of the state
  @override
  void initState() {
    super.initState();
    
    // Initialize terms with example values
    presetTerms(preset);
    
    // Initialize controllers for each term
    initializeControllers();

    // Calculate the Fourier series
    calculateFourierSeries();
  }
  
  void presetTerms(int preset) {
    // Dispose existing controllers (if any) to prevent memory leaks
    try {
      if (controllers.isNotEmpty) {
        for (var controllerList in controllers) {
          for (var controller in controllerList) {
            controller.dispose();
          }
        }
      }
    } catch (e) {
      // Nothing
    }
    
    // Switch case to set terms based on the preset value
    switch (preset) {
      case 1:
        // Preset 1: -3cos(7πt + π/6) + 4sin(11πt - π/3) - 9cos(16πt/3 - 7/18π)
        terms = [
          // Term 1: -3cos(7πt + π/6)
          EquationTerm(
            amplitude: -3,
            hasTrigFunction: true,
            functionType: 'cos',
            frequencyNumerator: 7,
            frequencyDenominator: 1,
            includesPi: true,
            phaseShiftNumerator: 1,
            phaseShiftDenominator: 6,
          ),
          
          // Term 2: 4sin(11πt - π/3)
          EquationTerm(
            amplitude: 4,
            hasTrigFunction: true,
            functionType: 'sin',
            frequencyNumerator: 11,
            frequencyDenominator: 1,
            includesPi: true, 
            phaseShiftNumerator: -1,
            phaseShiftDenominator: 3,
          ),

          // Term 3: -9cos(16πt/3 - 7/18π)
          EquationTerm(
            amplitude: -9,
            hasTrigFunction: true,
            functionType: 'cos',
            frequencyNumerator: 16,
            frequencyDenominator: 3,
            includesPi: true, 
            phaseShiftNumerator: -7,
            phaseShiftDenominator: 18,
          ),
        ];
        break;
      // 1
      case 2:
        // Preset 2: 4cos(3t/5 + π/3) + 3sin(t/7) 
        terms = [
          // Term 1: 4cos(3t/5 + π/3)
          EquationTerm(
            amplitude: 4,
            hasTrigFunction: true,
            functionType: 'cos',
            frequencyNumerator: 3,
            frequencyDenominator: 5,
            includesPi: false,
            phaseShiftNumerator: 1,
            phaseShiftDenominator: 3,
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
          ),
        ];
        break;
      case 3:
        //  Preset 3: -2 - 4cos(7/9t) + 6sin(3t) + 2cos(13/6t + π/4)
        terms = [
          // Term 1: -2 
          EquationTerm(
            amplitude: -2,
            hasTrigFunction: false,
            functionType: 'cos',
            frequencyNumerator: 1,
            frequencyDenominator: 1,
            includesPi: false,
            phaseShiftNumerator: 1,
            phaseShiftDenominator: 1,
          ),
          
          // Term 2: -4cos(7/9t)
          EquationTerm(
            amplitude: -4,
            hasTrigFunction: true,
            functionType: 'cos',
            frequencyNumerator: 7,
            frequencyDenominator: 9,
            includesPi: false, 
            phaseShiftNumerator: 0,
            phaseShiftDenominator: 1,
          ),

          // Term 3: 6 sin(3t)
          EquationTerm(
            amplitude: 6,
            hasTrigFunction: true,
            functionType: 'sin',
            frequencyNumerator: 3,
            frequencyDenominator: 1,
            includesPi: false, 
            phaseShiftNumerator: 0,
            phaseShiftDenominator: 1,
          ),

          // Term 4: 2cos(13/6t + π/4)
          EquationTerm(
            amplitude: 2,
            hasTrigFunction: true,
            functionType: 'cos',
            frequencyNumerator: 13,
            frequencyDenominator: 6,
            includesPi: false, 
            phaseShiftNumerator: 1,
            phaseShiftDenominator: 4,
          ),
        ];
        break;

      // Preset 0: Default case
      default: 
        terms = [
          EquationTerm(
            amplitude: 1, 
            hasTrigFunction: false,
            functionType: 'sin', 
            frequencyNumerator: 1, 
            frequencyDenominator: 1, 
            phaseShiftNumerator: 1, 
            phaseShiftDenominator: 1,
          ),
        ];
    }
    
    // Re-initialize controllers for the new terms
    initializeControllers();
    
    // Recalculate Fourier series
    calculateFourierSeries();
  }

  void calculateFourierSeries() {
    // Calculate a0 coefficient
    a0 = calculatea0(terms);
    
    // Calculate term analysis for periodicity
    termAnalysis = analyseTermPeriodicity(terms);
    
    // Calculate fundamental periodicity values (fundamental period and fundamental frequency, both numerator and denominator)  
    fundamentalValues = calculateFundamentalPeriodicity(termAnalysis);
    
    // Calculate Fourier coefficients an and bn
    anCoefficients = calculateAnCoefficients(terms, fundamentalValues);
    bnCoefficients = calculateBnCoefficients(terms, fundamentalValues);
    
    // Get all harmonics
    harmonics = getAllHarmonics(anCoefficients, bnCoefficients);
  }

  // Initialize the 5 controllers for each term's 5 textfields
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
  
  // Update a specific term's controllers with current values from the terms
  // index specifies which term to update
  void updateControllers(int index) {
    controllers[index][0].text = terms[index].amplitude.toString();
    controllers[index][1].text = terms[index].frequencyNumerator.toString();
    controllers[index][2].text = terms[index].frequencyDenominator.toString();
    controllers[index][3].text = terms[index].phaseShiftNumerator.toString();
    controllers[index][4].text = terms[index].phaseShiftDenominator.toString();
  }
  // Get the latex string representation of the entire equation
  String getEquationLatex() {
    if (terms.isEmpty) {
      return '0';
    }
    
    // Filter out invalid terms using .where() and isValid()
    // var newList = oldList.where((element) => condition);
    List<EquationTerm> validTerms = terms.where((term) => term.isValid()).toList();
    
    // If no valid terms, return '0'
    if (validTerms.isEmpty) {
      return '0';
    }
    
    // Build the latex string
    String latex = '';
    for (int i = 0; i < validTerms.length; i++) {
      String termLatex = validTerms[i].toLatexString();
      if (termLatex.isEmpty) continue; // Skip empty terms
      
      // No positive sign for the first term
      if (i == 0) {
        if (termLatex.startsWith('+')) {
          latex += termLatex.substring(1).trim(); // Remove the + sign
        } else {
          latex += termLatex; // Keep the - sign
        }
      } else {
        latex += ' ' + termLatex; // Include the sign
      }
    }
    
    return latex.isEmpty ? '0' : latex;
  }

  // Add a new term to the equation
  void addTerm() {
    if (terms.length < maxTerms) {
      setState(() {
        // Add a new term with default values
        terms.add(EquationTerm(
          amplitude: 1,
          hasTrigFunction: true,
          functionType: 'cos',
          frequencyNumerator: 1,
          frequencyDenominator: 1,
          includesPi: true,
          phaseShiftNumerator: 0,
          phaseShiftDenominator: 1,
        ));
        

        // Add a list of new controllers
        controllers.add([
          TextEditingController(text: '1'),
          TextEditingController(text: '1'),
          TextEditingController(text: '1'),
          TextEditingController(text: '0'),
          TextEditingController(text: '1'),
        ]);

        // recalculate the Fourier series
        calculateFourierSeries();
      });
    }
  }

  // Remove a specific term via index
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
      // If there is only 1 term left, reset it to default values to prevent 0 terms
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

        );
        updateControllers(index);
      });
    }
    // Recalculate the Fourier series after removing a term
    calculateFourierSeries();
  }

  // Remove all terms and reset to default single term
  void removeAllTerms() {
    setState(() {
      // Dispose all existing controllers
      for (var controllerList in controllers) {
        for (var controller in controllerList) {
          controller.dispose();
        }
      }
      
      // Clear terms list
      terms.clear();
      controllers.clear();
      
      // Reset to preset 0 (default case)
      preset = 0;
      presetTerms(preset);
      calculateFourierSeries();
    });
  }

  @override
  void dispose() {
    // Dispose all controllers with null safety check
    try {
      if (controllers.isNotEmpty) {
        for (var controllerList in controllers) {
          for (var controller in controllerList) {
            controller.dispose();
          }
        }
      }
    } catch (e) {
      // Nothing
    }
    super.dispose();
  }

/// ***********************************************************************************************
/// Main Screen Build Method
/// This method builds the entire screen layout
/// Calls all the components to be displayed on the screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equation Solver'),
        backgroundColor: AppColours.primaryLight,
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
              const SizedBox(height: 16),
              _buildCheckPeriodicityCard(),
              const SizedBox(height: 16,),
              _buildFourierSeriesCard()
            ],
          ),
        )
      ),
    );
  }

/// ***********************************************************************************************
/// Problem Description Card that displays the problem statement
  Widget _buildProblemDescriptionCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColours.primaryLight),
      ),
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
            
            // Scrollable equation
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Math.tex(
                r'f(t)=' + getEquationLatex(),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              '1) Determine if the signal f(t) is periodic.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              '2) If so, find the Fourier series of f(t).',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
/// ***********************************************************************************************
/// Parameters Card that allows user to set parameters for the equation
/// Dynamically calls buildTermInputs() to create input fields for each term according to the number of terms
  Widget _buildParametersCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColours.primaryLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Set Parameters',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),

                // Row of Preset buttons
                Row(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            preset = index + 1;
                            presetTerms(preset);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: preset == index + 1 
                            ? AppColours.primaryLight 
                            : AppColours.greyLight,
                          foregroundColor: preset == index + 1 
                            ? AppColours.white 
                            : AppColours.black,
                          minimumSize: const Size(40, 40),
                        ),
                        child: Text('${index + 1}'),
                      ),
                    );
                  }),
                )
              ]
            ),
            const SizedBox(height: 10),

            // Divider line
            Container(
              height: 2,
              decoration: BoxDecoration(
                color: AppColours.primaryLight,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
            
            // List of term input rows
            ...List.generate(terms.length, (index) => _buildTermInputs(index)),
            
            const SizedBox(height: 5),
            
            // Add and Remove all term buttons
            Row(
              children: [
                // add term button 
                Expanded(
                  child: ElevatedButton(
                    // disabled if max terms reached
                    onPressed: terms.length < maxTerms ? addTerm : null, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: terms.length < maxTerms ? AppColours.secondary : AppColours.greyLight,
                      foregroundColor: AppColours.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    child: const Text('Add Term'),
                  ),
                ),
                
                const SizedBox(width: 10),
                // remove all terms button
                Expanded(
                  child: ElevatedButton(
                    // disabled if only one term left
                    onPressed: terms.length > 1 ? removeAllTerms : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: terms.length > 1 ? AppColours.error : AppColours.greyLight,
                      foregroundColor: AppColours.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    child: const Text('Remove All Terms'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
/// ***********************************************************************************************
/// Term input fields for the equation
/// Input for amplitude, function type (sin/cos), frequency, and phase shift
  Widget _buildTermInputs(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        // Title row with term number and remove button
        Row(
          children: [
            // Term number
            Text(
              'Term ${index + 1}:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            // Add remove button for this specific term
            if (terms.length > 1) // Only show button if there's more than one term
              ElevatedButton.icon(
                onPressed: () => removeTerm(index),
                icon: const Icon(Icons.close, size: 16),
                label: const Text('Remove', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColours.warning,
                  foregroundColor: AppColours.white,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: const Size(80, 32),
                ),
              ),
          ],
        ),
          
          const SizedBox(height: 8),
          
          // Amplitude row with function toggle
          Row(
            children: [
              // Amplitude input on the left

              const Text('Amplitude: ', style: TextStyle(fontSize: 16)),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: controllers[index][0],
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  decoration: const InputDecoration(
                    labelText: '-10 to 10',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    // Only positve and negative integers
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
                  ],
                  onChanged: (value) {
                    // Check if the value is empty or just a dash
                    if (value.isEmpty || value == "-") return;
                    
                    int? parsed = int.tryParse(value);
                    // Validation Check
                    if (parsed != null) {
                      // Check if amplitude is 0
                      if (parsed == 0) {
                        // If amplitude = 0, remove the term as 0 * anything = 0 and it is not valid
                        removeTerm(index);
                        return;
                      } 
                      // Check if amplitude is out of range [-10, 10]
                      // Clamp the value to the range [-10, 10]
                      else if (parsed > 10) {
                        parsed = 10; // Clamp to max 10
                        controllers[index][0].text = '10';
                        controllers[index][0].selection = TextSelection.fromPosition(
                          const TextPosition(offset: 2), // Move cursor position to end of "10"
                        );
                      } else if (parsed < -10) {
                        parsed = -10; // Clamp to min -10
                        controllers[index][0].text = '-10';
                        controllers[index][0].selection = TextSelection.fromPosition(
                          const TextPosition(offset: 3), // Move cursor Position to at end of "-10"
                        );
                      }
                      
                      // Update the amplitude value in the term
                      // and recalculate the Fourier series
                      setState(() {
                        terms[index].amplitude = parsed!;
                        calculateFourierSeries();
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
                    // toggle the hasTrigFunction property
                    // and calculate the Fourier series
                    setState(() {
                      terms[index].hasTrigFunction = !terms[index].hasTrigFunction;
                      calculateFourierSeries();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: terms[index].hasTrigFunction ? AppColours.primaryLight : AppColours.greyLight,
                    foregroundColor: terms[index].hasTrigFunction ? AppColours.white : AppColours.textPrimary,
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
                  child: Row(
                    children: [
                      // sin button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              terms[index].functionType = 'sin';
                              calculateFourierSeries();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: terms[index].functionType == 'sin' ? AppColours.primaryLight : AppColours.greyLight,
                            foregroundColor: terms[index].functionType == 'sin' ? AppColours.white : AppColours.textPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            
                          ),
                          child: const Text('sin'),
                        ),
                      ),

                      const SizedBox(width: 5),
                      
                      // cos button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              terms[index].functionType = 'cos';
                              calculateFourierSeries();

                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: terms[index].functionType == 'cos' ? AppColours.primaryLight : AppColours.greyLight,
                            foregroundColor: terms[index].functionType == 'cos' ? AppColours.white : AppColours.textPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('cos'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Toggle for frequency includes π
            Row(
              children: [
                const Text('Frequency includes π: ', style: TextStyle(fontSize: 16)),
                Spacer(),
                // Toggle Switch
                Switch(
                  value: terms[index].includesPi,
                  activeColor: AppColours.primary,
                  onChanged: (value) {
                    // Toggle the includesPi property
                    // and recalculate the Fourier series
                    setState(() {
                      terms[index].includesPi = value;
                      calculateFourierSeries();

                    });
                  },
                ),
              ],
            ),
            
            // Frequency row 
            Row(
              children: [
                const Text('Frequency: ', style: TextStyle(fontSize: 16)),
                
                const Spacer(),
                
                // Frequency numerator
                SizedBox(
                  width: 80,
                  height: 40,
                  child: TextField(
                    controller: controllers[index][1],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '1-200',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    ),
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      // only whole numbers
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      // Check if the value is empty
                      if (value.isEmpty) return;
                      
                      int? parsed = int.tryParse(value);

                      // Validation Check 
                      if (parsed != null) {
                        if (parsed == 0) {
                          // Reset both the numerator and denominator to defaults
                          // as 0 / n is not valid
                          setState(() {
                            terms[index].frequencyNumerator = 1;
                            terms[index].frequencyDenominator = 1;
                            controllers[index][1].text = '1';
                            controllers[index][2].text = '1';
                            calculateFourierSeries();
                          });
                          // check if the value is out of range [1, 200]
                        } else if (parsed > 200) {
                          parsed = 200; // Clamp to max 200 if value more than 200
                          controllers[index][1].text = '200';
                          controllers[index][1].selection = TextSelection.fromPosition(
                            const TextPosition(offset: 3), // Move cursor Position at end of "200"
                          );
                          // Update the frequency numerator
                          
                        } 
                        // update the frequency numerator, simplify the fraction and recalculate forier series
                        setState(() {
                          terms[index].frequencyNumerator = parsed!; //
                          terms[index].simplifyFraction();
                          calculateFourierSeries();
                        });
                        
                      }
                    },
                  ),
                ),
                
                // show π·t if includesPi is true, else just t
                Text(
                  terms[index].includesPi ? 'π·t / ' : '   t / ', 
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
                      labelText: '1-200',
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
                          // Reset both numerator and denominator to default values
                          // as n / 0 is invalid
                          setState(() {
                            terms[index].frequencyNumerator = 1;
                            terms[index].frequencyDenominator = 1;
                            controllers[index][1].text = '1';
                            controllers[index][2].text = '1';
                            calculateFourierSeries();
                          });
                          // check if the value is out of range [1, 200]
                        } else if (parsed > 200) {
                          parsed = 200; // Clamp to max 200
                          controllers[index][2].text = '200';
                          controllers[index][2].selection = TextSelection.fromPosition(
                            const TextPosition(offset: 3), // Move cursor Position to end of "200"
                          );
                          
                        } 
                        // update state values, simplify fraction and calculate fourier series
                        setState(() {
                          terms[index].frequencyDenominator = parsed!;
                          terms[index].simplifyFraction();
                          calculateFourierSeries();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
     
            Row(
              children: [
                const Text('Phase (in radians): ', style: TextStyle(fontSize: 16)),
                
                const Spacer(),
                
                // Phase Shift numerator
                SizedBox(
                  width: 80,
                  height: 40,
                  child: TextField(
                    controller: controllers[index][3],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '-360 - 360',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    ),
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')), // Allow negative numbers
                    ],
                    onChanged: (value) {
                      // check if value is empty
                      if (value.isEmpty || value == '-') return;
                      
                      // validation check
                      int? parsed = int.tryParse(value);
                      if (parsed != null) {
                        // check if value is within range [-360 to 360]
                        if (parsed.abs() > 360) {
                          // Clamp to -360 to 360 range
                          parsed = parsed.isNegative ? -360 : 360;
                          controllers[index][3].text = parsed.toString();
                          controllers[index][3].selection = TextSelection.fromPosition(
                            TextPosition(offset: parsed.toString().length),
                          );
                        }
                        
                        // update state variables
                        setState(() {
                          terms[index].phaseShiftNumerator = parsed!;
                          terms[index].simplifyFraction();
                          calculateFourierSeries();
                        });
                      }
                    },
                  ),
                ),
                
                const Text('  π / ', style: TextStyle(fontSize: 16)),
                
                // Phase denominator
                SizedBox(
                  width: 80,
                  height: 40,
                  child: TextField(
                    controller: controllers[index][4],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '1-180',
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
                          terms[index].simplifyFraction();
                          calculateFourierSeries();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),

          Container(
            height: 2,
            decoration: BoxDecoration(
              color: AppColours.primaryLight,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ],
      ),
    );
  }
/// ***********************************************************************************************
/// Visualises the signal using fl_chart and points calculated in equation_term.dart
  Widget _buildSignalVisualisationCard() {
    // Calculate combined signal points
    List<FlSpot> signalPoints = getCombinedSignalPoints(0, 2 * math.pi, 0.01, terms);
    
    // Initialise min and max y axis values to infinity
    double minY = double.infinity;
    double maxY = double.negativeInfinity;
    

    // change min and max y axis values depending on the highest y value
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
    
    
    // Ensure minimum range between y and -y is more than 4
    if (maxY - minY < 4) {
      double mid = (maxY + minY) / 2;
      minY = mid - 2;
      maxY = mid + 2;
    }
    
    // Signal Visualisation Card
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColours.primaryLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Signal Visualisation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Signal visualisation Graph
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
                          // label x axis values from 0 to 2 pi
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
                      color: AppColours.chartLine,
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

/// ***********************************************************************************************
/// Card that checks the periodicity of the signal
/// and displays the results
  Widget _buildCheckPeriodicityCard() {
    // Check for empty terms
    if (terms.isEmpty) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColours.primaryLight),
      ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Periodicity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Add terms to analyse periodicity.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    // Use the utility function to check periodicity
    Map<String, bool> periodicity = checkSignalPeriodicity(terms);
    bool hasFrequencyTerms = periodicity['hasFrequencyTerms']!;
    bool isSignalPeriodic = periodicity['isPeriodic']!;
    bool hasMixedTerms = periodicity['hasMixedTerms']!;
    bool allPiTerms = periodicity['allPiTerms']!;
    bool allNonPiTerms = periodicity['allNonPiTerms']!;
    
    // Calculate frequencies and periods for each term using the utility function
    List<Map<String, dynamic>> termAnalysis = analyseTermPeriodicity(terms);
    
    // If no frequency terms, signal is constant
    if (!hasFrequencyTerms) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColours.primaryLight),
      ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Periodicity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'The signal consists only of constant terms, so it is periodic with any period.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }
    
    // Calculate fundamental period and frequency
    Map<String, dynamic> fundamentalValues = calculateFundamentalPeriodicity(termAnalysis);
    int fundPeriodNum = fundamentalValues['fundPeriodNum'];
    int fundPeriodDenom = fundamentalValues['fundPeriodDenom'];
    int fundFreqNum = fundamentalValues['fundFreqNum'];
    int fundFreqDenom = fundamentalValues['fundFreqDenom'];
    
    // Build the explanation card
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColours.primaryLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Periodicity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Explanation of periodicity
            const Text(
              'A signal is periodic if the LCM of the periods of each term can be calulated.',
              style: TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Calculate the angular frequency and period of each term
            const Text(
              'Step 1: Find the angular frequency and period of each term:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            // List each term's periodicity
            ...List.generate(terms.length, (index) {
              var term = terms[index];
              var analysis = termAnalysis[index];
              
              if (!term.hasTrigFunction) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    'Term ${index + 1}: Constant term (no frequency)',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
              
              if (analysis['hasFrequency'] != true) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    'Term ${index + 1}: Invalid frequency',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
              
              // Build the correct frequency string based on whether it includes π or not
              String freqFormula;
              String periodFormula;
              if (term.includesPi) {
                // Include π in the formula (place π next to numerator)
                freqFormula = r'\omega_{' + (index + 1).toString() + r'} = \frac{' + 
                              analysis['freqNumerator'].toString() + r'\pi}{' + 
                              analysis['freqDenominator'].toString() + r'} \text{ rad/s}';
                
                periodFormula = r'T_{' + (index + 1).toString() + r'} = \frac{' + 
                                analysis['periodNumerator'].toString() + r'}{' + 
                                analysis['periodDenominator'].toString() + r'}';
              } else {
                // Regular frequency without π
                freqFormula = r'\omega_{' + (index + 1).toString() + r'} = \frac{' + 
                              analysis['freqNumerator'].toString() + r'}{' + 
                              analysis['freqDenominator'].toString() + r'} \text{ rad/s}';
                
                periodFormula = r'T_{' + (index + 1).toString() + r'} = \frac{' + 
                                analysis['periodNumerator'].toString() + r'\pi}{' + 
                                analysis['periodDenominator'].toString() + r'}';
              }
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        'Term ${index + 1}: ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Math.tex(
                        freqFormula + ', ' + periodFormula,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            }),
            
            const SizedBox(height: 16),
            
            if (hasMixedTerms) ...[
              const Text(
                'Step 2: Find the fundamental period and frequency:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'The LCM of the periods cannot be calculated as the signal contains both terms with and without π.',
                style: TextStyle(fontSize: 16),
              ),
            ] else ...[
              const Text(
                'Step 2: Find the fundamental period and frequency:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  formatPeriodLatex(allNonPiTerms, fundPeriodNum, fundPeriodDenom),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  formatFrequencyLatex(allPiTerms, fundFreqNum, fundFreqDenom),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            
            // Conclusion
            Text(
              isSignalPeriodic 
                  ? 'The signal IS periodic as the LCM exists.'
                  : 'The signal is NOT periodic.',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      )
    );
  }

//***************************************************************************** */
// Card that computes the Fourier series
// and displays the steps
  Widget _buildFourierSeriesCard() {
    // Use the utility function to check periodicity
    Map<String, bool> periodicity = checkSignalPeriodicity(terms);
    bool isSignalPeriodic = periodicity['isPeriodic']!;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColours.primaryLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fourier Series Computation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // If signal is not periodic, show message
            if (!isSignalPeriodic)
              const Text(
                'The Fourier series cannot be computed as the signal is not periodic.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              )
            // If signal is periodic, show the step navigation and content
            else ...[
              // Step navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentFourierStep = index + 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: currentFourierStep == index + 1 
                          ? AppColours.primaryLight 
                          : AppColours.greyLight,
                        foregroundColor: currentFourierStep == index + 1 
                          ? AppColours.white 
                          : AppColours.black,
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
          ],
        ),
      ),
    );
  }
//***************************************************************************** */
// Build the content for each step of the Fourier series computation
// This function returns a widget based on the current step
  Widget _buildStepContent() {
    switch (currentFourierStep) {
      case 1:
        return _buildStep1Content();
      case 2:
        return _buildStep2Content();
      case 3:
        return _buildStep3Content();
      default:
        return _buildStep1Content();
    }
  }
//***************************************************************************** */
// Step1: Compute a₀ 
  Widget _buildStep1Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 1: Calculate a₀',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Math.tex(
          r'a_0 = \int_{0}^{T} f(t) dt',
          textStyle: TextStyle(fontSize: 18), 
        ),
         const SizedBox(height: 10),
        Math.tex(
          r'a_0 = \text{Sum of Constant Terms}',
          textStyle: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Math.tex(
          r'a_0 = ' + a0.toString(),
          textStyle: TextStyle(fontSize: 18),
        ),
         const SizedBox(height: 5),
      ],
    );
  }
  //***************************************************************************** */
  Widget _buildStep2Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 2: Calculate Fourier Coefficients',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        
        // Formula reminders
        Math.tex(
          r'a_n = \frac{2}{T_0}\int_{0}^{T_0} f(t) \cos{(n\omega_0 t)}dt',
          textStyle: const TextStyle(fontSize: 18), 
        ),
        const SizedBox(height: 8),
        Math.tex(
          r'b_n = \frac{2}{T_0}\int_{0}^{T_0} f(t) \sin{(n\omega_0 t)}dt',
          textStyle: const TextStyle(fontSize: 18), 
        ),
        const SizedBox(height: 16),
        
        // Explanation of trigonometric identities
        const Text(
          'Using trigonometric identities:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Math.tex(
          r'\cos(n\omega_0 t + \phi) = \cos(n\omega_0 t)\cos(\phi) - \sin(n\omega_0 t)\sin(\phi)',
          textStyle: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Math.tex(
          r'\sin(n\omega_0 t + \phi) = \sin(n\omega_0 t)\cos(\phi) + \cos(n\omega_0 t)\sin(\phi)',
          textStyle: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        
        // Show coefficients
        if (harmonics.isEmpty)
          const Text(
            'No Fourier coefficients found in this signal.',
            style: TextStyle(fontSize: 16),
          )
        else
          ...harmonics.map((harmonic) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show an coefficient if it exists and is not very close to zero
                if (anCoefficients.containsKey(harmonic))
                  Math.tex(
                    'a_{$harmonic} = ${anCoefficients[harmonic]!.toStringAsFixed(2)}',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  
                // Show bn coefficient if it exists and is not very close to zero
                if (bnCoefficients.containsKey(harmonic))
                  Math.tex(
                    'b_{$harmonic} = ${bnCoefficients[harmonic]!.toStringAsFixed(2)}',
                    textStyle: const TextStyle(fontSize: 18),
                  ),
              ],
            ),
          )),
        
        const SizedBox(height: 16),
      ],
    );
  }
  
  Widget _buildStep3Content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 3: Complete Fourier Series',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        
        // General formula for Trigonometric Form
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColours.greyLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'General Formula:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Math.tex(
                  r'f(t) = a_0 + \sum_{n=1}^{\infty} \left( a_n\cos(n\omega_0 t) + b_n\sin(n\omega_0 t) \right)',
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              
            ],
          ),
        ),
        
        const SizedBox(height: 20),
    
        
        if (harmonics.isEmpty && a0 == 0)
          const Text(
            'No Fourier coefficients found in this signal.',
            style: TextStyle(fontSize: 16),
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Math.tex(
              formatFourierSeriesLatex(a0, anCoefficients, bnCoefficients),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),

        const SizedBox(height: 10),
                  
        if (harmonics.isEmpty && a0 == 0)
          const Text(
            '',
            style: TextStyle(fontSize: 16),
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Math.tex(
              formatFourierSeriesWithOmega0(a0, anCoefficients, bnCoefficients, fundamentalValues),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
      ],
    );
  }
}
