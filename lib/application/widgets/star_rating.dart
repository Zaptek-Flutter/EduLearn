import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating; 
  final double starSize;
  final Color color;

  const StarRating({
    super.key,
    required this.rating,
    this.starSize = 16,
    this.color = const Color.fromRGBO(230, 126, 34, 1),
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        // Full star
        stars.add(Icon(Icons.star, size: starSize, color: color));
      } else if (i - rating <= 0.5) {
        // Half star
        stars.add(Icon(Icons.star_half, size: starSize, color: color));
      } else {
        // Empty star
        stars.add(Icon(Icons.star_border, size: starSize, color: color));
      }
    }
    return Row(children: stars);
  }
}
