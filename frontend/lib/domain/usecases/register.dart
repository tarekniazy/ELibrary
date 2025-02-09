import 'package:e_library/domain/entities/auth_user.dart';
import 'package:e_library/domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<AuthUser> execute(String email, String password, String confirmPassword) async {
    return await repository.register(email, password, confirmPassword);
  }
}