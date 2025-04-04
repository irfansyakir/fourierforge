import 'package:flutter/material.dart';
import '../features/sample_solutions/question8_1/question8_1_screen.dart';
import '../features/sample_solutions/2122S1/question3_screen.dart';
import '../themes/colours.dart';

class SampleSolutionScreen extends StatelessWidget {
  const SampleSolutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Solutions'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sample Questions',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sample questions and solutions from the course IE2110 Signals and Systems.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Question 8.1 Card
          _buildQuestionCard(
            context,
            'Tutorial 8.1',
            'Full-Wave Rectifier Fourier Series',
            'Find the trigonometric Fourier series representation of a rectified sinusoidal signal.',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Question801Screen()),
            ),
          ),

          _buildQuestionCard(
            context,
            'PYP 21/22 Semester 1',
            'Question 3',
            'Determine the Fourier series coefficients of a given equation.',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AY2122S1Question3Screen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(
    BuildContext context,
    String questionNumber,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      questionNumber,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColours.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColours.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}