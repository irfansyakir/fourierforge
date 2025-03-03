import 'package:flutter/material.dart';
import '../models/wave_model.dart';

class WaveTypeDropdown extends StatelessWidget {
  final WaveType selectedType;
  final Function(WaveType) onTypeChanged;

  const WaveTypeDropdown({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wave Type:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<WaveType>(
                value: selectedType,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.blue, fontSize: 16),
                onChanged: (WaveType? newValue) {
                  if (newValue != null) {
                    onTypeChanged(newValue);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: WaveType.square,
                    child: Text('Square Wave'),
                  ),
                  DropdownMenuItem(
                    value: WaveType.sawtooth,
                    child: Text('Sawtooth Wave'),
                  ),
                  DropdownMenuItem(
                    value: WaveType.triangle,
                    child: Text('Triangle Wave'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}