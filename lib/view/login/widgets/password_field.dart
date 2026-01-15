import 'package:flutter/material.dart';
import 'package:task/generated/l10n.dart';
import '../../../core/theme/app_colors.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool visible;
  final VoidCallback onToggle;

  const PasswordField({
    super.key,
    required this.controller,
    required this.visible,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkTeal, width: 3.5),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: visible,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: S.of(context).passowrd,
          suffixIcon: IconButton(
            icon: Icon(
              visible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.darkTeal,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }
}
