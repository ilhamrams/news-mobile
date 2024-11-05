// models/login_response.dart
class LoginResponse {
  final bool success;
  final String message;
  final String? accessToken;
  final String? email;

  LoginResponse({
    required this.success,
    required this.message,
    this.accessToken,
    this.email,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      message: json['message'],
      accessToken: json['data']?['access_token'],
      email: json['data']?['email'],
    );
  }
}
