import 'user_model.dart';

class LoginResponse {
  final String message;
  final String accessToken;
  final User user;

  LoginResponse({
    required this.message,
    required this.accessToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      accessToken: json['access_token'],
      user: User.fromJson(json['data']),
    );
  }
}