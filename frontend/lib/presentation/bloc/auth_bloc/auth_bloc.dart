import 'package:e_library/domain/usecases/logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:e_library/domain/usecases/login.dart';
import 'package:e_library/domain/usecases/register.dart';

import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final Logout logout;

  AuthBloc({required this.login, required this.register, required this.logout}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await login.execute(event.email, event.password);
      final prefs = await SharedPreferences.getInstance();
      
      // Save token to shared preferences
      await prefs.setString('auth_token', user.token);
      await prefs.setString('user_id', user.id);
      
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
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    
    emit(AuthLoading());
    try {
      if (token != null) {
        await logout.execute(token);
      }
      
      await prefs.remove('auth_token');
      await prefs.remove('user_id');
      
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
