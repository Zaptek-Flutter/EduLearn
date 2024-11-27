import 'package:edulearn/application/widgets/home_head.dart';
import 'package:edulearn/application/widgets/my_courses_list_view.dart';
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
            SizedBox(height: 10,),
              Expanded(
              child: MyCoursesList(),
            )
            
          ],
        ),
      ),
    );
  }
}
