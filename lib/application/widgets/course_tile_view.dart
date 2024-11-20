import 'package:edulearn/application/services/course_services.dart';
import 'package:edulearn/application/widgets/course_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoursesListView extends ConsumerWidget {
  const CoursesListView({super.key});

  double _calculateGridViewHeight(int itemCount) {
      final rowCount = (itemCount / 2).ceil(); 
      const itemHeight = 124.27; 
      final totalSpacing = (rowCount - 1) * 16; 
      return (rowCount * itemHeight) + totalSpacing;
    }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(coursesProvider);

    if (courses.isEmpty) {
      return const Center(
        child: Text('No courses available', style: TextStyle(fontSize: 16)),
      );
    }

    return SizedBox(
      height: _calculateGridViewHeight(courses.length),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 190 / 124.27,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) => CourseTile(course: courses[index]),
      ),
    );

    
  }
}
