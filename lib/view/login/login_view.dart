import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/generated/l10n.dart';
import 'package:task/main.dart';
import 'package:task/services/dio_service.dart';
import 'package:task/view/login/widgets/login_avatar.dart';
import 'package:task/view/login/widgets/login_button.dart';
import 'package:task/view/login/widgets/password_field.dart';
import 'package:task/view/login/widgets/phone_field.dart';
import '../../../core/theme/app_colors.dart';
import '../../../controllers/auth_controller.dart';

final tokenProvider = StateProvider<String?>((ref) => null);

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
   
    ref.listen<AuthState>(authControllerProvider, (prev, next) async {
      // print('AUTH STATE CHANGED: $next');

      if (next is AuthError) {
        // print('AUTH ERROR');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }

      if (next is AuthSuccess) {
        // print('AUTH SUCCESS');
        final token = next.token;
        // print('TOKEN: $token');
  DioService().setToken(token);
        ref.read(tokenProvider.notifier).state = token;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        // print('TOKEN SAVED');

        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const BottomNavBar()),
        );
      }
    });

    final authState = ref.watch(authControllerProvider);

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
                  // print('LOGIN BUTTON PRESSED');

                  if (mobileController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text(S.of(context).fill_field)),
                    );
                    return;
                  }

                  // print('CALLING LOGIN API');
                  ref.read(authControllerProvider.notifier).login(
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
