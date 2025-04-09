import 'package:flutter/material.dart';
import 'dart:math';
import '../../themes/colours.dart';

// This file has 2 widgets: 
// ParameterInputs: A StatelessWidget that calls the ParameterInput widget for each parameter.
// ParameterInput: A StatefulWidget that displays a slider and a text field for a parameter.

// Front End
class ParameterInputs extends StatefulWidget {
  /// This widget displays the inputs for the parameters of the wave
  /// It includes the number of terms, frequency, amplitude, and phase shift
  /// Each parameter has a slider and a text field for input
  /// The slider allows the user to select a value within a range
  final int terms;
  final double frequency;
  final double amplitude;
  final double phaseShift;
  final Function(int) onTermsChanged;
  final Function(double) onFrequencyChanged;
  final Function(double) onAmplitudeChanged;
  final Function(double) onPhaseShiftChanged;

  const ParameterInputs({
    super.key,
    required this.terms,
    required this.frequency,
    required this.amplitude,
    required this.phaseShift,
    required this.onTermsChanged,
    required this.onFrequencyChanged,
    required this.onAmplitudeChanged,
    required this.onPhaseShiftChanged,
  });

  @override
  State<ParameterInputs> createState() => _ParameterInputsState();
}

class _ParameterInputsState extends State<ParameterInputs> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      // 4 ParameterInput widgets for Number of terms, Frequency, Amplitude, and Phase Shift
      children: [
        // Number of terms input
        _parameterInputRow(
          'Number of Terms',
          widget.terms.toDouble(),
          1,
          20,
          19,
          (value) => value.toInt().toString(),
          (value) => widget.onTermsChanged(value.toInt()),
          0,
        ),
        // Frequency input
        _parameterInputRow(
          'Frequency',
          widget.frequency,
          0.1,
          3.0,
          29,
          (value) => value.toStringAsFixed(1),
          (value) => widget.onFrequencyChanged(value),
          1,
        ),
         
        // Amplitude input
        _parameterInputRow(
          'Amplitude',
          widget.amplitude,
          0.1,
          2.0,
          19,
          (value) => value.toStringAsFixed(1),
          (value) => widget.onAmplitudeChanged(value),
          1,
        ),

        // Phase shift input
        _parameterInputRow(
          'Phase Shift',
          widget.phaseShift,
          0,
          2 * pi,
          20,
          (value) => '${(value / pi).toStringAsFixed(2)}π',
          (value) => widget.onPhaseShiftChanged(value),
          2,
        ),


      
      ],
    );
  }
  // This function creates a row with a label, a slider and the value of the parameter
  Widget _parameterInputRow(
    String label,   
    double value,        
    double min,        
    double max,         
    int? divisions,     
    String Function(double) formatLabel,
    Function(double) onChanged,        
    int decimalPlaces,

  ) {
     return SizedBox(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label for the parameter
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          
          
          Row(
            children: [
              // Slider for the parameter
              Expanded(
                flex: 8,
                // Slider theme to customize the appearance of the slider
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColours.primary,
                    inactiveTrackColor: AppColours.greyLight,
                    thumbColor: AppColours.primary,
                    overlayColor: AppColours.primary, 
                    trackHeight: 8.0,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 6.0),
                    activeTickMarkColor: Colors.blueAccent,
                    inactiveTickMarkColor: Colors.grey,
                    showValueIndicator: ShowValueIndicator.always,
                  ),
                  // Slider widget to select a value
                  child: Slider(
                    value: value,
                    min: min,
                    max: max,
                    divisions: divisions,
                    label: formatLabel(value),
                    onChanged: (value) {
                      onChanged(value);
                    },
                  ),
                ),
              ),
       
              Flexible(
                child: Text(
                  label.contains('Phase Shift')
                      ? '${(value / pi).toStringAsFixed(2)}π'
                      : value.toStringAsFixed(decimalPlaces),
                ),
              )
            ],
          ),
        ],
      ),
     );
  }
}

