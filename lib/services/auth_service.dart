import 'dart:io';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/login_response.dart';
import 'dio_service.dart';
import '../models/token_storage.dart';

class AuthService {
  final Dio _dio = DioService().dio;

  // ===== REGISTER =====
  Future<void> register({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String mobileNumber,
    required String password,
    required String role,
    required File identityCard,
    required File personalPhoto,
  }) async {
    final formData = FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'mobile_number': mobileNumber,
      'password': password,
      'password_confirmation': password,
      'role': role,
      'identity_card': await MultipartFile.fromFile(identityCard.path),
      'personal_photo': await MultipartFile.fromFile(personalPhoto.path),
    });

    await _dio.post('/register', data: formData);
  }

  // ===== LOGIN =====
  Future<LoginResponse> login({
    required String mobileNumber,
    required String password,
  }) async {
    final response = await _dio.post(
      '/login',
      data: {
        'mobile_number': mobileNumber,
        'password': password,
      },
    );

    final loginResponse = LoginResponse.fromJson(response.data);

    DioService().setToken(loginResponse.accessToken);
    await TokenStorage().saveToken(loginResponse.accessToken);

    return loginResponse;
  }

Future<User> getProfile() async {
    print('HEADERS قبل الطلب: ${_dio.options.headers}');
  final response = await _dio.get('/user/show-profile');
  return User.fromJson(response.data['user']);
}
}
