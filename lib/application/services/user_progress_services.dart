// ignore_for_file: avoid_print
import 'package:edulearn/application/services/course_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProgress {
  final String userId;
  final String courseId;
  final int completedModules;
  final int totalModules;

  UserProgress({
    required this.userId,
    required this.courseId,
    this.completedModules = 0,
    required this.totalModules,
  });

  double calculateProgress() {
    return totalModules > 0
        ? (completedModules / totalModules) * 100
        : 0.0;
  }

  UserProgress copyWith({
    String? userId,
    String? courseId,
    int? completedModules,
    int? totalModules,
  }) {
    return UserProgress(
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      completedModules: completedModules ?? this.completedModules,
      totalModules: totalModules ?? this.totalModules,
    );
  }
}

class UserProgressNotifier extends StateNotifier<Map<String, UserProgress>> {
  final Ref _ref;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserProgressNotifier(this._ref) : super({});

  Future initializeProgress(String userId, String courseId, int totalModules) async {
    try {
      // Fetch completed modules from Firestore
      final completedModulesSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('my_courses')
          .doc(courseId)
          .collection('modules')
          .where('is_completed', isEqualTo: true)
          .get();

      final completedModulesCount = completedModulesSnapshot.docs.length;

      // Update state with actual completed modules count
      state = {
        ...state,
        courseId: UserProgress(
          userId: userId,
          courseId: courseId,
          completedModules: completedModulesCount,
          totalModules: totalModules,
        )
      };
    } catch (e) {
      print('Error initializing progress: $e');
      
      // Fallback to default state if there's an error
      state = {
        ...state,
        courseId: UserProgress(
          userId: userId,
          courseId: courseId,
          completedModules: 0,
          totalModules: totalModules,
        )
      };
    }
  }

  Future<void> updateCompletedModules(String userId, String courseId) async {
    try {
      // Fetch completed modules from Firestore
      final completedModulesSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('my_courses')
          .doc(courseId)
          .collection('modules')
          .where('is_completed', isEqualTo: true)
          .get();

      final completedModulesCount = completedModulesSnapshot.docs.length;

      // Find the course to get total modules count
      final course = _ref.read(coursesProvider)
          .firstWhere((c) => c.id == courseId);

      // Update state with the new completed modules count
      if (state.containsKey(courseId)) {
        final progress = state[courseId]!;
        state = {
          ...state,
          courseId: progress.copyWith(
            completedModules: completedModulesCount,
            totalModules: course.modulesCount
          )
        };
      }
    } catch (e) {
      print('Error updating completed modules: $e');
    }
  }

  double getProgressPercentage(String courseId) {
    return state[courseId]?.calculateProgress() ?? 0.0;
  }
  
}

final userProgressProvider = StateNotifierProvider<UserProgressNotifier, Map<String, UserProgress>>(
  (ref) => UserProgressNotifier(ref),
);