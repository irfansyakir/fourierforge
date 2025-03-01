import 'package:flutter/material.dart';
import 'routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FourierForge',
      initialRoute: AppRoutes.home, // Default route
      onGenerateRoute: AppRoutes.generateRoute, // Use centralized routes
    );
  }
}
