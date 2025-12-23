import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class LoginAvatar extends StatelessWidget {
  const LoginAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.tanBrown,
          radius: 125,
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 120,
            child: Icon(Icons.person, size: 100, color: AppColors.tanBrown),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
