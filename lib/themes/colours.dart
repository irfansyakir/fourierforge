import 'package:flutter/material.dart';

class AppColours {
  // Black and white variants
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  
  // Material color variants
  static const Color primary = Color(0xFF3F51B5); // indigo
  static const Color primaryLight = Color(0xFF7986CB); // indigo[300]
  static const Color primaryDark = Color(0xFF303F9F); // indigo[700]
  static const Color secondary = Color(0xFF2196F3); // blue
  static const Color secondaryLight = Color(0xFF90CAF9); // blue[200]
  
  // Status colors
  static const Color success = Color(0xFF4CAF50); // green
  static const Color warning = Color(0xFFFFC107); // amber
  static const Color error = Color(0xFFF44336); // red
  
  // Gray shades
  static const Color grey = Color(0xFF9E9E9E); // grey
  static const Color greyLight = Color(0xFFE0E0E0); // grey[300]
  
  // Background colors
  static const Color background = Colors.white;
  static const Color cardBackground = Colors.white;
  
  // Text colors
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color textDisabled = Colors.black38;
  
  // Special purpose colors
  static const Color gridLine = Color(0xFFBDBDBD); // grey[400]
  static const Color divider = Color(0xFFBDBDBD); // grey[400]
  
  // Chart/Graph colors
  static const Color chartLine = AppColours.primary;
  static const Color chartGrid = Color(0xFFEEEEEE);
  static const Color chartPoint = Colors.black;
  static const Color chartBar = Colors.blue;
  
  // Signal colors
  static const Color originalSignal = Colors.blue;
  static const Color transformedSignal = Colors.orange;
  static const Color magnitudeSpectrum = Colors.blue;
  static const Color phaseSpectrum = Colors.red;
  
  // Title colors
  static const Color titleText = Color(0xFF303F9F); // indigo[700], same as primaryDark
  static const Color titleUnderline = Color(0xFF5C6BC0); // indigo[400]
  static const Color iconCirle = Color(0xFFC5CAE9); // indigo[100]
}