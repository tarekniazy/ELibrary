import 'package:e_library/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login(String email, String password);
  Future<AuthUser> register(String email, String password, String confirmPassword);
  Future<void> logout(String token);
}