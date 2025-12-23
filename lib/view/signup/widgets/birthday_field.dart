import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';

class BirthdayField extends StatelessWidget {
  final TextEditingController controller;

  const BirthdayField({super.key, required this.controller});

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy/MM/dd').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.darkTeal, width: 4),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () => _pickDate(context),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Birthday Date',
          prefixIcon:
              Icon(Icons.calendar_today, color: AppColors.darkTeal),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter date of birth';
          }
          return null;
        },
      ),
    );
  }
}
