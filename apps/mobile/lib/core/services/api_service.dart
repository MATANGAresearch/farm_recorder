import 'package:dio/dio.dart';
import 'auth_service.dart';

class ApiService {
  final Dio _dio;
  final AuthService _authService;

  ApiService({required Dio dio, required AuthService authService})
      : _dio = dio,
        _authService = authService {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _authService.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<List<Map<String, dynamic>>> getLocations() async {
    final response = await _dio.get('/locations');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await _dio.get('/products');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getAvailableBatches(String productId) async {
    final response = await _dio.get('/harvest-batches/available/$productId');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getMyTasks() async {
    final response = await _dio.get('/tasks/my-tasks');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<void> updateTaskStatus(String taskId, String status) async {
    await _dio.patch('/tasks/$taskId/status', queryParameters: {'status': status});
  }

  Future<Map<String, dynamic>> createActivityLog(Map<String, dynamic> payload) async {
    final response = await _dio.post('/activity-logs', data: payload);
    return response.data;
  }

  Future<Map<String, dynamic>> getPresignedUrl({
    required String farmId,
    required String taskId,
    required String fileName,
    required String contentType,
  }) async {
    final response = await _dio.post('/media/presigned-url', queryParameters: {
      'farmId': farmId,
      'taskId': taskId,
      'fileName': fileName,
      'contentType': contentType,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> createMedia(Map<String, dynamic> payload) async {
    final response = await _dio.post('/media', data: payload);
    return response.data;
  }

  Future<List<Map<String, dynamic>>> getInputBatches() async {
    final response = await _dio.get('/input-batches');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getFarms() async {
    final response = await _dio.get('/farms');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<Map<String, dynamic>>> getWorkers() async {
    final response = await _dio.get('/workers');
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> registerWorker(Map<String, dynamic> worker) async {
    final response = await _dio.post('/workers', data: worker);
    return response.data;
  }

  Future<void> promoteWorker(String email) async {
    await _dio.post('/workers/$email/promote');
  }

  Future<List<String>> getFarmWorkers(String farmId) async {
    final response = await _dio.get('/farms/$farmId/workers');
    return List<String>.from(response.data);
  }

  Future<void> assignWorkerToFarm(String farmId, String email) async {
    await _dio.post('/farms/$farmId/workers/$email');
  }

  Future<void> unassignWorkerFromFarm(String farmId, String email) async {
    await _dio.delete('/farms/$farmId/workers/$email');
  }

  Future<Map<String, dynamic>> createTask(Map<String, dynamic> taskPayload) async {
    final response = await _dio.post('/tasks', data: taskPayload);
    return response.data;
  }

  Future<List<Map<String, dynamic>>> getTasksByFarm(String farmId) async {
    final response = await _dio.get('/tasks/farm/$farmId');
    return List<Map<String, dynamic>>.from(response.data);
  }
}
