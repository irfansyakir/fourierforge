import 'package:flutter/material.dart';

class CustomCoefficientEditor extends StatelessWidget {
  final List<double> coefficients;
  final Function(int, double) onCoefficientChanged;
  
  const CustomCoefficientEditor({
    super.key,
    required this.coefficients,
    required this.onCoefficientChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Custom Coefficients:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: coefficients.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 80,
                child: Column(
                  children: [
                    Text(index == 0 ? 'DC' : 'sin(${index}t)'),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      width: 60,
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.purple,
                            inactiveTrackColor: Colors.grey[300],
                            thumbColor: Colors.purpleAccent,
                            trackHeight: 6.0,
                            showValueIndicator: ShowValueIndicator.always,
                          ),
                          child: Slider(
                            value: coefficients[index],
                            min: -1.0,
                            max: 1.0,
                            divisions: 20,
                            label: coefficients[index].toStringAsFixed(1),
                            onChanged: (value) => onCoefficientChanged(index, value),
                          ),
                        ),
                      ),
                    ),
                    Text(coefficients[index].toStringAsFixed(1)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}