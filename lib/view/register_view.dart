import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final first = TextEditingController();
    final last = TextEditingController();
    final dob = TextEditingController();
    final mobile = TextEditingController();
    final pass = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: first, decoration: const InputDecoration(labelText: 'First name')),
            TextField(controller: last, decoration: const InputDecoration(labelText: 'Last name')),
            TextField(controller: dob, decoration: const InputDecoration(labelText: 'Date of birth')),
            TextField(controller: mobile, decoration: const InputDecoration(labelText: 'Mobile')),
            TextField(controller: pass, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).register(
                      firstName: first.text,
                      lastName: last.text,
                      dob: dob.text,
                      mobile: mobile.text,
                      password: pass.text,
                      idCard: File('path'),
                      personalPhoto: File('path'),
                    );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
