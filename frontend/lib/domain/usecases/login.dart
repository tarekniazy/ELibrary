import 'package:e_library/domain/entities/auth_user.dart';
import 'package:e_library/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<AuthUser> execute(String email, String password) async {
    return await repository.login(email, password);
  }
}