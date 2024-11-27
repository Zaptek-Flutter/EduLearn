// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCoursesFilter extends StatefulWidget {
  const MyCoursesFilter({super.key});

  @override
  _MyCoursesFilterState createState() => _MyCoursesFilterState();
}

class _MyCoursesFilterState extends State<MyCoursesFilter> {
  // List of filter options
  final List<String> filterOptions = [
    'All', 
    'Progress', 
    'Finished', 
    'New', 
    'Trending'
  ];

  // Currently selected filter
  int _selectedFilterIndex = 0;

  // Method to fetch feed based on selected filter
  void _fetchFeedForFilter(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
    
    // Here you would typically call a method to fetch the feed
    // For example:
    switch (filterOptions[index]) {
      case 'All':
        print('Fetching all courses');
        break;
      case 'Progress':
        print('Fetching in-progress courses');
        break;
      case 'Finished':
        print('Fetching finished courses');
        break;
      case 'New':
        print('Fetching new courses');
        break;
      case 'Trending':
        print('Fetching trending courses');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, 
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(filterOptions.length, (index) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () => _fetchFeedForFilter(index),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(minWidth: 57),
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: _selectedFilterIndex == index 
                          ? Colors.orange 
                          : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        filterOptions[index],
                        style: GoogleFonts.inter(
                          color: _selectedFilterIndex == index 
                              ? Colors.white 
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                if (index < filterOptions.length - 1)
                  const SizedBox(width: 20),
              ],
            );
          }),
        ),
      ),
    );
  }
}