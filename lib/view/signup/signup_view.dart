import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/profile_image_picker.dart';
import 'widgets/text_input_field.dart';
import 'widgets/phone_field.dart';
import 'widgets/birthday_field.dart';
import 'widgets/password_field.dart';
import 'widgets/role_selector.dart';
import 'widgets/signup_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  File? profileImage;
  UserRole? selectedRole;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool passwordVisible = true;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      setState(() => profileImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF254f5b),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkTeal,
              AppColors.mediumTeal,
              AppColors.lightAqua,
              AppColors.tanBrown,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ProfileImagePicker(
                    image: profileImage,
                    onPick: pickImage,
                  ),
                  const SizedBox(height: 20),

                  TextInputField(
                    hint: 'First Name',
                    controller: firstNameController,
                    validatorText: 'Please enter first name',
                  ),
                  const SizedBox(height: 27),

                  TextInputField(
                    hint: 'Last Name',
                    controller: lastNameController,
                    validatorText: 'Please enter last name',
                  ),
                  const SizedBox(height: 27),

                  PhoneField(controller: phoneController),
                  const SizedBox(height: 27),

                  BirthdayField(controller: dateController),
                  const SizedBox(height: 27),

                  PasswordField(
                    controller: passwordController,
                    visible: passwordVisible,
                    hint: 'Enter your password',
                    onToggle: () =>
                        setState(() => passwordVisible = !passwordVisible),
                  ),
                  const SizedBox(height: 27),

                  PasswordField(
                    controller: confirmPasswordController,
                    visible: passwordVisible,
                    hint: 'Confirm your password',
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 27),

                  RoleSelector(
                    selectedRole: selectedRole,
                    onSelect: (role) =>
                        setState(() => selectedRole = role),
                  ),

                  const SizedBox(height: 20),

                  SignUpButton(
                    onPressed: () {
                      if (profileImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('please choise personal photo')),
                        );
                        return;
                      }
                      if (selectedRole == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('please choise role')),
                        );
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        // submit
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
