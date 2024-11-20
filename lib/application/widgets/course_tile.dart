// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edulearn/models/course.dart';

class CourseTile extends ConsumerWidget {
  final Course course;

  const CourseTile({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 190,
      height: 124.27,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            //Push to Course screen
            // Detailed course information logging
            print('Course Details:');
            print('ID: ${course.id}');
            print('Title: ${course.title}');
            print('Instructor: ${course.instructor}');
            print('Rating: ${course.rating}');
            print('Duration: ${course.duration} hours');
            print('Description: ${course.description}');
            print('Thumbnail URL: ${course.thumbnailUrl}');
            print('Number of Modules: ${course.modulesCount}');
            
            print('\nModules:');
            for (var module in course.modules) {
              print('- Module ID: ${module.id}');
              print('  Title: ${module.title}');
              print('  Duration: ${module.duration} minutes');
              print('  Completed: ${module.isCompleted}');
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.network(
                course.thumbnailUrl,
                width: 190,
                height: 124.27,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.error_outline,
                        size: 24,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 88,
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () {
                          //Push to course screen
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: const Color.fromRGBO(46, 204, 113, 1),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Enroll Now',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}