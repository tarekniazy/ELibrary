import 'package:e_library/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  AuthUserModel({
    required String email,
    required String token,
  }) : super(email: email, token: token);

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      email: json['email'],
      token: json['token'],
    );
  }
}