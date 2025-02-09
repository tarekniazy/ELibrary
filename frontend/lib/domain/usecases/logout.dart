import 'package:e_library/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepository repository;

  Logout(this.repository);

  Future<void> execute(String token) async {
    return await repository.logout(token);
  }
}