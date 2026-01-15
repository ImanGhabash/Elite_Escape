import 'package:flutter/material.dart';

class CommentInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const CommentInputWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        maxLines: 3,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Write your opinion about the apartment",
        ),
      ),
    );
  }
}