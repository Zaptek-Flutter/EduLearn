// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:edulearn/authentication/screens/signup.dart';
import 'package:edulearn/authentication/signin_service.dart';
import 'package:edulearn/authentication/widgets/auth_button.dart';
import 'package:edulearn/authentication/widgets/other_accounts.dart';
import 'package:edulearn/authentication/widgets/signin_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signin extends ConsumerStatefulWidget {
  const Signin({super.key});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  bool _isLoading = false;

  // Function to handle sign-in
  void _signin(BuildContext context) async {
  setState(() {
    _isLoading = true; // Start loading
  });

  final emailOrUsername = ref.read(emailorusernameProvider);
  final password = ref.read(passwordProvider);

  // Validate inputs
  if (emailOrUsername.isEmpty || password.isEmpty) {
    setState(() {
      _isLoading = false; // Stop loading
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill all fields')),
    );
    return;
  }

  // Using SignInService to handle the sign-in logic
  SignInService signInService = SignInService();
  await signInService.signIn(
    usernameOrEmail: emailOrUsername,
    password: password,
    context: context,
    ref: ref,
  );

  setState(() {
    _isLoading = false; // Stop loading after sign-in attempt
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 180),
              Center(
                child: Image.asset(
                  "assets/icons/appicon.png",
                  width: 200,
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign In',
                  style: GoogleFonts.inter(
                    color: const Color.fromRGBO(15, 12, 128, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(16.0), child: SignInForm()),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forget Password?',
                  style: GoogleFonts.inter(
                    color: const Color.fromRGBO(15, 12, 128, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : InkWell(
                      onTap: () {},
                      child: AuthButton(
                        buttonText: 'Sign in',
                        onPressed: () => _signin(context),
                      ),
                    ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'or sign in with',
                style: GoogleFonts.inter(
                    color: const Color.fromRGBO(15, 12, 128, 1), fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              const OtherAccounts(),
              const SizedBox(
                height: 40,
              ),
              RichText(
                text: TextSpan(
                    style: GoogleFonts.inter(
                        color: const Color.fromRGBO(15, 12, 128, 1)),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: "Sign up",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle the sign-up action here, like navigating to a signup page
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signup()));
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
