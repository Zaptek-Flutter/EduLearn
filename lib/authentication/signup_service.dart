// auth_service.dart
// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulearn/application/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/users.dart';

class SignupService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  // Sign up with email and password
  Future<void> signUpWithEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user from FirebaseAuth
      User? user = userCredential.user;

      if (user != null) {
        // Save user details to Firestore
        await _saveUserDetailsToFirestore(context, user, username, email);
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Authentication errors
      _handleAuthError(e, context);
    } catch (e) {
      // Handle general errors
      _logger.e('Error during sign-up: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    }
  }

  // Save user details to Firestore
  Future<void> _saveUserDetailsToFirestore(
      BuildContext context, User user, String username, String email) async {
    try {
      // Create a UserModel
      UserModel newUser = UserModel(
        uid: user.uid,
        username: username,
        email: email,
        profilePictureUrl: '', 
      );

      // Save user details to Firestore
      await _firestore.collection('users').doc(user.uid).set(newUser.toMap());


      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up successful')),
      );

      // Navigate to Home screen after successful sign-up
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()), 
            (route) => false, // Remove all routes in the stack
          );
    } catch (e) {
      // Handle errors during saving user details
      _logger.e('Error saving user details to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save user details. Please try again later.')),
      );
    }
  }

  // Handle Firebase Authentication errors
  void _handleAuthError(FirebaseAuthException e, BuildContext context) {
    String errorMessage = 'An error occurred. Please try again later.';

    switch (e.code) {
      case 'email-already-in-use':
        errorMessage = 'The email address is already in use.';
        break;
      case 'weak-password':
        errorMessage = 'The password is too weak.';
        break;
      case 'invalid-email':
        errorMessage = 'The email address is invalid.';
        break;
      default:
        errorMessage = e.message ?? errorMessage;
    }

    // Log the error for developers
    _logger.e('Auth error: ${e.code} - ${e.message}');

    // Show error message for users
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

}
