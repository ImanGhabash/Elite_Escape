import 'package:flutter/material.dart';

class RatingStarsWidget extends StatelessWidget {
  final int selectedStars;
  final Function(int) onChanged;

  const RatingStarsWidget({
    super.key,
    required this.selectedStars,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            Icons.star,
            color: index < selectedStars ? Colors.amber : Colors.grey,
            size: 35,
          ),
          onPressed: () => onChanged(index + 1),
        );
      }),
    );
  }
}