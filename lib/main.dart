import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';
import 'forget_password_screen.dart';
import 'dashboard.dart';

void main() {
  runApp(const HMSMobileApp());
}

class HMSMobileApp extends StatelessWidget {
  const HMSMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HMS Mobile App',
      theme: ThemeData.light(),
      home: SplashScreen(),
      routes: {
        //'/welcome': (context) => const WelcomeScreen(),
        '/dashboard': (context) =>  Dashboard(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgot-password': (context) => const ForgetPasswordScreen(),
      },
    );
  }
}
