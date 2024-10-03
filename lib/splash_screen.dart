import 'package:flutter/material.dart';
import 'welcome_page.dart'; // Import WelcomePage for redirection after splash screen

// SplashScreen class responsible for the app's initial animated screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// State class for SplashScreen that contains the animation logic
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controls the timing of the animation
  late Animation<double> _animation; // Defines the scaling animation

  // Initialize the animation when the app starts
  @override
  void initState() {
    super.initState();

    // Block comment explaining animation setup
    /*
     * AnimationController:
     * - Handles the duration and the vsync (syncing with the screen's refresh rate).
     * Tween:
     * - Animates the scale from 0.0 to 1.0 (no size to full size).
     */
    _controller = AnimationController(
      duration: Duration(seconds: 5), // The animation will take 5 seconds
      vsync: this, // Synchronizes the animation with the device's screen refresh rate
    );

    // Set up the scaling animation for the icon using Tween and CurvedAnimation
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller, // Connects the animation controller to the scaling effect
        curve: Curves.easeInOut, // The animation eases in and out
      ),
    );

    // Start the animation when the splash screen initializes
    _controller.forward();

    // Automatically navigate to WelcomePage after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()), // Navigate to the welcome page
      );
    });
  }

  // Dispose of the animation controller to free up resources
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Main UI of the splash screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white for contrast
      body: Center(
        // Center the icon on the screen
        child: ScaleTransition(
          // Animates the size of the app icon
          scale: _animation, // Scale is tied to the animation controller
          child: Image.asset(
            'assets/images/main_hms.png', // Path to the app icon image
            width: 300, // Width of the app icon
            height: 300, // Height of the app icon
          ),
        ),
      ),
    );
  }
}
