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
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenSize.height - MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: isSmallScreen ? 10 : 20),
                    // Header section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8 : 16,
                        vertical: 8,
                      ),
                      width: double.infinity,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Back button and text
                              Flexible(
                                flex: 2,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: Image.asset(
                                        'assets/icons/back.png',
                                        width: 30,
                                      ),
                                    ),
                                    Text('Back',
                                        style: GoogleFonts.roboto(
                                            color: const Color.fromRGBO(230, 126, 34, 1))),
                                  ],
                                ),
                              ),
                              // Notification and profile icons
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () => print("Notifications"),
                                      icon: Image.asset(
                                        'assets/icons/notification.png',
                                        width: 24,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _showProfileModal(context),
                                      icon: Image.asset(
                                        'assets/icons/user.png',
                                        width: 24,
                                        color: const Color.fromRGBO(230, 126, 34, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // Course image
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8 : 16,
                        vertical: 8,
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Courseimage(thumbnail: course.thumbnailUrl),
                      ),
                    ),
                    // Instructor and rating
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8 : 20,
                        vertical: 8,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Instructor|${course.instructor}',
                                  style: GoogleFonts.roboto(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    color: const Color.fromRGBO(119, 119, 119, 1),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  StarRating(rating: course.rating),
                                  const SizedBox(width: 4),
                                  Text(
                                    course.rating.toString(),
                                    style: GoogleFonts.roboto(
                                      color: const Color.fromRGBO(119, 119, 119, 1),
                                      fontSize: isSmallScreen ? 14 : 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // Course title and duration
                    Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 8 : 16),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 151,
                                child: Text(
                                course.title,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: isSmallScreen ? 20 : 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              ),
                              const SizedBox(width: 115,),
                              Text(
                                '${course.duration} Hours | ${course.modulesCount} Modules',
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: isSmallScreen ? 16 : 18,
                                ),
                              ),
                              
                            ],
                          );
                        },
                      ),
                    ),
                    // Course description
                    Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 8 : 16),
                      child: Text(
                        course.description,
                        style: GoogleFonts.roboto(
                          color: const Color.fromRGBO(119, 119, 119, 1),
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                    ),
                    // Module display
                    SizedBox(
                      height: screenSize.height * 0.4,
                      child: ModuleDisplay(course: course),
                    ),
                    SizedBox(height: isSmallScreen ? 60 : 80),
                  ],
                ),
              ),
            ),
            // Floating Enroll Button
            Positioned(
              bottom: isSmallScreen ? 16 : 20,
              left: isSmallScreen ? 12 : 16,
              right: isSmallScreen ? 12 : 16,
              child: Container(
                width: double.infinity,
                height: isSmallScreen ? 50 : 60,
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
                      borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 25),
                    ),
                  ),
                  child: enrollmentState.isEnrolling
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Enroll Now',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.bold,
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