import 'package:edulearn/application/screens/my_courses.dart';
import 'package:edulearn/application/widgets/course_tile_view.dart';
import 'package:edulearn/application/widgets/home_header.dart';
import 'package:edulearn/application/widgets/my_courses_list_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HomeHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Courses',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: const Color.fromRGBO(51, 51, 1, 1),
                ),
              ),
            ),
            const SingleChildScrollView(
              child: SizedBox(
                height: 280,
                child: CoursesListView(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyCourses()),
                ),
                style: TextButton.styleFrom(
                  textStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                  foregroundColor: const Color.fromRGBO(51, 51, 1, 1),
                ),
                child: const Text('My Courses'),
              ),
            ),
            const Expanded(
              child: MyCoursesList(),
            ),
          ],
        ),
      ),
    );
  }
}
