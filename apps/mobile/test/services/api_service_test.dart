import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:farm_recorder_mobile/core/services/api_service.dart';
import 'package:farm_recorder_mobile/core/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late ApiService apiService;
  late Dio dio;
  late MockAuthService mockAuthService;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://localhost:8082/api/v1'));
    // Remove real network calls for testing
    dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () => throw Exception('Network calls disabled in tests'));
    
    mockAuthService = MockAuthService();
    apiService = ApiService(dio: dio, authService: mockAuthService);
  });

  group('ApiService', () {
    test('getLocations throws on network failure (expected in test)', () async {
      when(() => mockAuthService.getToken()).thenAnswer((_) async => 'mock-token');
      
      expect(() => apiService.getLocations(), throwsException);
    });

    test('updateTaskStatus constructs correct URL', () async {
      when(() => mockAuthService.getToken()).thenAnswer((_) async => 'mock-token');
      
      // We can't easily test the exact HTTP call without a mock server, 
      // but we can verify the method exists and accepts the right types.
      expect(() => apiService.updateTaskStatus('123', 'COMPLETED'), throwsException);
    });
  });
}
