import 'package:flutter/material.dart';
import 'package:task/generated/l10n.dart';
import '../../../core/theme/app_colors.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;

  const PhoneField({
    super.key,
    required this.controller,
    required this.hint,
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
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: const Icon(
            Icons.phone,
            color: AppColors.darkTeal,
          ),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return  S.of(context).phone_required;
              }
              return null;
            },
      ),
    );
  }
}
