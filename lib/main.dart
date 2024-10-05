import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'theme.dart';  // Ensure this is the correct path to your theme.dart file

// Main function: Entry point of the Flutter application
void main() {
  runApp(const MyApp());
}

// MyApp widget: The root of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Signup',
      theme: lightTheme, // Apply light theme defined in theme.dart
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(), // Initial screen of the app
    );
  }
}
