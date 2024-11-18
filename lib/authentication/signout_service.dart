// ignore_for_file: use_build_context_synchronously

import 'package:edulearn/authentication/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart'; // Import the logger package

class SignOutService {
  static final Logger logger = Logger(); // Initialize the logger

  // Function to show a confirmation dialog and then sign out
  static Future<void> signOutWithConfirmation(BuildContext context) async {
    try {
      // Show confirmation dialog
      bool? confirmed = await _showConfirmationDialog(context);
      
      if (confirmed == true) {
        // Start loading state
        _showLoading(context);

        // Simulate a 3-second delay to demonstrate loading state
        await Future.delayed(const Duration(seconds: 3));

        try {
          // Sign out logic (replace with actual sign-out logic)
          await FirebaseAuth.instance.signOut();

          // Show Snackbar after successful sign-out
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully signed out.')),
          );

          // Navigate to the Sign-In screen and remove all previous screens
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Signin()), 
            (route) => false,
          );
        } catch (e, stackTrace) {
          // Log the error for developers and show Snackbar for users
          logger.e('Error during sign out $e, $stackTrace'
           );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to sign out. Please try again.')),
          );
        }
      }
    } catch (e, stackTrace) {
      // Log any errors during the confirmation process
      logger.e('Error during sign out confirmation $e, $stackTrace');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    }
  }

  // Function to show the confirmation dialog
  static Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, 
          title: const Text(
            'Sign Out',
            style: TextStyle(
              fontFamily: 'Inter', 
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, 
            ),
          ),
          content: const Text(
            'Are you sure you want to sign out?',
            style: TextStyle(
              fontFamily: 'Inter', 
              fontSize: 16,
              color: Colors.black, 
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); 
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromRGBO(15, 12, 128, 1), 
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Color.fromRGBO(15, 12, 128, 1), 
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); 
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange, 
              ),
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange, 
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to show a loading state (e.g., a circular progress indicator)
  static void _showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(), 
        );
      },
    );
  }
}
