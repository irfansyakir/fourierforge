// This enum is used to define the 3 type of waves (square, sawtooth and triangle) 
// in the WaveModel class
enum WaveType { square, sawtooth, triangle }

class WaveModel {
  /// This class represents a wave model with properties such as type, number of terms, frequency, amplitude, and phase shift.
  WaveType type;
  int terms;
  double frequency;
  double amplitude;
  double phaseShift;

  WaveModel({
    required this.type,
    required this.terms,
    required this.frequency,
    required this.amplitude,
    required this.phaseShift,
  });

}