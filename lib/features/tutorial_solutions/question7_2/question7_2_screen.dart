import 'package:flutter/material.dart';

// Import the separate card components
import 'question_card.dart';
import 'solution_card.dart';

class Question702Screen extends StatefulWidget {
  const Question702Screen({super.key});

  @override
  Question702ScreenState createState() => Question702ScreenState();
}

class Question702ScreenState extends State<Question702Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Q7.2: Periodic Rectangular Signal'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question card
            const QuestionCard(),
                
            const SizedBox(height: 16),
            
            // Solution card (always shown)
            const SolutionCard(),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}