// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import 'package:edulearn/models/course.dart';

final enrollmentProvider = StateNotifierProvider<EnrollmentNotifier, EnrollmentState>(
  (ref) => EnrollmentNotifier(),
);

class EnrollmentState {
  final bool isEnrolling;
  final bool isEnrolled;

  EnrollmentState({
    this.isEnrolling = false,
    this.isEnrolled = false,
  });

  EnrollmentState copyWith({
    bool? isEnrolling,
    bool? isEnrolled,
  }) {
    return EnrollmentState(
      isEnrolling: isEnrolling ?? this.isEnrolling,
      isEnrolled: isEnrolled ?? this.isEnrolled,
    );
  }
}

class EnrollmentNotifier extends StateNotifier<EnrollmentState> {
  EnrollmentNotifier() : super(EnrollmentState());

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _logger = Logger();

  Future<void> enrollInCourse(BuildContext context, Course course) async {
    state = state.copyWith(isEnrolling: true);

    try {
      // Get the current user's ID from Firebase Authentication
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user found');
      }

      // Add the course to the user's enrolled courses
      await _firestore.collection('users').doc(currentUser.uid).collection('my_courses').add({
        'course_id': course.id,
        'enrolled_at': FieldValue.serverTimestamp(),
      });

      state = state.copyWith(isEnrolled: true, isEnrolling: false);
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully enrolled in the course'),
        ),
      );
    } catch (e) {
      _logger.e('Error enrolling in the course: $e');
      state = state.copyWith(isEnrolling: false);

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to enroll in the course: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}