enum WaveType { square, sawtooth, triangle }

class WaveModel {
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

  // Create a copy with updated values
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