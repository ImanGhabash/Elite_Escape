import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../login/login_screen.dart';
import '../signup/signup_screen.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

@override
Widget build(BuildContext context) {
  return Container(
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
    child: Stack(
      children: [
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Center(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'images/logo_buildings.png',
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _actionButton(
                context,
                title: 'Log In',
                page: const LoginScreen(),
              ),
              const SizedBox(height: 60),
              _actionButton(
                context,
                title: 'Sign Up',
                page: const SignUpScreen(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  Widget _actionButton(BuildContext context,
      {required String title, required Widget page}) {
    return SizedBox(
      width: 200,
      height: 90,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => page));
        },
        child: Text(title, style: const TextStyle(fontSize: 25)),
      ),
    );
  }
}
