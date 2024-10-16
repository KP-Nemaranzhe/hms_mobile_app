import 'package:flutter/material.dart';
import 'package:hms_mobile_app/welcome_screen.dart';


class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use this to navigate to the welcome page immediately after this page builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Logging Out"),
      ),
      body: Center(
        child: CircularProgressIndicator(), // Optional: show a loading indicator
      ),
    );
  }
}
