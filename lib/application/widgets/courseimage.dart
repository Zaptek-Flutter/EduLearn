import 'package:flutter/material.dart';

class Courseimage extends StatelessWidget {
  final String thumbnail;
  final double width;
  final double height;
  final double borderRadius;
  const Courseimage({
    super.key,
    required this.thumbnail,
    this.width = double.infinity,
    this.height = 251,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        thumbnail,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(
                Icons.error_outline,
                size: 40,
                color: Colors.grey,
              ),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
