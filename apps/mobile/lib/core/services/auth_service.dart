import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  static const String _tokenKey = 'jwt_token';
  // Standard Web API Key for the Firebase Project
  static const String _firebaseApiKey = 'AIzaSyPlaceholderKey12345';

  Future<bool> login(String email, String password) async {
    try {
      final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseApiKey';
      final response = await _dio.post(url, data: {
        'email': email,
        'password': password,
        'returnSecureToken': true,
      });

      if (response.statusCode == 200 && response.data['idToken'] != null) {
        final token = response.data['idToken'] as String;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, token);
        return true;
      }
      return false;
    } catch (e) {
      print('Firebase login failed: $e');
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      if (idToken == null) return false;

      return await _exchangeSocialToken(idToken, 'google.com');
    } catch (e) {
      print('Google Sign-In failed: $e');
      return false;
    }
  }

  Future<bool> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final String? idToken = credential.identityToken;
      if (idToken == null) return false;

      return await _exchangeSocialToken(idToken, 'apple.com');
    } catch (e) {
      print('Apple Sign-In failed: $e');
      return false;
    }
  }

  Future<bool> _exchangeSocialToken(String idToken, String providerId) async {
    try {
      final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=$_firebaseApiKey';
      final response = await _dio.post(url, data: {
        'postBody': 'id_token=$idToken&providerId=$providerId',
        'requestUri': 'http://localhost',
        'returnSecureToken': true,
      });

      if (response.statusCode == 200 && response.data['idToken'] != null) {
        final token = response.data['idToken'] as String;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, token);
        return true;
      }
      return false;
    } catch (e) {
      print('Token exchange failed: $e');
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

  // Helper to parse role claim from JWT
  Future<String> getUserRole() async {
    final token = await getToken();
    if (token == null) return 'FARM_WORKER';
    try {
      final parts = token.split('.');
      if (parts.length < 2) return 'FARM_WORKER';
      
      // Decode base64 URL payload
      String normalized = base64Url.normalize(parts[1]);
      String payload = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> claims = json.decode(payload);
      
      return claims['role'] == 'ADMIN' ? 'ADMIN' : 'FARM_WORKER';
    } catch (e) {
      print('Failed to parse role: $e');
      return 'FARM_WORKER';
    }
  }

  Future<String> getUserEmail() async {
    final token = await getToken();
    if (token == null) return '';
    try {
      final parts = token.split('.');
      if (parts.length < 2) return '';
      
      String normalized = base64Url.normalize(parts[1]);
      String payload = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> claims = json.decode(payload);
      
      return claims['email'] ?? '';
    } catch (e) {
      return '';
    }
  }
}
