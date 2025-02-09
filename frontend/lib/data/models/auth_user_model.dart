import 'package:e_library/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  AuthUserModel({
    required String id,
    required String email,
    required String token,
  }) : super(id: id, email: email, token: token);

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['userId'],
      email: json['email'],
      token: json['token'],
    );
  }
}