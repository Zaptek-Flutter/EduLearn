// ignore_for_file: use_build_context_synchronously

import 'package:edulearn/application/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class SignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to check if input is an email
  bool _isEmail(String input) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegExp.hasMatch(input);
  }

  // Sign-in function
  Future<void> signIn({
    required String usernameOrEmail,
    required String password,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      String email = usernameOrEmail;

      // Check if the input is an email, else treat as username
      if (!_isEmail(usernameOrEmail)) {
        // Query Firestore to find the email associated with the username
        DocumentSnapshot userDoc = await _firestore.collection('users')
            .where('username', isEqualTo: usernameOrEmail)
            .limit(1)
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isEmpty) {
            throw FirebaseAuthException(
              code: 'user-not-found',
              message: 'Username not found.',
            );
          }
          return querySnapshot.docs.first;
        });

        // Retrieve the email from Firestore document
        email = userDoc['email'];
      }

      // Proceed to sign in with the email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Log the success (for developer debugging)
      logger.i("User signed in successfully: ${userCredential.user?.email}");

      // Show a success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed in successfully!')),
      );

      // Navigate to the Home screen after a successful sign-in
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
        (Route<dynamic> route) => false, // Remove all previous routes
      );
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException errors
      logger.e("Sign-in failed: ${e.code}: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    } catch (e) {
      // Handle other exceptions
      logger.e("Unexpected error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred.')),
      );
    }
  }
}
