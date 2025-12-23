import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool visible;
  final String hint;
  final VoidCallback? onToggle;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    required this.controller,
    required this.visible,
    required this.hint,
    this.onToggle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.darkTeal, width: 4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: visible,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: onToggle != null
              ? IconButton(
                  icon: Icon(
                    visible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.darkTeal,
                  ),
                  onPressed: onToggle,
                )
              : null,
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
      ),
    );
  }
}
