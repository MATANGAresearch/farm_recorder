import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_recorder_mobile/features/tasks/my_tasks_screen.dart';
import 'package:farm_recorder_mobile/core/services/api_service.dart';
import 'package:farm_recorder_mobile/core/services/sync_service.dart';
import 'package:farm_recorder_mobile/core/services/auth_service.dart';
import 'package:farm_recorder_mobile/core/services/media_service.dart';
import 'package:farm_recorder_mobile/main.dart' as main_app;

class MockApiService extends Mock implements ApiService {}
class MockSyncService extends Mock implements SyncService {}
class MockAuthService extends Mock implements AuthService {}
class MockMediaService extends Mock implements MediaService {}

void main() {
  late MockApiService mockApiService;
  late MockSyncService mockSyncService;
  late MockAuthService mockAuthService;
  late MockMediaService mockMediaService;
  late bool logoutCalled;

  setUpAll(() {
    registerFallbackValue(MediaType.IMAGE);
    registerFallbackValue(File('dummy.jpg'));
    registerFallbackValue(MockApiService());
  });

  setUp(() {
    mockApiService = MockApiService();
    mockSyncService = MockSyncService();
    mockAuthService = MockAuthService();
    mockMediaService = MockMediaService();
    logoutCalled = false;

    // Inject the mocked AuthService globally
    main_app.authService = mockAuthService;

    SharedPreferences.setMockInitialValues({});
  });

  Widget buildTestWidget() {
    return MaterialApp(
      home: MyTasksScreen(
        apiService: mockApiService,
        syncService: mockSyncService,
        mediaService: mockMediaService,
        onLogout: () => logoutCalled = true,
      ),
    );
  }

  testWidgets('MyTasksScreen displays loading indicator initially', (tester) async {
    when(() => mockAuthService.getUserRole()).thenAnswer((_) async => 'FARM_WORKER');
    when(() => mockAuthService.getUserEmail()).thenAnswer((_) async => 'worker@farm.com');
    when(() => mockApiService.getFarms()).thenAnswer((_) async => []);

    await tester.pumpWidget(buildTestWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('MyTasksScreen renders empty tasks view for worker', (tester) async {
    when(() => mockAuthService.getUserRole()).thenAnswer((_) async => 'FARM_WORKER');
    when(() => mockAuthService.getUserEmail()).thenAnswer((_) async => 'worker@farm.com');
    when(() => mockApiService.getFarms()).thenAnswer((_) async => [
      {'id': 'farm-1', 'name': 'Green Meadow Farm'}
    ]);
    when(() => mockApiService.getMyTasks()).thenAnswer((_) async => []);

    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('No tasks here!'), findsOneWidget);
    expect(find.text('worker@farm.com'), findsOneWidget);
    expect(find.text('FARM_WORKER'), findsOneWidget);
    expect(find.text('Green Meadow Farm'), findsOneWidget);
  });

  testWidgets('MyTasksScreen renders tasks list and completes task with evidence', (tester) async {
    final mockTask = {
      'id': 'task-101',
      'farmId': 'farm-1',
      'title': 'Weed the tomato patch',
      'description': 'Remove all weeds from rows 1 to 5',
      'status': 'PENDING',
      'assignedTo': 'worker@farm.com'
    };

    when(() => mockAuthService.getUserRole()).thenAnswer((_) async => 'FARM_WORKER');
    when(() => mockAuthService.getUserEmail()).thenAnswer((_) async => 'worker@farm.com');
    when(() => mockApiService.getFarms()).thenAnswer((_) async => [
      {'id': 'farm-1', 'name': 'Green Meadow Farm'}
    ]);
    when(() => mockApiService.getMyTasks()).thenAnswer((_) async => [mockTask]);
    when(() => mockApiService.getLocations()).thenAnswer((_) async => [
      {'id': 'loc-1', 'name': 'Field A'}
    ]);
    when(() => mockApiService.updateTaskStatus('task-101', 'COMPLETED')).thenAnswer((_) async => {});
    
    when(() => mockSyncService.queueActivityLog(
      userId: any(named: 'userId'),
      locationId: any(named: 'locationId'),
      type: any(named: 'type'),
      taskId: any(named: 'taskId'),
      notes: any(named: 'notes'),
    )).thenAnswer((_) async => 'activity-uuid-123');

    when(() => mockSyncService.queueMedia(
      activityLogUuid: any(named: 'activityLogUuid'),
      mediaUrl: any(named: 'mediaUrl'),
      mediaType: any(named: 'mediaType'),
    )).thenAnswer((_) async => {});

    // Mock media service upload
    final dummyFile = File('dummy.jpg');
    when(() => mockMediaService.uploadMediaToMinIO(
      any(),
      any(),
      any(),
      any(),
      any(),
    )).thenAnswer((_) async => 'http://minio/dummy.jpg');

    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Weed the tomato patch'), findsOneWidget);
    expect(find.text('Remove all weeds from rows 1 to 5'), findsOneWidget);

    // Tap Photo evidence button
    final photoBtn = find.text('Photo');
    await tester.ensureVisible(photoBtn);
    await tester.tap(photoBtn);
    await tester.pumpAndSettle();

    // Tap Complete task button
    final completeBtn = find.text('Mark as Completed');
    await tester.ensureVisible(completeBtn);
    await tester.tap(completeBtn);
    await tester.pump(); // Start execution
    await tester.pumpAndSettle(); // Complete execution

    verify(() => mockApiService.updateTaskStatus('task-101', 'COMPLETED')).called(1);
  });

  testWidgets('MyTasksScreen admin view options', (tester) async {
    when(() => mockAuthService.getUserRole()).thenAnswer((_) async => 'ADMIN');
    when(() => mockAuthService.getUserEmail()).thenAnswer((_) async => 'admin@farm.com');
    when(() => mockApiService.getFarms()).thenAnswer((_) async => [
      {'id': 'farm-1', 'name': 'Green Meadow Farm'}
    ]);
    when(() => mockApiService.getMyTasks()).thenAnswer((_) async => []);
    when(() => mockApiService.getTasksByFarm('farm-1')).thenAnswer((_) async => []);
    when(() => mockApiService.getFarmWorkers('farm-1')).thenAnswer((_) async => ['worker1@farm.com']);

    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Check we see ADMIN role
    expect(find.text('ADMIN'), findsOneWidget);
    expect(find.text('WORKER VIEW'), findsOneWidget);

    // Toggle to ADMIN view
    final adminViewToggle = find.text('WORKER VIEW');
    await tester.tap(adminViewToggle);
    await tester.pumpAndSettle();

    expect(find.text('ADMIN VIEW'), findsOneWidget);

    // Check tabs
    expect(find.text('Tasks'), findsOneWidget);
    expect(find.text('Assign Task'), findsOneWidget);
    expect(find.text('Workers'), findsOneWidget);

    // Switch to Assign Task tab
    final assignTab = find.text('Assign Task');
    await tester.tap(assignTab);
    await tester.pumpAndSettle();

    expect(find.text('Assign New Farm Task'), findsOneWidget);

    // Switch to Workers tab
    final workersTab = find.text('Workers');
    await tester.tap(workersTab);
    await tester.pumpAndSettle();

    expect(find.text('Assigned Farm Workers'), findsOneWidget);
    expect(find.text('worker1@farm.com'), findsOneWidget);
  });
}
