import 'package:bookia/features/auth/data/models/auth_response/user.dart';

class AuthResponseModel {
  final User user;
  final String token;

  const AuthResponseModel({required this.user, required this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}