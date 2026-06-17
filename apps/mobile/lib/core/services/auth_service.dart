import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio;

  AuthService() : _dio = Dio(BaseOptions(
    baseUrl: Platform.isAndroid
        ? 'http://10.0.2.2:8082/api/auth'
        : 'http://localhost:8082/api/auth',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  static const String _tokenKey = 'jwt_token';

  Future<bool> login(String username, String password) async {
    try {
      print('Sending login request to ${Platform.isAndroid ? 'http://10.0.2.2:8082/api/auth/login' : 'http://localhost:8082/api/auth/login'}');
      final response = await _dio.post('/login', data: {
        'username': username,
        'password': password,
      });

      print('Login response status: ${response.statusCode}');
      print('Login response data: ${response.data}');

      if (response.statusCode == 200 && response.data['access_token'] != null) {
        final token = response.data['access_token'] as String;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, token);
        print('Login successful, token saved.');
        return true;
      }
      print('Login failed: status code ${response.statusCode} or token is null');
      return false;
    } catch (e) {
      print('Login failed with exception: $e');
      return false;
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
