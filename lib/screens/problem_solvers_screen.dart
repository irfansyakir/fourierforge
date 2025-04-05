import 'package:flutter/material.dart';
import '../routes/routes.dart';

class ProblemsScreen extends StatelessWidget {
  const ProblemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Header section
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
         
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Problem Solver',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'These problems are based on questions from tutorial questions, quizzes and Past Year Papers.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        // Problem Card for Rectifier Problem
        _buildProblemCard(
          context,
          'Rectifier Problem',
          'Compute the Fourier series coefficients for a full and half wave rectifier circuits.',
          () => Navigator.pushNamed(context, AppRoutes.rectifierProblem),
        ),

        // Problem Card for Equation Problem
        _buildProblemCard(
          context,
          'Equations Problem',
          'Compute the Fourier Series coefficients for the given equations.',
          () => Navigator.pushNamed(context, AppRoutes.equationProblem),
        ),
      ],
    );
  }
  
  // Widget to build each problem card
  // This widget is reusable for each question
  Widget _buildProblemCard(
    BuildContext context, 
    String title, // Name of Question
    String subtitle, // Details of Question
    VoidCallback onTap, // Function to navigate to the question screen
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
              // Right side - Problem title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name of Question
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Question Details
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
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