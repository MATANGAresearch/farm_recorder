import 'package:dio/dio.dart';
import 'package:farm_recorder_mobile/core/services/api_service.dart';
import 'package:farm_recorder_mobile/core/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}
class MockDio extends Mock implements Dio {
  @override
  final Interceptors interceptors = Interceptors();
}

void main() {
  late ApiService apiService;
  late MockDio mockDio;
  late MockAuthService mockAuthService;

  setUp(() {
    mockDio = MockDio();
    mockAuthService = MockAuthService();
    
    // Stub token for interceptor (even though interceptor is tested implicitly or explicitly)
    when(() => mockAuthService.getToken()).thenAnswer((_) async => 'mock-token');
    
    apiService = ApiService(dio: mockDio, authService: mockAuthService);
  });

  group('ApiService API endpoints', () {
    test('getLocations invokes GET /locations', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/locations'),
        statusCode: 200,
        data: [
          {'id': 'loc-1', 'name': 'Field A'}
        ],
      );

      when(() => mockDio.get<dynamic>(
        '/locations',
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
      )).thenAnswer((_) async => mockResponse);

      final result = await apiService.getLocations();

      expect(result.length, 1);
      expect(result.first['name'], 'Field A');
      verify(() => mockDio.get<dynamic>('/locations')).called(1);
    });

    test('getProducts invokes GET /products', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/products'),
        statusCode: 200,
        data: [
          {'id': 'prod-1', 'name': 'Wheat'}
        ],
      );

      when(() => mockDio.get<dynamic>(
        '/products',
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
      )).thenAnswer((_) async => mockResponse);

      final result = await apiService.getProducts();

      expect(result.length, 1);
      expect(result.first['name'], 'Wheat');
      verify(() => mockDio.get<dynamic>('/products')).called(1);
    });

    test('createFarm invokes POST /farms with payload', () async {
      final payload = {'name': 'New Farm'};
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/farms'),
        statusCode: 201,
        data: {'id': 'farm-123', 'name': 'New Farm'},
      );

      when(() => mockDio.post<dynamic>(
        '/farms',
        data: payload,
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
      )).thenAnswer((_) async => mockResponse);

      final result = await apiService.createFarm(payload);

      expect(result['id'], 'farm-123');
      expect(result['name'], 'New Farm');
      verify(() => mockDio.post<dynamic>('/farms', data: payload)).called(1);
    });

    test('createLocation invokes POST /locations with payload', () async {
      final payload = {'name': 'Plot C', 'type': 'FIELD'};
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/locations'),
        statusCode: 201,
        data: {'id': 'loc-3', 'name': 'Plot C'},
      );

      when(() => mockDio.post<dynamic>(
        '/locations',
        data: payload,
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
      )).thenAnswer((_) async => mockResponse);

      final result = await apiService.createLocation(payload);

      expect(result['id'], 'loc-3');
      verify(() => mockDio.post<dynamic>('/locations', data: payload)).called(1);
    });

    test('createProduct invokes POST /products with payload', () async {
      final payload = {'name': 'Apples', 'type': 'CROP'};
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/products'),
        statusCode: 201,
        data: {'id': 'prod-5', 'name': 'Apples'},
      );

      when(() => mockDio.post<dynamic>(
        '/products',
        data: payload,
        queryParameters: any(named: 'queryParameters'),
        options: any(named: 'options'),
      )).thenAnswer((_) async => mockResponse);

      final result = await apiService.createProduct(payload);

      expect(result['id'], 'prod-5');
      verify(() => mockDio.post<dynamic>('/products', data: payload)).called(1);
    });

    test('updateTaskStatus invokes PATCH with queryParameters', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/tasks/123/status'),
        statusCode: 200,
      );

      when(() => mockDio.patch<dynamic>(
        '/tasks/123/status',
        queryParameters: {'status': 'COMPLETED'},
        data: any(named: 'data'),
        options: any(named: 'options'),
      )).thenAnswer((_) async => mockResponse);

      await apiService.updateTaskStatus('123', 'COMPLETED');

      verify(() => mockDio.patch<dynamic>('/tasks/123/status', queryParameters: {'status': 'COMPLETED'})).called(1);
    });
  });
}
