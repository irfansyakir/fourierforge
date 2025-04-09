import 'package:flutter/material.dart';
import 'package:fourier_forge/features/problem_solvers/equations/equation_problem_screen.dart';
import 'package:fourier_forge/features/problem_solvers/rectifier/rectifier_problem_screen.dart';
import 'package:fourier_forge/themes/colours.dart';

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
                'These problems are based on questions from tutorial questions, quizzes and Past Year Papers from the course IE2110 Signals and Systems.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20), // Increased spacing

        // Problem Card for Rectifier Problem
        _buildProblemCard(
          context,
          'Rectifier Problem',
          'Compute the Fourier series coefficients for a full and half wave rectifier circuits.',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RectifierProblemScreen()),
          ),
          //() => Navigator.pushNamed(context, AppRoutes.rectifierProblem),
          Icons.waves,
        ),

        const SizedBox(height: 16), // Spacing between cards

        // Problem Card for Equation Problem
        _buildProblemCard(
          context,
          'Equations Problem',
          'Compute the Fourier Series coefficients for the given equations.',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EquationProblemScreen()),
          ),
          Icons.functions,
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
    IconData icon, // Icon to represent the problem type
  ) {
    return Card(
      elevation: 6, // Increased elevation for more prominence
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColours.primaryLight),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(24.0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Icon for the problem type
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColours.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Title
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              // Action row at the bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}