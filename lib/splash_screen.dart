import 'package:flutter/material.dart';
import 'welcome_page.dart'; // Import the WelcomePage class to navigate to it after the splash screen

// SplashScreen class that creates the initial loading screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controller to manage the animation
  late Animation<double> _animation; // Animation to scale the icon

  @override
  void initState() {
    super.initState(); // Call the parent class's initState

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: Duration(seconds: 6), // Set the total duration of the animation to 6 seconds
      vsync: this, // 'this' is used to indicate that the current class is the ticker provider
    );

    // Set up the animation to change the size of the icon
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller, // Use the controller for this animation
        curve: Curves.easeInOut, // Smooth animation curve for a pleasing effect
      ),
    );

    // Start the animation
    _controller.forward(); // Begin the animation

    // Navigate to the WelcomePage after the animation completes
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context, // Get the current context
        MaterialPageRoute(builder: (context) => WelcomePage()), // Create a route to the WelcomePage
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources when no longer needed
    super.dispose(); // Call the parent class's dispose method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color of the splash screen to black
      body: Center(
        // Center the content in the middle of the screen
        child: ScaleTransition(
          scale: _animation, // Apply the animation that scales the icon
          child: Image.asset(
            'assets/images/main_hms.png', // Path to the app icon with blue edges
            width: 200, // Set the width of the icon
            height: 200, // Set the height of the icon
          ),
        ),
      ),
    );
  }
}
