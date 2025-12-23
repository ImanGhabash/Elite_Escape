import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

/* UserRole enum */
enum UserRole { owner, tenant }

/* CONTROLLER PROVIDER */
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(AuthInitial());

  final AuthService _authService = AuthService();

  Future<void> login({
    required String mobile,
    required String password,
    // required UserRole role,
  }) async {
    state = AuthLoading();
    try {
      final result = await _authService.login(
        mobileNumber: mobile,
        password: password,
        // role: role.toString().split('.').last,
      );
      state = AuthSuccess(result.user);
    } catch (e) {
    // طباعة الخطأ على الـ console
    print("Login failed: $e");
    
    // عرض الخطأ مع الرسالة الحقيقية
    state = AuthError(e.toString());
  }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String dob,
    required String mobile,
    required String password,
    required UserRole role,
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
        role: role.toString().split('.').last,
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
