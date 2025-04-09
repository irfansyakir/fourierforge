import 'package:flutter/material.dart';
import '../routes/routes.dart';
import '../themes/colours.dart';

/// HomeScreen is the main screen of the app.
/// It contains the app name, slogan, and a grid of feature cards.
/// Each card represents a feature of the app and navigates to the respective screen when tapped.

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // App Name
              const Text(
                'Fourier Forge',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColours.titleText,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              // App Slogan
              const Text(
                'Forge your understanding of Fourier Series!',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColours.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              // Title Underline
              Container(
                width: 100,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColours.titleUnderline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 30),

              // Grid of Feature Cards
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                  children: [
                    // Wave Visualisation Card
                    _buildFeatureCard(
                      context,
                      'Waves Visualisation',
                      Icons.ssid_chart,
                      () => Navigator.pushNamed(context, AppRoutes.waveVisualisation),
                    ),
                    
                    // Problem Solver Card
                    _buildFeatureCard(
                      context,
                      'Problem Solver',
                      Icons.science_outlined,
                      () => Navigator.pushNamed(context, AppRoutes.interactiveProblemSolver),
                    ),
                    
                    // Sample Solutions Card
                    _buildFeatureCard(
                      context,
                      'Sample Solutions',
                      Icons.tungsten_outlined,
                      () => Navigator.pushNamed(context, AppRoutes.sampleSolutionScreen),
                    ),
                    
                    // Cheat Sheet Card
                    _buildFeatureCard(
                      context,
                      'Cheat Sheet',
                      Icons.sticky_note_2_outlined,
                      () => Navigator.pushNamed(context, AppRoutes.cheatSheet),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Widget to build each feature card
  // This widget is reusable for each feature
  // It takes the context, title, icon, and onTap function as parameters
  // to create a card with an icon and title
  // that navigates to the respective screen when tapped
  Widget _buildFeatureCard(
    BuildContext context, 
    String title, 
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColours.primaryLight),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColours.iconCirle,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: AppColours.white,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColours.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}