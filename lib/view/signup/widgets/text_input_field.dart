
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TextInputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String validatorText;

  const TextInputField({
    super.key,
    required this.hint,
    required this.controller,
    required this.validatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.darkTeal, width: 4),
        ),
        padding: const EdgeInsets.only(left: 20),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorText;
            }
            return null;
          },
        ),
      ),
    );
  }
}
