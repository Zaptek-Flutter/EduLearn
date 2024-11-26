import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCoursesFilter extends StatelessWidget {
  const MyCoursesFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: 57,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey,
          ),
          child: Text('All',style: GoogleFonts.inter(color: Colors.black),),
        )
      ],
    ),
      
    );
  }
}