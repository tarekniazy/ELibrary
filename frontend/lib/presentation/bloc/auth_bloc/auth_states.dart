import 'package:e_library/domain/entities/auth_user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final AuthUser user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
