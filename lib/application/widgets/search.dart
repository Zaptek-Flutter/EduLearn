// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 50,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(15, 12, 128, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => print('Search'),
            child: Container(
              width: 290,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Search Courses',
                    style: GoogleFonts.inter(color: Colors.black),
                  ),
                  const SizedBox(
                    width: 141,
                  ),
                  IconButton(
                      onPressed: () => print('Search'),
                      icon: const Icon(
                        Icons.search,
                        color: Colors.orange,
                      ))
                ],
              ),
            ),
          ),
          const SizedBox(width: 20,),
          GestureDetector(onTap: () => print('Category'),
          child: Container(
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Image.asset('assets/icons/categry.png', width: 44,),
            ),
          ),) 
        ],
      ),
    );
  }
}
