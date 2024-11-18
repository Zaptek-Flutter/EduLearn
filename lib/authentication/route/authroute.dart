// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:edulearn/application/screens/home.dart';
import 'package:edulearn/authentication/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthRoute extends StatefulWidget {
  const AuthRoute({super.key});

  @override
  _AuthRouteState createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  final Logger _logger = Logger();
  bool _isLoading = true;
  bool _isNavigating = false;

  // Safe navigation method to prevent multiple navigations
  void _safeNavigate(Widget route) {
    if (!mounted || _isNavigating) return;
    
    setState(() {
      _isNavigating = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => route),
        (route) => false,
      ).then((_) {
        if (mounted) {
          setState(() {
            _isNavigating = false;
          });
        }
      });
    });
  }

  // Method to check if the current user exists in the Firestore 'users' collection
  Future<void> _checkUserStatus() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Get current Firebase user
      User? user = FirebaseAuth.instance.currentUser;

      if (!mounted) return;

      if (user == null) {
        await FirebaseAuth.instance.signOut(); 
        _safeNavigate(const Signup()); 
        return;
      }

      // Check if the user exists in the Firestore 'users' collection
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!mounted) return;

      if (userDoc.exists) {
        _safeNavigate(const Home());
      } else {
        _safeNavigate(const Signup());
      }
    } catch (e) {
      _logger.e("Error checking user status: $e");
      if (!mounted) return;
      
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Delay the check slightly to ensure proper widget initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Error loading application',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  if (!_isNavigating)
                    ElevatedButton(
                      onPressed: _checkUserStatus,
                      child: const Text('Retry'),
                    ),
                ],
              ),
      ),
    );
  }
}