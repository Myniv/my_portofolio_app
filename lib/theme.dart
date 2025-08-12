import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Example: Dynamic font scaling
    double headingSize = screenWidth > 600 ? 26 : 20;
    double bodySize = screenWidth > 600 ? 18 : 14;

    return ThemeData(
      primaryColor: Colors.blueAccent,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: headingSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: bodySize,
          color: Colors.black87,
        ),
        labelSmall: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }
}
