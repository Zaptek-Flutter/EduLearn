import 'package:edulearn/application/services/user_progress_services.dart';
import 'package:edulearn/application/widgets/courseimage.dart';
import 'package:edulearn/application/widgets/star_rating.dart';
import 'package:edulearn/authentication/route/authstate.dart';
import 'package:edulearn/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FilteredCoursesWidget extends ConsumerStatefulWidget {
  final Course course;

  const FilteredCoursesWidget({super.key, required this.course});

  @override
  ConsumerState<FilteredCoursesWidget> createState() =>
      _FilteredCoursesWidgetState();
}

class _FilteredCoursesWidgetState extends ConsumerState<FilteredCoursesWidget> {
  bool _progressInitialized = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = ref.read(authProvider);
      final userId = authState.user?.uid ?? '';

      if (userId.isNotEmpty && !_progressInitialized) {
        ref.read(userProgressProvider.notifier).initializeProgress(
              userId,
              widget.course.id,
              widget.course.modulesCount,
            );

        setState(() {
          _progressInitialized = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final progressPercentage = ref
        .watch(userProgressProvider.notifier)
        .getProgressPercentage(widget.course.id);

    final completedModules =
        (progressPercentage / 100 * widget.course.modulesCount).round();

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  height: 220,
                  child: Courseimage(thumbnail: widget.course.thumbnailUrl),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 171,
                          child: Text(
                            widget.course.title,
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(
                          width: 160,
                        ),
                        Text(
                          '$completedModules/${widget.course.modulesCount}',
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Instructor | ${widget.course.instructor}',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: const Color.fromRGBO(119, 119, 119, 1),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                StarRating(rating: widget.course.rating),
                                const SizedBox(width: 4),
                                Text(
                                  widget.course.rating.toString(),
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromRGBO(119, 119, 119, 1),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                      height: 76,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),

                            child: LinearProgressIndicator(
                              value: progressPercentage / 100,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.orange),
                              minHeight: 10,
                            ),
                          ),
                          const SizedBox(height: 12,),
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
                                '${progressPercentage.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  const SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: 370,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to course content
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(46, 204, 113, 1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(68),
                          ),
                        ),
                        child: const Text(
                          'Continue Learning',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
