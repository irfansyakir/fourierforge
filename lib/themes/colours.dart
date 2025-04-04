import 'package:flutter/material.dart';

class AppColours {
  // Primary colors
  static const Color primary = Colors.indigo;
  static const Color primaryDark = Color(0xFF303F9F); // indigo[700]
  static const Color primaryLight = Color(0xFF7986CB); // indigo[300]
  
  // Accent/secondary colors
  static const Color secondary = Colors.blue;
  static const Color secondaryDark = Color(0xFF1565C0); // blue[800]
  static const Color secondaryLight = Color(0xFF64B5F6); // blue[300]
  
  // Success, warning, error states
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
  static const Color error = Colors.red;
  
  // Greyscale
  static const Color grey = Colors.grey;
  static const Color greyLight = Color(0xFFE0E0E0); // grey[300]
  static const Color greyDark = Color(0xFF757575); // grey[600]
  
  // Black and white variants
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  
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
  static const Color chartLine = Colors.blue;
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