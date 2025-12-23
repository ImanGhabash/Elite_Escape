import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/view/login/widgets/login_avatar.dart';
import 'package:task/view/login/widgets/login_button.dart';
import 'package:task/view/login/widgets/password_field.dart';
import 'package:task/view/login/widgets/phone_field.dart';
import '../../../core/theme/app_colors.dart';
import '../../../controllers/auth_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

   ref.listen<AuthState>(authControllerProvider, (prev, next) {
  if (next is AuthError) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(next.message)));
  } else if (next is AuthSuccess) {
    Navigator.pushReplacementNamed(context, '/home');
  }
});

    return Scaffold(
      backgroundColor: AppColors.darkTeal,
      appBar: AppBar(
        backgroundColor: AppColors.darkTeal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            children: [
              const SizedBox(height: 20),
              const LoginAvatar(),
              PhoneField(controller: mobileController),
              PasswordField(
                controller: passwordController,
                visible: passwordVisible,
                onToggle: () =>
                    setState(() => passwordVisible = !passwordVisible),
              ),
              const SizedBox(height: 220),
              LoginButton(
                loading: authState is AuthLoading,
                onPressed: () {
                  if (mobileController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }
                  ref
                      .read(authControllerProvider.notifier)
                      .login(
                        mobile: mobileController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
