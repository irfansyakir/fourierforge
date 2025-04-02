// This enum is used to define the 3 type of waves (square, sawtooth and triangle) 
// in the WaveModel class
enum WaveType { square, sawtooth, triangle }

class WaveModel {
  /// This class represents a wave model with properties such as type, number of terms, frequency, amplitude, and phase shift.
  final WaveType type;
  final int terms;
  final double frequency;
  final double amplitude;
  final double phaseShift;

  WaveModel({
    required this.type,
    required this.terms,
    required this.frequency,
    required this.amplitude,
    required this.phaseShift,
  });
  
  /// This method creates a copy of the current wave model with updated properties.
  WaveModel copyWith({
    WaveType? type,
    int? terms,
    double? frequency,
    double? amplitude,
    double? phaseShift,
  }) {
    return WaveModel(
      type: type ?? this.type,
      terms: terms ?? this.terms,
      frequency: frequency ?? this.frequency,
      amplitude: amplitude ?? this.amplitude,
      phaseShift: phaseShift ?? this.phaseShift,
    );
  }
}