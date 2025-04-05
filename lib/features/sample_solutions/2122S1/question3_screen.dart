import 'package:flutter/material.dart';
import 'question3a_card.dart';
import 'question3a_solution.dart';
import 'question3b_card.dart';
import 'question3b_solution.dart';

class AY2122S1Question3Screen extends StatefulWidget {
  const AY2122S1Question3Screen({super.key});

  @override
  AY2122S1Question3ScreenState createState() => AY2122S1Question3ScreenState();
}

class AY2122S1Question3ScreenState extends State<AY2122S1Question3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Q3(a): Fourier Series'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question card
            Question3ACard(),

            const SizedBox(height: 16),

            Question3ASolutionCard(),

            const SizedBox(height: 16),

            Question3BCard(),

            const SizedBox(height: 16),

            Question3BSolutionCard(),
          ],
        ),
      ),
    );
  }
}