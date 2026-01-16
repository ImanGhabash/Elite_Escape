import 'package:flutter/material.dart';
import 'package:task/generated/l10n.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignUpButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0XFF52878b),
        padding:
            const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child:  Text( S.of(context).signup,
          style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}
