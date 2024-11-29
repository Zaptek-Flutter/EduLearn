// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:edulearn/application/screens/my_courses.dart';
import 'package:edulearn/application/widgets/course_tile_view.dart';
import 'package:edulearn/application/widgets/home_header.dart';
import 'package:edulearn/application/widgets/my_courses_list_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a provider to manage the refresh state if needed
final homeRefreshProvider = StateProvider<bool>((ref) => false);

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  // Key to control the refresh indicator
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    // Any initial setup can be done here
  }

  // Method to handle refresh
  Future<void> _onRefresh() async {
    try {
      // Start refresh operation and print status to terminal
      print("Refreshing data...");

      // Simulate a refresh operation (you can replace this with actual refresh logic later)
      await Future.delayed(const Duration(seconds: 2));

      // Show a Snackbar to indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Refresh completed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      print("Refresh completed successfully!");
    } catch (e) {
      // Log any errors and show a Snackbar to indicate failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Refresh failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      print("Refresh failed: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the refresh provider if you want to trigger UI updates

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _onRefresh, // Trigger the refresh method
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
              const SizedBox(
                height: 280,
                child: CoursesListView(),
              ),
              const SizedBox(height: 20),
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
              // Wrap MyCoursesList with Expanded to take up remaining space
              const Expanded(
                child: MyCoursesList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
