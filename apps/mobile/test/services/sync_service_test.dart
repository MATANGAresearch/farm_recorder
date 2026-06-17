import 'package:farm_recorder_mobile/core/services/api_service.dart';
import 'package:farm_recorder_mobile/core/services/sync_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late SyncService syncService;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    syncService = SyncService(apiService: mockApiService);
  });

  group('SyncService', () {
    test('queueMedia calls createMedia', () async {
      when(() => mockApiService.createMedia(any())).thenAnswer((_) async => {'id': '789'});

      await syncService.queueMedia(
        activityLogUuid: 'act-123',
        mediaUrl: 'http://example.com/photo.jpg',
        mediaType: 'IMAGE',
        capturedGpsLat: 32.0,
        capturedGpsLng: 35.0,
      );

      // Verify it was called at least once with a map containing the right keys
      verify(() => mockApiService.createMedia(any())).called(1);
    });
  });
}
