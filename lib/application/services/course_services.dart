import 'package:edulearn/models/course.dart';
import 'package:edulearn/models/module.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coursesProvider = StateNotifierProvider<CoursesNotifier, List<Course>>(
  (ref) => CoursesNotifier(),
);

class CoursesNotifier extends StateNotifier<List<Course>> {
  CoursesNotifier() : super(_dummyCourses);

  static final List<Course> _dummyCourses = [
    Course(
      id: '1',
      title: 'Learn to Code',
      instructor: 'Davit Rouben',
      rating: 4.5,
      duration: 2.5,
      modulesCount: 3,
      description: 'Perfect introduction to programming.',
      thumbnailUrl: 'https://img.freepik.com/free-photo/code-coding-programming-technology-technical-concept_53876-120436.jpg?t=st=1732066521~exp=1732070121~hmac=34e66e53f708b57621dbb925ce1365be009f5c682301d1cc85fae0003e4ebdb5&w=1380',
      modules: [
        Module(id: '1', title: 'Discover the fundamentals of programming', duration: 16),
        Module(id: '2', title: 'Introduction to Variables', duration: 12),
        Module(id: '3', title: 'Understanding Loops', duration: 20),
      ],
    ),
    
  Course(
    id: '2',
    title: 'Digital Marketing Mastery',
    instructor: 'Emma Rodriguez',
    rating: 4.7,
    duration: 3.0,
    modulesCount: 4,
    description: 'Comprehensive digital marketing strategies and techniques.',
    thumbnailUrl: 'https://img.freepik.com/free-photo/digital-marketing-concept-with-icons-network_1379-881.jpg?t=st=1732066666~exp=1732070266~hmac=5e5a4c7c2a5c2c7e9f0c4a1b3d2f1e0a9c8b7d6e5f4c3b2a1&w=1380',
    modules: [
      Module(id: '1', title: 'Social Media Marketing Basics', duration: 18),
      Module(id: '2', title: 'SEO and Content Strategy', duration: 22),
      Module(id: '3', title: 'Google Ads and PPC', duration: 16),
      Module(id: '4', title: 'Analytics and Performance Tracking', duration: 14),
    ],
  ),
  Course(
    id: '3',
    title: 'Data Science Fundamentals',
    instructor: 'Alex Chen',
    rating: 4.9,
    duration: 4.5,
    modulesCount: 5,
    description: 'In-depth exploration of data science and machine learning.',
    thumbnailUrl: 'https://img.freepik.com/free-photo/ai-technology-microchip-background-digital-transformation-concept_53876-124669.jpg?t=st=1732066727~exp=1732070327~hmac=8f9e9c7b5d4a3f2e1c6b9d5a3f7e2c1b6d9a4f3e2c1b7d6&w=1380',
    modules: [
      Module(id: '1', title: 'Introduction to Python', duration: 20),
      Module(id: '2', title: 'Data Manipulation with Pandas', duration: 25),
      Module(id: '3', title: 'Statistical Analysis', duration: 18),
      Module(id: '4', title: 'Machine Learning Basics', duration: 30),
      Module(id: '5', title: 'Data Visualization', duration: 15),
    ],
  ),
  Course(
  id: '4',
  title: 'UI/UX Design Masterclass',
  instructor: 'Sophie Williams',
  rating: 4.8,
  duration: 3.5,
  modulesCount: 5,
  description: 'Comprehensive guide to modern user interface and user experience design.',
  thumbnailUrl: 'https://img.freepik.com/free-vector/ui-ux-design-concept-with-desktop-screen_23-2148797915.jpg?t=st=1732067890~exp=1732071490~hmac=9f3c5a2e8d1b7f4c6a3e2d1b7f4c6a3e2d1b7f4c6a3e2d1&w=1380',
  modules: [
    Module(id: '1', title: 'Design Principles and Fundamentals', duration: 22),
    Module(id: '2', title: 'User Research and Empathy Mapping', duration: 18),
    Module(id: '3', title: 'Wireframing and Prototyping', duration: 25),
    Module(id: '4', title: 'Color Theory and Typography', duration: 16),
    Module(id: '5', title: 'Designing for Different Platforms', duration: 20),
  ],
),
  ];

   List<Course> enrolledCourses = []; 
  void enrollInCourse(Course course) {
    if (!enrolledCourses.contains(course)) {
      enrolledCourses.add(course);
      state = [...state]; 
    }
  }

  void markModuleCompleted(String courseId, String moduleId) {
    state = [
      for (final course in state)
        if (course.id == courseId)
          Course(
            id: course.id,
            title: course.title,
            instructor: course.instructor,
            rating: course.rating,
            duration: course.duration,
            modulesCount: course.modulesCount,
            description: course.description,
            thumbnailUrl: course.thumbnailUrl,
            modules: [
              for (final module in course.modules)
                if (module.id == moduleId)
                  Module(
                    id: module.id,
                    title: module.title,
                    duration: module.duration,
                    isCompleted: true,
                  )
                else
                  module,
            ],
          )
        else
          course,
    ];
  }
}
