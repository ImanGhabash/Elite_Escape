import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/controllers/auth_controller.dart'; // فيه UserRole و authControllerProvider
import 'package:task/generated/l10n.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/profile_image_picker.dart';
import 'widgets/text_input_field.dart';
import 'widgets/phone_field.dart';
import 'widgets/birthday_field.dart';
import 'widgets/password_field.dart';
import 'widgets/role_selector.dart';
import 'widgets/signup_button.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  File? profileImage;
  File? idImage;
  UserRole? selectedRole;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool passwordVisible = true;

  Future<void> pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) setState(() => profileImage = File(picked.path));
  }

  Future<void> pickIdImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) setState(() => idImage = File(picked.path));
  }

  void _showImageSourceActionSheet(BuildContext context, Function(ImageSource) onPick) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title:  Text( S.of(context).gallery),
              onTap: () {
                Navigator.of(context).pop();
                onPick(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title:  Text( S.of(context).camera),
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
    ref.listen<AuthState>(authControllerProvider, (prev, next) {
      if (next is AuthError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.message)));
      }else if (next is AuthRegistered) {
  ScaffoldMessenger.of(context).showSnackBar(
   SnackBar(
      content: Text(
         S.of(context).account_created_waiting_for_admin)
    ),
  );
  Navigator.pop(context); // رجوع لصفحة login

        _clearForm();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF254f5b),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text( S.of(context).signup),
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
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ProfileImagePicker(image: profileImage, onPick: pickImage),
                const SizedBox(height: 20),
                TextInputField(
                  hint:  S.of(context).first_name,
                  controller: firstNameController,
                  validatorText:  S.of(context).please_first,
                ),
                const SizedBox(height: 20),
                TextInputField(
                  hint:  S.of(context).last_name,
                  controller: lastNameController,
                  validatorText:  S.of(context).please_last,
                ),
                const SizedBox(height: 20),
                PhoneField(controller: phoneController, hint:  S.of(context).enter_phone),
                const SizedBox(height: 20),
                BirthdayField(controller: dateController),
                const SizedBox(height: 20),
                PasswordField(
                  controller: passwordController,
                  visible: passwordVisible,
                  hint:  S.of(context).password,
                  onToggle: () => setState(() => passwordVisible = !passwordVisible),
                ),
                const SizedBox(height: 20),
                PasswordField(
                  controller: confirmPasswordController,
                  visible: passwordVisible,
                  hint:  S.of(context).confirm_password,
                  validator: (value) {
                    if (value != passwordController.text) return  S.of(context).passwords_match;
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildIdCardPicker(),
                const SizedBox(height: 20),
                RoleSelector(
                  selectedRole: selectedRole,
                  onSelect: (role) => setState(() => selectedRole = role),
                ),
                const SizedBox(height: 20),
                SignUpButton(onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIdCardPicker() {
    return InkWell(
      onTap: () => _showImageSourceActionSheet(context, pickIdImage),
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white38,
          border: Border.all(color: const Color(0xFF285260), width: 3.5),
          borderRadius: BorderRadius.circular(40),
        ),
        child: idImage == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( S.of(context).add_identity, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                  const Icon(Icons.add_a_photo, color: Color(0xFF285260), size: 28),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.file(idImage!, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
              ),
      ),
    );
  }

  void _submit() {
    if (profileImage == null) {
      _showSnack( S.of(context).please_personal_photo);
      return;
    }
    if (idImage == null) {
      _showSnack( S.of(context).please_identity_photo);
      return;
    }
    if (selectedRole == null) {
      _showSnack( S.of(context).please_role);
      return;
    }
    if (_formKey.currentState!.validate()) {
      ref.read(authControllerProvider.notifier).register(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            dob: dateController.text.trim(),
            mobile: phoneController.text.trim(),
            password: passwordController.text.trim(),
            idCard: idImage!,
            personalPhoto: profileImage!,
            role: selectedRole!,
          );
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    dateController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    setState(() {
      profileImage = null;
      idImage = null;
      selectedRole = null;
    });
  }
}
