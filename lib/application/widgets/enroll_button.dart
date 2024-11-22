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
  final String? errorMessage;

  EnrollmentState({
    this.isEnrolling = false,
    this.isEnrolled = false,
    this.errorMessage,
  });

  EnrollmentState copyWith({
    bool? isEnrolling,
    bool? isEnrolled,
    String? errorMessage,
  }) {
    return EnrollmentState(
      isEnrolling: isEnrolling ?? this.isEnrolling,
      isEnrolled: isEnrolled ?? this.isEnrolled,
      errorMessage: errorMessage,
    );
  }
}

class EnrollmentNotifier extends StateNotifier<EnrollmentState> {
  EnrollmentNotifier() : super(EnrollmentState());

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _logger = Logger();

  Future<void> enrollInCourse(BuildContext context, Course course) async {
    state = state.copyWith(isEnrolling: true, errorMessage: null);

    try {
      // Verify authentication
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('Authentication required. Please sign in to enroll.');
      }

      // Reference to the user's course document
      final courseRef = _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('my_courses')
          .doc(course.id);

      // Check if already enrolled
      final existingEnrollment = await courseRef.get();
      if (existingEnrollment.exists) {
        throw Exception('You are already enrolled in this course.');
      }

      // Create the main course document first
      await courseRef.set({
        'course_id': course.id,
        'course_title': course.title,
        'course_instructor': course.instructor,
        'course_rating': course.rating,
        'course_duration': course.duration,
        'course_modules_count': course.modulesCount,
        'course_description': course.description,
        'course_thumbnail_url': course.thumbnailUrl,
        'enrolled_at': FieldValue.serverTimestamp(),
        'last_accessed': FieldValue.serverTimestamp(),
        'progress': 0,
        'status': 'active',
      });

      // After successfully creating the course document, add modules one by one
      for (final module in course.modules) {
        await courseRef.collection('modules').doc(module.id).set({
          'module_id': module.id,
          'module_title': module.title,
          'module_duration': module.duration,
          'module_url': module.moduleUrl,
          'is_completed': false,
          'progress': 0,
          'last_accessed': null,
          'completion_date': null,
        });
      }

      state = state.copyWith(
        isEnrolled: true, 
        isEnrolling: false,
        errorMessage: null,
      );

      _showSnackBar(
        context,
        'Successfully enrolled in ${course.title}',
        Colors.green,
      );

    } catch (e) {
      _logger.e('Enrollment error: $e');
      
      String errorMessage = _getFirebaseErrorMessage(e);
      
      state = state.copyWith(
        isEnrolling: false,
        isEnrolled: false,
        errorMessage: errorMessage,
      );

      _showSnackBar(context, errorMessage, Colors.red);
    }
  }

  String _getFirebaseErrorMessage(dynamic error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return 'Access denied. Please check your authentication.';
        case 'unavailable':
          return 'Service temporarily unavailable. Please try again later.';
        case 'not-found':
          return 'Course information not found.';
        case 'already-exists':
          return 'You are already enrolled in this course.';
        default:
          return 'An error occurred: ${error.message}';
      }
    } else if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  void _showSnackBar(BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 100,
          right: 20,
          left: 20,
        ),
      ),
    );
  }
}