import 'package:edulearn/application/widgets/home_head.dart';
import 'package:edulearn/application/widgets/my_courses_filter.dart';
import 'package:flutter/material.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HomeHead(),
            Stack(
              children: [
                Positioned(
                  top: 100,
                  left: 10,
                  child: MyCoursesFilter(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
