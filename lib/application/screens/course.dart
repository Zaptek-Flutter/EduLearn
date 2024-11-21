// ignore_for_file: avoid_print

import 'package:edulearn/application/widgets/courseimage.dart';
import 'package:edulearn/application/widgets/enroll_button.dart';
import 'package:edulearn/application/widgets/module_display.dart';
import 'package:edulearn/application/widgets/profile.dart';
import 'package:edulearn/application/widgets/star_rating.dart';
import 'package:edulearn/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Courses extends ConsumerWidget {
  final Course course;
  const Courses({super.key, required this.course});

  // Function to show the profile when tapped
  void _showProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const Profile();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrollmentState = ref.watch(enrollmentProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          'assets/icons/back.png',
                          width: 30,
                        ),
                      ),
                      Text('Back',
                          style: GoogleFonts.roboto(
                              color: const Color.fromRGBO(230, 126, 34, 1))),
                      const SizedBox(width: 260),
                      InkWell(
                        onTap: () => print("Notifactions"),
                        child: Image.asset(
                          'assets/icons/notification.png',
                          width: 24,
                        ),
                      ),
                      const SizedBox(width: 30),
                      InkWell(
                        onTap: () => _showProfileModal(context),
                        child: Image.asset(
                          'assets/icons/user.png',
                          width: 24,
                          color: const Color.fromRGBO(230, 126, 34, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Courseimage(
                    thumbnail: course.thumbnailUrl,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      'Instructor|${course.instructor}',
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: const Color.fromRGBO(119, 119, 119, 1)),
                    ),
                    const SizedBox(width: 120),
                    StarRating(rating: course.rating),
                    Text(
                      'Rate',
                      style: GoogleFonts.roboto(
                          color: const Color.fromRGBO(119, 119, 119, 1), fontSize: 16),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.title,
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${course.duration} Hours | ${course.modulesCount} Modules',
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Text(
                    course.description,
                    style: GoogleFonts.roboto(
                      color: const Color.fromRGBO(119, 119, 119, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(child: ModuleDisplay(course: course)),
                const SizedBox(height: 80), // Space for floating button
              ],
            ),
            
            // Floating Enroll Button
            Positioned(
              bottom: 20,
              left: 16,
              right: 16,
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: enrollmentState.isEnrolling
                      ? null
                      : () {
                          ref.read(enrollmentProvider.notifier).enrollInCourse(context, course);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(46, 204, 113, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: enrollmentState.isEnrolling
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Enroll Now', 
                          style: GoogleFonts.roboto(
                            color: Colors.white, 
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}