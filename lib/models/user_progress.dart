class UserProgress {
  final String userId;
  final String courseId;
  int completedModules;

  UserProgress({
    required this.userId,
    required this.courseId,
    this.completedModules = 0,
  });

  double calculateProgress(int totalModules) {
    return (completedModules / totalModules) * 100;
  }

  void markModuleAsCompleted() {
    completedModules++;
  }
}
