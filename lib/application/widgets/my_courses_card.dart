import 'package:edulearn/application/services/user_progress_services.dart';
import 'package:edulearn/authentication/route/authstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/course.dart';

class MyCoursesCard extends ConsumerStatefulWidget {
  final Course course;

  const MyCoursesCard({
    super.key,
    required this.course,
  });

  @override
  ConsumerState<MyCoursesCard> createState() => _MyCoursesCardState();
}

class _MyCoursesCardState extends ConsumerState<MyCoursesCard> {
  bool _progressInitialized = false;

  @override
  void initState() {
    super.initState();
    
     WidgetsBinding.instance.addPostFrameCallback((_) {
    final authState = ref.read(authProvider);
    final userId = authState.user?.uid ?? '';
    
    if (userId.isNotEmpty && !_progressInitialized) {
      // Initialize progress with total modules count
      ref
          .read(userProgressProvider.notifier)
          .initializeProgress(
            userId, 
            widget.course.id, 
            widget.course.modulesCount
          );
      
      setState(() {
        _progressInitialized = true;
      });
    }
  });
  }

  

  @override
  Widget build(BuildContext context) {
    // Watch the progress percentage directly from the provider
    final progressPercentage = ref
        .watch(userProgressProvider.notifier)
        .getProgressPercentage(widget.course.id);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course thumbnail (unchanged)
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              widget.course.thumbnailUrl,
              width: 160,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 160,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),

          // Course details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.course.title,
                    style: GoogleFonts.roboto(
                        fontSize: 21, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    widget.course.description,
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: const Color.fromRGBO(119, 119, 119, 1)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Progress bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progressPercentage / 100, // Convert to 0-1 range
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.orange),
                            minHeight: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Complete',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            '${progressPercentage.toInt()}%',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Continue button (unchanged)
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 107.3,
                    height: 41.57,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to course content
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(68),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}