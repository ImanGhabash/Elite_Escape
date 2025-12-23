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
  File? idImage;
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

  Future<void> pickIdImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      setState(() => idImage = File(picked.path));
    }
  }

  void _showImageSourceActionSheet(BuildContext context, Function(ImageSource) onPick) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                onPick(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                onPick(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
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

                  PhoneField(
                    controller: phoneController,
                    hint: 'Please enter your number',
                  ),
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

                  // صورة الهوية
                  InkWell(
                    onTap: () => _showImageSourceActionSheet(context, pickIdImage),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        border: Border.all(color: Color(0xFF285260), width: 3.5),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: idImage == null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Add identity photo',
                                  style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
                                ),
                                const Icon(
                                  Icons.add_a_photo,
                                  color: Color(0xFF285260),
                                  size: 28,
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: Image.file(
                                idImage!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // اختيار الدور
                  RoleSelector(
                    selectedRole: selectedRole,
                    onSelect: (role) => setState(() => selectedRole = role),
                  ),
                  const SizedBox(height: 20),

                  // زر التسجيل
                  SignUpButton(
                    onPressed: () {
                      if (profileImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please choose personal photo')),
                        );
                        return;
                      }
                      if (idImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please choose identity photo')),
                        );
                        return;
                      }
                      if (selectedRole == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please choose role')),
                        );
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        // تنفيذ عملية التسجيل هنا
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
