import 'package:edulearn/application/widgets/module_card.dart';
import 'package:flutter/material.dart';
import 'package:edulearn/models/course.dart';

class ModulesListView extends StatelessWidget {
  final Course course;

  const ModulesListView({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: course.modules.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final module = course.modules[index];
            return ModuleCard(module: module);
          },
        ),
      ],
    );
  }
}