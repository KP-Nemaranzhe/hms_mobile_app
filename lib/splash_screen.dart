import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'welcome_screen.dart'; // Import the WelcomePage
import 'dashboard.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // Animation controller for managing the fade animation
  AnimationController? _animationController;

  // Animation for fading in the text
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 1 second
    _animationController = AnimationController(
      duration: Duration(seconds: 3), // Animation duration
      vsync: this, // Ticker provider for animations
    );

    // Define the fade animation, fading from 0.0 (invisible) to 1.0 (fully visible)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!, // Link animation to the controller
        curve: Curves.easeIn, // Easing function for the animation
      ),
    );

    // Start the fade animation
    _animationController!.forward();

    // Delay for 3 seconds and then navigate to the WelcomePage
    Future.delayed(Duration(seconds: 4), () {
      _navigateToDashboard();
    });
  }

  // Function to navigate to the WelcomePage
  void _navigateToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()), // Navigate to the next screen
    );
  }

  @override
  void dispose() {
    // Dispose the animation controller when the widget is disposed
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, // Set the background color to black
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation!, // Apply the fading animation to the text
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
              children: [
                // Main title text with professional font from Google Fonts
                Text(
                  'HMS',
                  style: GoogleFonts.poppins( // Use a professional font
                    fontSize: 72, // Increased font size for emphasis
                    color: Colors.white, // Color of the main title
                    fontWeight: FontWeight.bold, // Bold font weight
                  ),
                ),
                SizedBox(height: 20), // Spacing between title and subtitle
                // Subtitle text styled with blue color and professional font
                Text(
                  'Mobile for Students',
                  style: GoogleFonts.poppins( // Use the same professional font
                    fontSize: 28, // Font size for the subtitle
                    color: Colors.blue, // Blue color for the subtitle
                    fontWeight: FontWeight.w300, // Light font weight
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
