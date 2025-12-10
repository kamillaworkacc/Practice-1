import 'package:flutter/material.dart';

class AppTheme {
  static const Color spacePurple = Color(0xFF6B46C1);
  static const Color spacePink = Color(0xFFEC4899);
  static const Color spaceBlue = Color(0xFF3B82F6);
  static const Color spaceDark = Color(0xFF1E1B4B);
  static const Color spaceLight = Color(0xFFE0E7FF);
  static const Color starYellow = Color(0xFFFCD34D);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: spacePurple,
        secondary: spacePink,
        tertiary: spaceBlue,
        surface: spaceDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: spaceLight,
      ),
      scaffoldBackgroundColor: spaceDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: spaceDark,
        foregroundColor: spaceLight,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF312E81),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: spacePurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF312E81),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: spacePurple),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: spacePurple.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: spacePurple, width: 2),
        ),
        labelStyle: TextStyle(color: spaceLight),
        hintStyle: TextStyle(color: spaceLight.withOpacity(0.6)),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: spaceLight,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: spaceLight,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: spaceLight,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: spaceLight,
          fontSize: 14,
        ),
      ),
    );
  }
}

