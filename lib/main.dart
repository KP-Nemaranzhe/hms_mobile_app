import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the splash screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HMS App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define the overall theme color
      ),
      home: SplashScreen(), // Start with the splash screen on app launch
      debugShowCheckedModeBanner: false, // Hide the debug banner
    );
  }
}
