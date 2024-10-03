import 'package:flutter/material.dart';
import 'welcome_page.dart'; // Import WelcomePage, which will be shown after the splash screen

// SplashScreen class responsible for the app's initial animated screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// State class for SplashScreen that contains the animation logic
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controls the timing of the animation
  late Animation<double> _animation; // Defines the actual animation (scaling effect)

  // Initialization of the animation when the app starts
  @override
  void initState() {
    super.initState();

    // Block comment explaining the animation setup
    /*
     * AnimationController:
     * - Controls the animation's duration (5 seconds in this case).
     * - The vsync is provided by the current class (_SplashScreenState), ensuring smooth performance.
     *
     * Tween:
     * - A Tween animation interpolates between two values, in this case from 0.0 to 1.0.
     * - Curves.easeInOut: Provides a smooth transition, making the animation start slow, speed up, then slow down again.
     */
    _controller = AnimationController(
      duration: Duration(seconds: 5), // The animation will now take 5 seconds
      vsync: this, // The vsync ensures the animation is synchronized with the device's refresh rate for performance
    );

    // Set up the scaling animation for the icon using Tween and CurvedAnimation
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller, // The controller manages the animation
        curve: Curves.easeInOut, // The curve defines how the animation transitions over time
      ),
    );

    // Begin the animation as soon as the splash screen is initialized
    _controller.forward(); // This starts the scaling of the app icon immediately

    // Delay for 5 seconds, then move to the WelcomePage
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context, // The current app context
        MaterialPageRoute(builder: (context) => WelcomePage()), // Navigate to the WelcomePage after the splash screen
      );
    });
  }

  // Dispose of the animation controller when it's no longer needed
  @override
  void dispose() {
    _controller.dispose(); // Ensures resources are properly cleaned up
    super.dispose();
  }

  // Main UI for the splash screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background to white
      body: Center(
        // Center the icon on the screen
        child: ScaleTransition(
          // ScaleTransition widget animates the size of its child
          scale: _animation, // The scale of the icon is tied to the defined animation
          child: Image.asset(
            'assets/images/main_hms.png', // Path to the app icon image
            width: 200, // Icon's width (scales up from 0 to this size)
            height: 200, // Icon's height (scales up from 0 to this size)
          ),
        ),
      ),
    );
  }
}
