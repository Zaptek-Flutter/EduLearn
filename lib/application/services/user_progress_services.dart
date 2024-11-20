import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_progress.dart';

final userProgressProvider =
    StateNotifierProvider<UserProgressNotifier, Map<String, UserProgress>>(
  (ref) => UserProgressNotifier(),
);

class UserProgressNotifier extends StateNotifier<Map<String, UserProgress>> {
  UserProgressNotifier() : super({});

  void initializeProgress(String userId, String courseId) {
    if (!state.containsKey(courseId)) {
      state = {
        ...state,
        courseId: UserProgress(userId: userId, courseId: courseId, completedModules: 0),
      };
    }
  }

  void markModuleAsCompleted(String courseId) {
    if (state.containsKey(courseId)) {
      final progress = state[courseId]!;
      state = {
        ...state,
        courseId: UserProgress(
          userId: progress.userId,
          courseId: courseId,
          completedModules: progress.completedModules + 1,
        ),
      };
    }
  }

  double getProgressPercentage(String courseId, int totalModules) {
    return state[courseId]?.calculateProgress(totalModules) ?? 0;
  }
}
