import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../features/wave_visualisation/wave_model.dart';
import '../features/wave_visualisation/wave_calculator.dart';
import '../features/wave_visualisation/wave_type_dropdown.dart';
import '../features/wave_visualisation/wave_graph.dart';
import '../features/wave_visualisation/parameters_input.dart';
import '../features/wave_visualisation/formula_display.dart';

/// This screen visualizes Fourier waves 
class WaveVisualisationScreen extends StatefulWidget {
  const WaveVisualisationScreen({super.key});

  @override
  WaveVisualisationScreenState createState() => WaveVisualisationScreenState();
}

class WaveVisualisationScreenState extends State<WaveVisualisationScreen> {
  /// The model that contains the properties of the wave
  /// such as type, frequency, amplitude, and phase shift.
  /// The model is used to calculate the points for the wave
  /// and to update the graph when the properties change.
  
  late WaveModel waveModel;
  
  List<FlSpot> points = [];

  @override
  void initState() {
    super.initState();
    // Initialize the wave model with default values
    // The default values are
    waveModel = WaveModel(
      type: WaveType.square,
      terms: 1,
      frequency: 1.0,
      amplitude: 1.0,
      phaseShift: 0.0,
    );
    
    updateGraph();
  }

  // This function updates the graph by recalculating the points
  // based on the current properties of the wave model.
  void updateGraph() {
    setState(() {
      points = WaveCalculator.calculateWave(waveModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fourier Waves Visualization'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              
              // Display the graph of the wave
              WaveGraph(
                points: points,
              ),
              const SizedBox(height: 16),

              // Display the fourier series representation for the wave
              // and the general formula for the wave
              FormulaDisplay(waveModel: waveModel),
              const SizedBox(height: 16),

              // Dropdown to select the type of wave
              // The selected type is passed to the WaveModel
              // and the graph is updated accordingly.
              WaveTypeDropdown(
                selectedType: waveModel.type,
                onTypeChanged: (WaveType type) {
                  setState(() {
                    waveModel = waveModel.copyWith(type: type);
                    updateGraph();
                  });
                },
              ),
              const SizedBox(height: 16),
              
              // Input fields to change the properties of the wave
              // such as frequency, amplitude, phase shift, and number of terms
              ParameterInputs(
                terms: waveModel.terms,
                frequency: waveModel.frequency,
                amplitude: waveModel.amplitude,
                phaseShift: waveModel.phaseShift,
                onTermsChanged: (int value) {
                  setState(() {
                    waveModel = waveModel.copyWith(terms: value);
                    updateGraph();
                  });
                },
                onFrequencyChanged: (double value) {
                  setState(() {
                    waveModel = waveModel.copyWith(frequency: value);
                    updateGraph();
                  });
                },
                onAmplitudeChanged: (double value) {
                  setState(() {
                    waveModel = waveModel.copyWith(amplitude: value);
                    updateGraph();
                  });
                },
                onPhaseShiftChanged: (double value) {
                  setState(() {
                    waveModel = waveModel.copyWith(phaseShift: value);
                    updateGraph();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}