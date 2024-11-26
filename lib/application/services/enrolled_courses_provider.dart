import 'package:edulearn/authentication/route/authstate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/course.dart';

// Provider for enrolled courses
final enrolledCoursesProvider = StreamProvider.autoDispose((ref) {
  final user = ref.watch(authProvider).user;

  if (user == null) {
    return Stream.value(<Course>[]);
  }

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('my_courses')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return Course(
            id: doc.id,
            title: data['course_title'] ?? '',
            description: data['course_description'] ?? '',
            instructor: data['course_instructor'] ?? '',
            thumbnailUrl: data['course_thumbnail_url'] ?? '',
            rating: (data['course_rating'] ?? 0.0).toDouble(),
            duration: data['course_duration'] ?? '',
            modulesCount: data['course_modules_count'] ?? 0,
            modules: [], 
          );
        }).toList();
      });
});
