import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:labyrinth/util/app_theme.dart';
import 'package:labyrinth/util/logging.dart';
import 'package:labyrinth/data/providers/settings_provider.dart';

// TODO: Much skeleton, very bare. Wow.
class SignUpOverlay extends StatefulWidget {
  const SignUpOverlay({super.key});

  @override
  State<SignUpOverlay> createState() => _SignUpOverlayState();
}

class _SignUpOverlayState extends State<SignUpOverlay> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';

  // Method to handle sign-up process
  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Use the saved values for sign-up or authentication
      appLogger.d(
          'Signing up with Username: $_username, Email: $_email, Password: $_password');
      // You can now use these variables to make a network request or API call
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up successful for $_username')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .pop(), // Dismiss overlay when background is tapped
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: getDecorationColor(settings.theme),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Username Field
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Username'),
                          onSaved: (value) => _username = value ?? '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        // Email Field
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) => _email = value ?? '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            // Simple email validation
                            if (!RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        // Password Field
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          onSaved: (value) => _password = value ?? '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Sign Up Button
                        Center(
                          child: ElevatedButton(
                            onPressed: _handleSignUp,
                            child: Text('Sign Up'),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Close Button
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close overlay
                            },
                            child: Text('Close'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void showSignUpOverlay(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => ScaffoldMessenger(
      child: Builder(
        builder: (context) {
          return Scaffold(
              backgroundColor: Colors.transparent, body: const SignUpOverlay());
        },
      ),
    ),
  );
}
