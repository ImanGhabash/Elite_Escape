import 'package:flutter/material.dart';

class SendButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const SendButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff6ec1b4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 12,
        ),
        elevation: 8,
      ),
      onPressed: onPressed,
      child: const Text(
        "Send",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}