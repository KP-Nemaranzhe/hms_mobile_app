import 'package:flutter/material.dart';
import 'signup_page.dart'; // Import the SignUpPage class
import 'login_page.dart'; // Import the LoginPage class

// WelcomePage class for the main welcome page of the app
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the background color for the entire welcome page
      backgroundColor: Color(0xFF001F3F), // Dark Blue color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between main content and footer
        children: [
          // Hero Section: Main area designed to attract user attention
          Expanded(
            child: Container(
              color: Color(0xFF003B5C), // A darker shade for the hero section background
              child: Center(
                // Centering the text within the hero section
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                  children: [
                    // Main headline that welcomes users to the app
                    Text(
                      'Welcome to HMS App!',
                      style: TextStyle(
                        fontSize: 28, // Font size for the headline
                        fontWeight: FontWeight.bold, // Bold text style
                        color: Colors.white, // White text color for contrast
                      ),
                      textAlign: TextAlign.center, // Center-align text
                    ),
                    SizedBox(height: 10), // Space between headline and subheadline
                    // Subheadline providing additional context about the app
                    Text(
                      'Your journey to seamless learning starts here.',
                      style: TextStyle(
                        fontSize: 16, // Font size for the subheadline
                        color: Colors.white70, // Slightly lighter text color for distinction
                      ),
                      textAlign: TextAlign.center, // Center-align text
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Call to Action (CTA) section with buttons for signing up and logging in
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding around the buttons
            child: Column(
              children: [
                // Button for signing up (navigate to Sign-Up page)
                ElevatedButton(
                  onPressed: () {
                    // Action to navigate to the Sign-Up screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()), // Navigate to Sign-Up page
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF39CCCC), // Teal color for the button background
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12), // Padding for button size
                  ),
                  child: Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.white)), // Button text
                ),
                SizedBox(height: 10), // Space between Sign-Up and Login buttons
                // Button for logging in (navigate to Login page)
                OutlinedButton(
                  onPressed: () {
                    // Action to navigate to the Login screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to Login page
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFF39CCCC)), // Teal color for the button border
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12), // Padding for button size
                  ),
                  child: Text('Login', style: TextStyle(fontSize: 18, color: Color(0xFF39CCCC))), // Button text
                ),
              ],
            ),
          ),

          // Footer section containing legal links
          Container(
            color: Color(0xFF003B5C), // Dark background for the footer
            padding: EdgeInsets.all(16.0), // Padding around the footer content
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center links in the footer
              children: [
                // Links in the footer for legal information
                TextButton(
                  onPressed: () {
                    // Action to navigate to Privacy Policy page
                  },
                  child: Text('Privacy Policy', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    // Action to navigate to Terms of Service page
                  },
                  child: Text('Terms of Service', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    // Action to navigate to Social Media profiles
                  },
                  child: Text('Social Media', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
