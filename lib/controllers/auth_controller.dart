import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(AuthInitial());

  final AuthService _authService = AuthService();

  Future<void> login(String mobile, String password) async {
    state = AuthLoading();
    try {
      final result = await _authService.login(
        mobileNumber: mobile,
        password: password,
      );
      state = AuthSuccess(result.user);
    } catch (e) {
      state = AuthError('Login failed');
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String dob,
    required String mobile,
    required String password,
    required File idCard,
    required File personalPhoto,
  }) async {
    state = AuthLoading();
    try {
      await _authService.register(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dob,
        mobileNumber: mobile,
        password: password,
        role: 'tenant',
        identityCard: idCard,
        personalPhoto: personalPhoto,
      );
      state = AuthRegistered();
    } catch (e) {
      state = AuthError('Register failed');
    }
  }
}

/* STATES */

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

class AuthRegistered extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
