import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        hintText: 'Phone Number',
        prefixIcon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Phone number is required';
        }
        return null;
      },
    );
  }
}