import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/models/token_storage.dart';
import 'package:task/services/dio_service.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

enum UserRole { owner, tenant }

// =================== PROVIDER ===================
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(),
);

// =================== CONTROLLER ===================
class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(AuthInitial());

  final AuthService _authService = AuthService();

  // =================== LOGIN ===================
  Future<void> login({
    required String mobile,
    required String password,
  }) async {
    state = AuthLoading();

    try {
      final result = await _authService.login(
        mobileNumber: mobile,
        password: password,
      );

      await TokenStorage().saveToken(result.accessToken);
      DioService().setToken(result.accessToken);

      state = AuthSuccess(
        user: result.user,
        token: result.accessToken,
      );
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  // =================== REGISTER ===================
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
      state = AuthError(e.toString());
    }
  }



  // =================== LOGOUT ===================
  Future<void> logout() async {
    await TokenStorage().deleteToken();
    DioService().clearToken();
    state = AuthInitial();
  }
}

// =================== AUTH STATES ===================
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  final String token;

  AuthSuccess({
    required this.user,
    required this.token,
  });
}

class AuthRegistered extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
