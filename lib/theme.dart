import 'package:flutter/material.dart';

// Define light color scheme
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF416FDF),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF6EAEE7),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFFCFDF6), // Use surface instead of background
  onSurface: Color(0xFF1A1C18),
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFFC2C8BC),
);

// Define dark color scheme
const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF416FDF),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFF6EAEE7),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFF1A1C18), // Use surface instead of background
  onSurface: Color(0xFFFFFFFF),
  shadow: Color(0xFF000000),
  outlineVariant: Color(0xFF494D47),
);

// Define light theme with light color scheme
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black54),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(lightColorScheme.primary),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      elevation: WidgetStateProperty.all<double>(5.0),
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF416FDF),
    foregroundColor: Colors.white,
  ),
);

// Define dark theme with dark color scheme
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(darkColorScheme.primary),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      elevation: WidgetStateProperty.all<double>(5.0),
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF416FDF),
    foregroundColor: Colors.white,
  ),
);
