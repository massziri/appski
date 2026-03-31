import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Warm orange/gold theme from Appski branding
  static const Color primary = Color(0xFFC41E3A);
  static const Color gold = Color(0xFFD4A843);
  static const Color warmBg = Color(0xFFFAF0E0);
  static const Color warmCard = Color(0xFFF5E6C8);
  static const Color warmSurface = Color(0xFFEDD9B3);
  static const Color darkText = Color(0xFF2C1810);
  static const Color bodyText = Color(0xFF5C4033);
  static const Color accent = Color(0xFF8B4513);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkNavy = Color(0xFF1A1A2E);
  static const Color lightGrey = Color(0xFF9E8E7E);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF1976D2);

  static const Color calendarFeast = Color(0xFFC41E3A);
  static const Color calendarFast = Color(0xFF1976D2);
  static const Color calendarRegular = Color(0xFF5C4033);
  static const Color eventFestival = Color(0xFFC41E3A);
  static const Color eventGathering = Color(0xFFD4A843);
  static const Color eventReligious = Color(0xFF1976D2);

  // Aliases
  static const Color macedonianRed = primary;
  static const Color grey = lightGrey;
  static const Color darkCard = warmCard;
  static const Color darkSurface = warmSurface;
  static const Color darkCardAlt = warmSurface;
}

class AppTheme {
  static ThemeData get warmTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.warmBg,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.gold,
        surface: AppColors.warmSurface,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.darkText,
        onSurface: AppColors.darkText,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.warmBg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: AppColors.darkText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: AppColors.darkText),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.warmCard,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        color: AppColors.warmCard,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: AppColors.darkText, fontSize: 28, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: AppColors.darkText, fontSize: 24, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: AppColors.darkText, fontSize: 20, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: AppColors.darkText, fontSize: 18, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: AppColors.darkText, fontSize: 16, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(color: AppColors.darkText, fontSize: 15, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: AppColors.darkText, fontSize: 14, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: AppColors.darkText, fontSize: 15),
          bodyMedium: TextStyle(color: AppColors.bodyText, fontSize: 13),
          bodySmall: TextStyle(color: AppColors.lightGrey, fontSize: 11),
          labelLarge: TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.warmSurface)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.warmSurface)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.gold, width: 2)),
        hintStyle: const TextStyle(color: AppColors.lightGrey),
        labelStyle: const TextStyle(color: AppColors.bodyText),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.warmCard,
        selectedColor: AppColors.primary,
        labelStyle: GoogleFonts.poppins(color: AppColors.darkText, fontSize: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.warmSurface, thickness: 1),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
    );
  }
}
