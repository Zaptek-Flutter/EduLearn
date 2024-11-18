// ignore_for_file: avoid_print

import 'package:edulearn/authentication/screens/signin.dart';
import 'package:edulearn/authentication/signup_service.dart';
import 'package:edulearn/authentication/widgets/auth_button.dart';
import 'package:edulearn/authentication/widgets/signup_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  bool _isLoading = false; // Loading state

  void _signup(BuildContext context, WidgetRef ref) async {
    setState(() {
      _isLoading = true; // Start loading
    });

    final fullName = ref.read(fullNameProvider);
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);
    final confirmPassword = ref.read(confirmPasswordProvider);

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        _isLoading = false; // Stop loading
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (password.length <= 5) {
      setState(() {
        _isLoading = false; // Stop loading
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be more than 5')),
      );
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _isLoading = false; // Stop loading
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Call the AuthService to sign up with email and password
    SignupService authService = SignupService();
    await authService.signUpWithEmailPassword(
      context: context,
      email: email,
      password: password,
      username: fullName,
    );

    // Wait for 3 seconds to simulate loading delay
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isLoading = false; // Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 180,
              ),
              Center(
                child: Image.asset(
                  "assets/icons/appicon.png",
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.inter(
                    color: const Color.fromRGBO(15, 12, 128, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(16.0), child: SignUpForm()),
              const SizedBox(
                height: 30,
              ),
              // If loading, show CircularProgressIndicator
              _isLoading
                  ? const CircularProgressIndicator()
                  : InkWell(
                      onTap: () {},
                      child: AuthButton(
                        buttonText: 'Sign up',
                        onPressed: () => _signup(context, ref),
                      ),
                    ),
              const SizedBox(
                height: 40,
              ),
              RichText(
                text: TextSpan(
                    style: GoogleFonts.inter(
                        color: const Color.fromRGBO(15, 12, 128, 1)),
                    children: [
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Sign in",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle the sign-up action here, like navigating to a signup page
                            print("Sign in clicked");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signin()));
                          },
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
