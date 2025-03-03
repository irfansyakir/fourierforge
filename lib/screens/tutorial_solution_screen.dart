import 'package:flutter/material.dart';
import '../features/tutorial_solutions/question8_1/question8_1_screen.dart';
import '../features/tutorial_solutions/question8_2/question8_2_screen.dart';

class TutorialSolutionScreen extends StatelessWidget {
  const TutorialSolutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial Solutions'),
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
                  'Tutorial Questions',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tap on a question to see its detailed solution.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Question 8.1 Card
          _buildQuestionCard(
            context,
            '8.1',
            'Full-Wave Rectifier Fourier Series',
            'Find the trigonometric Fourier series representation of a rectified sinusoidal signal',
            Icons.signal_cellular_alt,
            () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const Question801Screen())
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Question 8.2 Card
          _buildQuestionCard(
            context,
            '8.2',
            'Question title',
            'Question Subtitle',
            Icons.signal_cellular_alt,
            () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const Question802Screen())
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
    IconData icon,
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
              // Right side - Question title and subtitle
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
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(icon, size: 16, color: Colors.indigo),
                        const SizedBox(width: 4),
                        const Text(
                          'Tap to view solution',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Arrow icon
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}