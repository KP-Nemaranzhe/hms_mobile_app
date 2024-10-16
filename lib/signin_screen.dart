import 'package:flutter/material.dart';
import 'signup_screen.dart'; // Importing the Sign Up screen
import 'custom_scaffold.dart'; // Custom scaffold widget
import 'theme.dart'; // Theme settings
import 'forget_password_screen.dart'; // Import the Forgot Password Screen
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package for opening URLs
import 'dashboard.dart'; // Import the Dashboard screen
import 'package:http/http.dart' as http; // Import HTTP package
import 'dart:convert'; // Import for JSON encoding/decoding
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import secure storage package

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>(); // Key for form validation
  final _storage = FlutterSecureStorage(); // Secure storage instance
  bool rememberPassword = true; // Flag for 'Remember me' checkbox

  String email = ''; // To hold the email input
  String password = ''; // To hold the password input

  // Method to launch external URLs
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // Parse the URL string into a Uri object

    // Check if the URL can be launched
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Launch the URL
    } else {
      throw 'Could not launch $url'; // Throw an error if the URL cannot be launched
    }
  }

  // Method to handle login
  Future<void> _login() async {
    final url = 'http://10.0.2.2:8000/api/token/'; // Update with your Django API URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': email,
          'password': password,
        }),
      );

      // Check if the login was successful
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String accessToken = responseData['access']; // Extract the access token

        // Store the token securely
        await _storage.write(key: 'token', value: accessToken);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );

        // Navigate to the Dashboard screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()), // Remove const here if Dashboard has non-const constructor
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1, // Takes up 1/8 of the available space
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7, // Takes up 7/8 of the available space
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0), // Padding for the container
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey, // Key for the form
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Welcome message
                      Text(
                        'Welcome back',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0), // Spacer

                      // Email input field
                      TextFormField(
                        onChanged: (value) {
                          email = value; // Update email on change
                        },
                        validator: (value) {
                          // Validate email input
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email'; // Error message if empty
                          }
                          return null; // No error
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'), // Label for the input
                          hintText: 'Enter Email', // Placeholder text
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0), // Spacer

                      // Password input field
                      TextFormField(
                        obscureText: true, // Hide password input
                        obscuringCharacter: '*',
                        onChanged: (value) {
                          password = value; // Update password on change
                        },
                        validator: (value) {
                          // Validate password input
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password'; // Error message if empty
                          }
                          return null; // No error
                        },
                        decoration: InputDecoration(
                          label: const Text('Password'), // Label for the input
                          hintText: 'Enter Password', // Placeholder text
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0), // Spacer

                      // Row for 'Remember me' checkbox and 'Forget password?' link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberPassword, // Checkbox state
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberPassword = value!; // Update state
                                  });
                                },
                                activeColor: lightColorScheme.primary,
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the Forgot Password page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Forget password?', // Text for password recovery
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0), // Spacer

                      // Sign In button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate form and check rememberPassword status
                            if (_formSignInKey.currentState!.validate()) {
                              _login(); // Call login method
                            }
                          },
                          child: const Text('Sign In'), // Button label
                        ),
                      ),
                      const SizedBox(height: 25.0), // Spacer

                      // Divider and sign-up prompt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            child: Text(
                              'Sign up with',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0), // Spacer

                      // Row for social media sign-up buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Facebook sign-up button
                          GestureDetector(
                            onTap: () {
                              _launchURL('https://facebook.com'); // Launch Facebook sign-up URL
                            },
                            child: CircleAvatar(
                              radius: 20, // Adjust size as needed
                              backgroundImage: AssetImage('assets/images/facebook_icon.png'), // Updated path to Facebook PNG
                            ),
                          ),
                          // Google sign-up button
                          GestureDetector(
                            onTap: () {
                              _launchURL('https://google.com'); // Launch Google sign-up URL
                            },
                            child: CircleAvatar(
                              radius: 20, // Adjust size as needed
                              backgroundImage: AssetImage('assets/images/google_icon.png'), // Updated path to Google PNG
                            ),
                          ),
                          // Twitter sign-up button
                          GestureDetector(
                            onTap: () {
                              _launchURL('https://twitter.com'); // Launch Twitter sign-up URL
                            },
                            child: CircleAvatar(
                              radius: 20, // Adjust size as needed
                              backgroundImage: AssetImage('assets/images/twitter_icon.png'), // Updated path to Twitter PNG
                            ),
                          ),
                          // Instagram sign-up button
                          GestureDetector(
                            onTap: () {
                              _launchURL('https://instagram.com'); // Launch Instagram sign-up URL
                            },
                            child: CircleAvatar(
                              radius: 20, // Adjust size as needed
                              backgroundImage: AssetImage('assets/images/instagram_icon.png'), // Updated path to Instagram PNG
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0), // Spacer

                      // Prompt for existing users
                      GestureDetector(
                        onTap: () {
                          // Navigate to Sign Up page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: const Text(
                          'Don’t have an account? Sign up',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}
