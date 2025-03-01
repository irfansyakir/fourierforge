import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../features/wave_visualisation/models/wave_model.dart';
import '../features/wave_visualisation/utils/wave_calculator.dart';
import '../features/wave_visualisation/widgets/wave_type_selector.dart';
import '../features/wave_visualisation/widgets/wave_graph.dart';
import '../features/wave_visualisation/widgets/parameters_input.dart';
import '../features/wave_visualisation/widgets/formula_display.dart';

class WaveVisualisationScreen extends StatefulWidget {
  const WaveVisualisationScreen({super.key});

  @override
  WaveVisualisationScreenState createState() => WaveVisualisationScreenState();
}

class WaveVisualisationScreenState extends State<WaveVisualisationScreen> {
  // Wave model containing all wave parameters
  late WaveModel waveModel;
  
  // Data points for the graph
  List<FlSpot> points = [];

  @override
  void initState() {
    super.initState();
    // Initialize wave model with default values
    waveModel = WaveModel(
      type: WaveType.square,
      terms: 1,
      frequency: 1.0,
      amplitude: 1.0,
      phaseShift: 0.0,
    );
    
    // Calculate initial points
    updateGraph();
  }

  // Updates the graph data based on the current wave model
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
              // Wave type selector
              WaveTypeSelector(
                selectedType: waveModel.type,
                onTypeChanged: (WaveType type) {
                  setState(() {
                    waveModel = waveModel.copyWith(type: type);
                    updateGraph();
                  });
                },
              ),
              const SizedBox(height: 16),
              
              // Graph visualization
              WaveGraph(
                points: points,
              ),
              const SizedBox(height: 16),
              
              // Formula display (above the sliders)
              FormulaDisplay(waveModel: waveModel),
              
              const SizedBox(height: 16),
              
              // Parameter inputs (sliders + text input)
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