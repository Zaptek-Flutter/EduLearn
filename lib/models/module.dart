class Module {
  final String id;
  final String title;
  final int duration; // in minutes
  bool isCompleted;

  Module({
    required this.id,
    required this.title,
    required this.duration,
    this.isCompleted = false,
  });
}
