import 'package:edulearn/application/services/enrolled_courses_provider.dart';
import 'package:edulearn/application/widgets/filtered_courses_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/course.dart';

class FilteredCoursesListView extends ConsumerWidget {
  const FilteredCoursesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCoursesAsync = ref.watch(enrolledCoursesProvider);

    return myCoursesAsync.when(
      data: (courses) {
        if (courses.isEmpty) {
          return _buildEmptyState(context);
        }
        return _buildCoursesList(courses);
      },
      loading: () => _buildLoadingState(),
      error: (error, stackTrace) => _buildErrorState(context, ref, error),
    );
  }

  Widget _buildCoursesList(List<Course> courses) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return FilteredCoursesWidget(course: courses[index]);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No available courses',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explore our course catalog to start learning',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),          
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator()
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(enrolledCoursesProvider);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
