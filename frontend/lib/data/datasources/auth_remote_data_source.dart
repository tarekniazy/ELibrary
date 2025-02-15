import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:e_library/data/models/auth_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> login(String email, String password);
  Future<AuthUserModel> register(String email, String password, String confirmPassword);
  Future<void> logout(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'http://108.129.133.132:80/api/Auth';

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthUserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return AuthUserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<AuthUserModel> register(String email, String password, String confirmPassword) async {
    final response = await client.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      return AuthUserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

    @override
  Future<void> logout(String token) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',

        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to logout');
      }
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
}