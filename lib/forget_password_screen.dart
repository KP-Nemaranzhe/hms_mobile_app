import 'package:flutter/material.dart';
import 'custom_scaffold.dart'; // Custom scaffold widget
import 'theme.dart'; // Theme settings

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation

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
                  key: _formKey, // Key for the form
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Reset Password message
                      Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0), // Spacer

                      // Email input field
                      TextFormField(
                        validator: (value) {
                          // Validate email input
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email'; // Error message if empty
                          }
                          return null; // No error
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'), // Label for the input
                          hintText: 'Enter your registered Email', // Placeholder text
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

                      // Reset Password button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate form
                            if (_formKey.currentState!.validate()) {
                              // Here you can add logic to reset the password
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Reset link sent! Check your email.'), // SnackBar message
                                ),
                              );
                            }
                          },
                          child: const Text('Send Reset Link'), // Button label
                        ),
                      ),
                      const SizedBox(height: 25.0), // Spacer

                      // Back to Sign In prompt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Remember your password? ', // Prompt message
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Navigate back to Sign In screen
                            },
                            child: Text(
                              'Sign in', // Sign in link
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
