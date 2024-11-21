class Module {
  final String id;
  final String title;
  final int duration; 
  final String moduleUrl;
  bool isCompleted;

  Module({
    required this.id,
    required this.title,
    required this.duration,
    required this.moduleUrl,
    this.isCompleted = false,
  });
}
