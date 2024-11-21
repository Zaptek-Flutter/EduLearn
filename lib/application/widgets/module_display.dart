import 'package:edulearn/application/widgets/module_list_view.dart';
import 'package:edulearn/models/course.dart';
import 'package:flutter/material.dart';

class ModuleDisplay extends StatelessWidget {
  final Course course;
  const ModuleDisplay({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              border: Border(top: BorderSide(color: Color.fromRGBO(15, 12, 128, 1)))

              
              ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Center(
            child: Image.asset("assets/icons/drag.png", width: 74,),
          ),
          // Add Module list view here
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: ModulesListView(course: course),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
