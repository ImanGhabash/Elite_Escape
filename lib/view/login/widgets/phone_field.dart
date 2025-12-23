import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({
    super.key,
    required this.controller,
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
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter your number',
          prefixIcon: Icon(
            Icons.phone,
            color: AppColors.darkTeal,
          ),
        ),
      ),
    );
  }
}
