import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:farm_recorder_mobile/core/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDio extends Mock implements Dio {}

String createMockJwt(Map<String, dynamic> claims) {
  final header = base64Url.encode(utf8.encode(json.encode({"alg": "RS256", "typ": "JWT"})));
  final payload = base64Url.encode(utf8.encode(json.encode(claims)));
  final signature = base64Url.encode(utf8.encode("signature"));
  return "$header.$payload.$signature";
}

void main() {
  late AuthService authService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    authService = AuthService(dio: mockDio);
    SharedPreferences.setMockInitialValues({});
  });

  group('AuthService', () {
    test('signUp returns true and saves token on success', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {'idToken': 'mock-id-token'},
      );

      when(() => mockDio.post<dynamic>(
        any(),
        data: any(named: 'data'),
      )).thenAnswer((_) async => response);

      final result = await authService.signUp('test@example.com', 'password123');

      expect(result, isTrue);
      final token = await authService.getToken();
      expect(token, equals('mock-id-token'));
    });

    test('signUp returns false on failure status code', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 400,
        data: {'error': 'User already exists'},
      );

      when(() => mockDio.post<dynamic>(
        any(),
        data: any(named: 'data'),
      )).thenAnswer((_) async => response);

      final result = await authService.signUp('test@example.com', 'password123');

      expect(result, isFalse);
    });

    test('signUp returns false on dio exception', () async {
      when(() => mockDio.post<dynamic>(
        any(),
        data: any(named: 'data'),
      )).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result = await authService.signUp('test@example.com', 'password123');

      expect(result, isFalse);
    });

    test('login returns true and saves token on success', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: {'idToken': 'mock-login-token'},
      );

      when(() => mockDio.post<dynamic>(
        any(),
        data: any(named: 'data'),
      )).thenAnswer((_) async => response);

      final result = await authService.login('test@example.com', 'password123');

      expect(result, isTrue);
      final token = await authService.getToken();
      expect(token, equals('mock-login-token'));
    });

    test('login returns false on failure', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 401,
        data: {'error': 'Unauthorized'},
      );

      when(() => mockDio.post<dynamic>(
        any(),
        data: any(named: 'data'),
      )).thenAnswer((_) async => response);

      final result = await authService.login('test@example.com', 'password123');

      expect(result, isFalse);
    });

    test('logout removes token from SharedPreferences', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', 'temp-token');

      await authService.logout();

      final token = await authService.getToken();
      expect(token, isNull);
    });

    test('getUserRole returns ADMIN when JWT contains ADMIN role', () async {
      final token = createMockJwt({'role': 'ADMIN'});
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      final role = await authService.getUserRole();
      expect(role, equals('ADMIN'));
    });

    test('getUserRole returns FARM_WORKER when JWT role is not ADMIN', () async {
      final token = createMockJwt({'role': 'WORKER'});
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      final role = await authService.getUserRole();
      expect(role, equals('FARM_WORKER'));
    });

    test('getUserEmail extracts email from JWT', () async {
      final token = createMockJwt({'email': 'worker@farm.com'});
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      final email = await authService.getUserEmail();
      expect(email, equals('worker@farm.com'));
    });
  });
}
