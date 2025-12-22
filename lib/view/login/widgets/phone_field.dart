import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkTeal, width: 3.5),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.phone, color: AppColors.darkTeal, size: 30),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your number',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
