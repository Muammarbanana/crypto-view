import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData getDark() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        actionsIconTheme: const IconThemeData(color: Color(0xFF625DEE)),
        backgroundColor: Colors.black26,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      canvasColor: const Color(0xff4B4A4A),
      cardColor: const Color(0xff4B4A4A),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF625DEE),
        brightness: Brightness.dark,
      ),
      highlightColor: Colors.transparent,
      primaryColor: const Color(0xFF625DEE),
      scaffoldBackgroundColor: const Color(0xff858484),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        bodyMedium: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        bodySmall: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData getLight() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        actionsIconTheme: const IconThemeData(color: Color(0xFF625DEE)),
        centerTitle: false,
        titleTextStyle: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      cardColor: Colors.grey.withOpacity(0.1),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF625DEE),
      ),
      highlightColor: Colors.transparent,
      outlinedButtonTheme: const OutlinedButtonThemeData(),
      primaryColor: const Color(0xFF625DEE),
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        bodyMedium: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        bodySmall: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      useMaterial3: true,
    );
  }
}
