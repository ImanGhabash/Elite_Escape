import 'package:flutter/material.dart';
// import '../../../core/theme/app_colors.dart';

class LoginButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF254f5b),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: loading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Log in',
              style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}
