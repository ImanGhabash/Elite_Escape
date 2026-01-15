import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/main.dart';

import 'package:task/view/welcome/welcome_screen.dart';
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final token = snapshot.data;

        if (token != null && token.isNotEmpty) {
          Future.microtask(() {
            ref.read(tokenProvider.notifier).state = token;
          });

          return const BottomNavBar();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
