import 'package:e_library/domain/usecases/logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:e_library/domain/usecases/login.dart';
import 'package:e_library/domain/usecases/register.dart';

import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final Logout logout;
  final FlutterSecureStorage storage;

  AuthBloc({required this.login, required this.register,required this.logout,required this.storage,}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    
    emit(AuthLoading());
    try {
      final user = await login.execute(event.email, event.password);
      
      // Save token to secure storage
      await storage.write(key: 'auth_token', value: user.token);
      await storage.write(key: 'user_id', value: user.id);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await register.execute(
        event.email,
        event.password,
        event.confirmPassword,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  
    Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
      final token = await storage.read(key: 'auth_token');

    emit(AuthLoading());
    try {
      await logout.execute(token!);
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}