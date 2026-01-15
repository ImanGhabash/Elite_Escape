import 'package:flutter/material.dart';

import 'package:task/view/Rating_Widget/CommentInputWidget.dart';
import 'package:task/view/Rating_Widget/RatingStarsWidget.dart';
import 'package:task/view/Rating_Widget/SendButtonWidget.dart';
import 'package:task/models/Rating.dart';class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int selectedStars = 1;
  final TextEditingController commentController = TextEditingController();

  List<Rating> ratingsList = [];

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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
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
                onPressed: () {
                  Rating rating = Rating( 
                    stars: selectedStars,
                    comment: commentController.text,
                    userId: "user1",
                    apartmentId: "apt1",
                  );

                  setState(() {
                    ratingsList.add(rating);
                    commentController.clear();
                    selectedStars = 1;
                  });

                  print("Rating added");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}