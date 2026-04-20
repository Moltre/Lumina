import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color darkBg = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF111111);
  static const Color darkCard = Color(0xFF1A1A1A);
  static const Color gold = Color(0xFFD4A843);
  static const Color goldLight = Color(0xFFE8C572);
  static const Color goldDark = Color(0xFFB8902E);
  static const Color beige = Color(0xFFF5F0E8);
  static const Color white = Colors.white;
  static const Color whiteOp70 = Color(0xB3FFFFFF);
  static const Color whiteOp20 = Color(0x33FFFFFF);
  static const Color whiteOp10 = Color(0x1AFFFFFF);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: gold,
      colorScheme: const ColorScheme.dark(
        primary: gold,
        secondary: goldLight,
        surface: darkSurface,
        background: darkBg,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          color: white,
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          color: white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          color: gold,
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          color: white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: white,
          fontSize: 18,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: whiteOp70,
          fontSize: 16,
        ),
      ),
    );
  }

  static BoxDecoration glassDecoration = BoxDecoration(
    color: whiteOp10,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: whiteOp20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 20,
        spreadRadius: 5,
      ),
    ],
  );

  static LinearGradient goldGradient = const LinearGradient(
    colors: [goldDark, gold, goldLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
