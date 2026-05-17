import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class RatingWidget extends StatelessWidget {
  final int rating;
  final double size;
  final ValueChanged<int>? onRatingSelected;

  const RatingWidget({
    super.key,
    required this.rating,
    this.size = 24,
    this.onRatingSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: onRatingSelected != null
              ? () => onRatingSelected!(index + 1)
              : null,
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: AppColors.accentOrange,
            size: size,
          ),
        );
      }),
    );
  }
}
