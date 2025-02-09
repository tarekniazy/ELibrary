
import 'package:e_library/data/datasources/auth_remote_data_source.dart';
import 'package:e_library/domain/entities/auth_user.dart';
import 'package:e_library/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthUser> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<AuthUser> register(String email, String password, String confirmPassword) async {
    return await remoteDataSource.register(email, password, confirmPassword);
  }

  @override
  Future<void> logout(String token) async {
    await remoteDataSource.logout( token);
  }
}