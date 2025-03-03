import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class ParameterInput extends StatefulWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String Function(double) formatLabel;
  final Function(double) onChanged;
  final int decimalPlaces;

  const ParameterInput({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    required this.formatLabel,
    required this.onChanged,
    this.decimalPlaces = 1,
  });

  @override
  State<ParameterInput> createState() => _ParameterInputState();
}

class _ParameterInputState extends State<ParameterInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _updateTextController();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _isEditing) {
      _applyTextValue();
    }
  }

  void _applyTextValue() {
    double? newValue = double.tryParse(_controller.text);
    if (newValue != null) {
      newValue = newValue.clamp(widget.min, widget.max);
      widget.onChanged(newValue); 
      _controller.text = newValue.toStringAsFixed(widget.decimalPlaces);
    } else {
      _updateTextController();
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  void didUpdateWidget(ParameterInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && !_isEditing) {
      _updateTextController();
    }
  }

  void _updateTextController() {
    _controller.text = widget.value.toStringAsFixed(widget.decimalPlaces);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          widget.label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        
        Row(
          children: [
            // Slider
            Expanded(
              flex: 7,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.blue,
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Colors.blueAccent,
                  overlayColor: Colors.blue.withAlpha(51), 
                  trackHeight: 8.0,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 6.0),
                  activeTickMarkColor: Colors.blueAccent,
                  inactiveTickMarkColor: Colors.grey,
                  showValueIndicator: ShowValueIndicator.always,
                ),
                child: Slider(
                  value: widget.value,
                  min: widget.min,
                  max: widget.max,
                  divisions: widget.divisions,
                  label: widget.formatLabel(widget.value),
                  onChanged: (value) {
                    widget.onChanged(value);
                  },
                ),
              ),
            ),
            
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.check, size: 16),
                            onPressed: () {
                              _applyTextValue();
                              _focusNode.unfocus();
                            },
                          ),
                          isDense: true,
                        ),
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            if (newValue.text.isEmpty) {
                              return newValue;
                            }

                            double? value = double.tryParse(newValue.text);
                            if (value == null) {
                              return oldValue;
                            }
                            
                            if (value > widget.max) {
                              return TextEditingValue(
                                text: widget.max.toStringAsFixed(widget.decimalPlaces),
                                selection: TextSelection.collapsed(offset: widget.max.toStringAsFixed(widget.decimalPlaces).length),
                              );
                            }
                            
                            if (value < widget.min) {
                              return TextEditingValue(
                                text: widget.min.toStringAsFixed(widget.decimalPlaces),
                                selection: TextSelection.collapsed(offset: widget.min.toStringAsFixed(widget.decimalPlaces).length),
                              );
                            }
                            
                            return newValue;
                          }),
                        ],
                        onChanged: (text) {
                          setState(() {
                            _isEditing = true;
                          });
                        },
                        onEditingComplete: () {
                          _applyTextValue();
                          _focusNode.unfocus();
                        },
                        onSubmitted: (text) {
                          _applyTextValue();
                        },
                        onTap: () {
                          setState(() {
                            _isEditing = true;
                            _controller.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: _controller.text.length,
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ParameterInputs extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width > 600 
              ? (MediaQuery.of(context).size.width - 48) / 2 
              : MediaQuery.of(context).size.width - 32,
          child: ParameterInput(
            label: 'Number of Terms',
            value: terms.toDouble(),
            min: 1,
            max: 20,
            divisions: 19,
            formatLabel: (value) => value.toInt().toString(),
            onChanged: (value) => onTermsChanged(value.toInt()),
            decimalPlaces: 0,
          ),
        ),
        
        // Frequency input
        SizedBox(
          width: MediaQuery.of(context).size.width > 600 
              ? (MediaQuery.of(context).size.width - 48) / 2 
              : MediaQuery.of(context).size.width - 32,
          child: ParameterInput(
            label: 'Frequency',
            value: frequency,
            min: 0.1,
            max: 3.0,
            divisions: 29,
            formatLabel: (value) => value.toStringAsFixed(1),
            onChanged: onFrequencyChanged,
          ),
        ),
        
        // Amplitude input
        SizedBox(
          width: MediaQuery.of(context).size.width > 600 
              ? (MediaQuery.of(context).size.width - 48) / 2 
              : MediaQuery.of(context).size.width - 32,
          child: ParameterInput(
            label: 'Amplitude',
            value: amplitude,
            min: 0.1,
            max: 2.0,
            divisions: 19,
            formatLabel: (value) => value.toStringAsFixed(1),
            onChanged: onAmplitudeChanged,
          ),
        ),
        
        // Phase shift input
        SizedBox(
          width: MediaQuery.of(context).size.width > 600 
              ? (MediaQuery.of(context).size.width - 48) / 2 
              : MediaQuery.of(context).size.width - 32,
          child: ParameterInput(
            label: 'Phase Shift',
            value: phaseShift,
            min: 0,
            max: 2 * pi,
            divisions: 20,
            formatLabel: (value) => '${(value / pi).toStringAsFixed(2)}π',
            onChanged: onPhaseShiftChanged,
          ),
        ),
      ],
    );
  }
}

class ParameterInputsScreen extends StatelessWidget {
  final Widget child;

  const ParameterInputsScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}