import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color _lightPrimary = Color(0xFF2196F3);
  static const Color _lightSecondary = Color(0xFF03DAC6);
  static const Color _lightBackground = Color(0xFFF5F7FA);
  static const Color _lightSurface = Colors.white;
  static const Color _lightError = Color(0xFFE53935);
  static const Color _lightOnPrimary = Colors.white;
  static const Color _lightOnSecondary = Colors.black;
  static const Color _lightOnBackground = Color(0xFF1A1A1A);
  static const Color _lightOnSurface = Color(0xFF1A1A1A);
  static const Color _lightOnError = Colors.white;

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFF90CAF9);
  static const Color _darkSecondary = Color(0xFF80CBC4);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkError = Color(0xFFEF5350);
  static const Color _darkOnPrimary = Colors.black;
  static const Color _darkOnSecondary = Colors.black;
  static const Color _darkOnBackground = Colors.white;
  static const Color _darkOnSurface = Colors.white;
  static const Color _darkOnError = Colors.black;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: _lightPrimary,
      secondary: _lightSecondary,
      surface: _lightSurface,
      background: _lightBackground,
      error: _lightError,
      onPrimary: _lightOnPrimary,
      onSecondary: _lightOnSecondary,
      onBackground: _lightOnBackground,
      onSurface: _lightOnSurface,
      onError: _lightOnError,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: _lightPrimary,
      foregroundColor: _lightOnPrimary,
      iconTheme: IconThemeData(color: _lightOnPrimary),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: _lightSurface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: _lightPrimary,
        foregroundColor: _lightOnPrimary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _lightPrimary.withOpacity(0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _lightPrimary.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightError),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _lightPrimary;
        }
        return Colors.grey;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _lightPrimary.withOpacity(0.5);
        }
        return Colors.grey.withOpacity(0.5);
      }),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: _darkPrimary,
      secondary: _darkSecondary,
      surface: _darkSurface,
      background: _darkBackground,
      error: _darkError,
      onPrimary: _darkOnPrimary,
      onSecondary: _darkOnSecondary,
      onBackground: _darkOnBackground,
      onSurface: _darkOnSurface,
      onError: _darkOnError,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: _darkSurface,
      foregroundColor: _darkOnSurface,
      iconTheme: IconThemeData(color: _darkOnSurface),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: _darkSurface,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: _darkPrimary,
        foregroundColor: _darkOnPrimary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _darkPrimary.withOpacity(0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _darkPrimary.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _darkError),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _darkPrimary;
        }
        return Colors.grey;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _darkPrimary.withOpacity(0.5);
        }
        return Colors.grey.withOpacity(0.5);
      }),
    ),
  );
} 