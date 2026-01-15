import 'package:dio/dio.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;
  DioService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8000/api',
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
  }

  late final Dio dio;

  void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    dio.options.headers.remove('Authorization');
  }
}
