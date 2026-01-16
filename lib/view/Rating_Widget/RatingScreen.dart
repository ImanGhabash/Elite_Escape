import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:task/controllers/rating_controller.dart';
import 'package:task/view/Rating_Widget/CommentInputWidget.dart';
import 'package:task/view/Rating_Widget/RatingStarsWidget.dart';
import 'package:task/view/Rating_Widget/SendButtonWidget.dart';

class RatingScreen extends ConsumerStatefulWidget {
  final int apartmentId;

  const RatingScreen({
    super.key,
    required this.apartmentId,
  });

  @override
  ConsumerState<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends ConsumerState<RatingScreen> {
  int selectedStars = 1;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xffb7e4d8),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Rate your Experience",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              RatingStarsWidget(
                selectedStars: selectedStars,
                onChanged: (value) {
                  setState(() {
                    selectedStars = value;
                  });
                },
              ),

              const SizedBox(height: 12),

              CommentInputWidget(
                controller: commentController,
              ),

              const SizedBox(height: 20),

         SendButtonWidget(
  onPressed: () async {
    try {
      await ref.read(reviewServiceProvider).addReview(
        apartmentId: widget.apartmentId,
        rating: selectedStars,
        comment: commentController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your review has been submitted successfully.'),
          backgroundColor: Colors.green,
        ),
      );

      commentController.clear();
      setState(() {
        selectedStars = 1;
      });

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("can't send your review because you have not booked it before"),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
),
            ],
          ),
        ),
      ),
    );
  }
}

