import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_recorder_mobile/features/activity/record_activity_screen.dart';
import 'package:farm_recorder_mobile/core/services/api_service.dart';
import 'package:farm_recorder_mobile/core/services/sync_service.dart';
import 'package:farm_recorder_mobile/core/services/media_service.dart';

class MockApiService extends Mock implements ApiService {}
class MockSyncService extends Mock implements SyncService {}
class MockMediaService extends Mock implements MediaService {}

void main() {
  late MockApiService mockApiService;
  late MockSyncService mockSyncService;
  late MockMediaService mockMediaService;

  setUpAll(() {
    registerFallbackValue(MediaType.IMAGE);
  });

  setUp(() {
    mockApiService = MockApiService();
    mockSyncService = MockSyncService();
    mockMediaService = MockMediaService();

    SharedPreferences.setMockInitialValues({});
  });

  Widget buildTestWidget() {
    return MaterialApp(
      home: RecordActivityScreen(
        apiService: mockApiService,
        syncService: mockSyncService,
        mediaService: mockMediaService,
      ),
    );
  }

  testWidgets('RecordActivityScreen renders basic form elements and loads data', (tester) async {
    when(() => mockApiService.getLocations()).thenAnswer((_) async => [
      {'id': 'loc-1', 'name': 'Field Alpha', 'gln': '1234567890123'}
    ]);
    when(() => mockApiService.getProducts()).thenAnswer((_) async => [
      {'id': 'prod-1', 'name': 'Sweet Corn'}
    ]);
    when(() => mockSyncService.fetchAndCacheInventory()).thenAnswer((_) async => {});

    await tester.pumpWidget(buildTestWidget());
    await tester.pump(); // Starts loading data
    await tester.pumpAndSettle(); // Finishes loading data

    expect(find.text('Record Activity'), findsWidgets);
    expect(find.text('Location / Plot *'), findsOneWidget);
    expect(find.text('Activity Type *'), findsOneWidget);
  });

  testWidgets('RecordActivityScreen switches activity type and shows conditional fields', (tester) async {
    when(() => mockApiService.getLocations()).thenAnswer((_) async => [
      {'id': 'loc-1', 'name': 'Field Alpha', 'gln': '1234567890123'}
    ]);
    when(() => mockApiService.getProducts()).thenAnswer((_) async => [
      {'id': 'prod-1', 'name': 'Sweet Corn'}
    ]);
    when(() => mockSyncService.fetchAndCacheInventory()).thenAnswer((_) async => {});

    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Select SPRAYING activity type
    final typeDropdown = find.text('Activity Type *');
    await tester.ensureVisible(typeDropdown);
    await tester.tap(typeDropdown);
    await tester.pumpAndSettle();

    // Select the "Spraying" option in the dropdown list
    final sprayingOption = find.text('Spraying').last;
    await tester.ensureVisible(sprayingOption);
    await tester.tap(sprayingOption);
    await tester.pumpAndSettle();

    // Verify spraying specific inputs are shown
    expect(find.text('Chemical Tracking (GS1 Scan / Manual)'), findsOneWidget);
    expect(find.text('Manual Input Mode'), findsOneWidget);
    expect(find.text('Input / Chemical Used *'), findsOneWidget);
  });

  testWidgets('RecordActivityScreen form validation and submission', (tester) async {
    when(() => mockApiService.getLocations()).thenAnswer((_) async => [
      {'id': 'loc-1', 'name': 'Field Alpha', 'gln': '1234567890123'}
    ]);
    when(() => mockApiService.getProducts()).thenAnswer((_) async => [
      {'id': 'prod-1', 'name': 'Sweet Corn'}
    ]);
    when(() => mockSyncService.fetchAndCacheInventory()).thenAnswer((_) async => {});
    
    when(() => mockSyncService.queueActivityLog(
      userId: any(named: 'userId'),
      locationId: any(named: 'locationId'),
      type: any(named: 'type'),
      productId: any(named: 'productId'),
      notes: any(named: 'notes'),
      gpsLat: any(named: 'gpsLat'),
      gpsLng: any(named: 'gpsLng'),
      startTime: any(named: 'startTime'),
      endTime: any(named: 'endTime'),
      batchId: any(named: 'batchId'),
      quantity: any(named: 'quantity'),
      unitPrice: any(named: 'unitPrice'),
      totalPrice: any(named: 'totalPrice'),
      customerName: any(named: 'customerName'),
      customerPhone: any(named: 'customerPhone'),
      customerEmail: any(named: 'customerEmail'),
      chemicalLotNumber: any(named: 'chemicalLotNumber'),
      chemicalExpirationDate: any(named: 'chemicalExpirationDate'),
      applicationRate: any(named: 'applicationRate'),
      totalQuantityApplied: any(named: 'totalQuantityApplied'),
      weatherWindSpeed: any(named: 'weatherWindSpeed'),
      weatherWindDirection: any(named: 'weatherWindDirection'),
      weatherTemperature: any(named: 'weatherTemperature'),
      applicatorLicense: any(named: 'applicatorLicense'),
      isManualInput: any(named: 'isManualInput'),
      manualInputComments: any(named: 'manualInputComments'),
      verificationStatus: any(named: 'verificationStatus'),
      verifiedBy: any(named: 'verifiedBy'),
      verifiedAt: any(named: 'verifiedAt'),
    )).thenAnswer((_) async => 'activity-uuid-999');

    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Try submitting empty form
    final saveBtn = find.text('Save Activity Record');
    await tester.ensureVisible(saveBtn);
    await tester.tap(saveBtn);
    await tester.pumpAndSettle();

    // Verify warning snackbar is shown
    expect(find.text('Please fill in all required fields for the selected activity type.'), findsOneWidget);

    // Select location dropdown
    final locDropdown = find.text('Location / Plot *');
    await tester.ensureVisible(locDropdown);
    await tester.tap(locDropdown);
    await tester.pumpAndSettle();
    
    final locOption = find.text('Field Alpha (1234567890123)').last;
    await tester.ensureVisible(locOption);
    await tester.tap(locOption);
    await tester.pumpAndSettle();

    // Select type dropdown
    final typeDropdown2 = find.text('Activity Type *');
    await tester.ensureVisible(typeDropdown2);
    await tester.tap(typeDropdown2);
    await tester.pumpAndSettle();
    
    final plantingOption = find.text('Planting').last;
    await tester.ensureVisible(plantingOption);
    await tester.tap(plantingOption);
    await tester.pumpAndSettle();

    // Select product dropdown
    final prodDropdown = find.text('Select the crop being managed');
    await tester.ensureVisible(prodDropdown);
    await tester.tap(prodDropdown);
    await tester.pumpAndSettle();
    
    final prodOption = find.text('Sweet Corn').last;
    await tester.ensureVisible(prodOption);
    await tester.tap(prodOption);
    await tester.pumpAndSettle();

    // Fill planting quantity using specific label predicate
    final quantityField = find.byWidgetPredicate((widget) =>
        widget is TextField && widget.decoration?.labelText == 'Quantity *');
    await tester.ensureVisible(quantityField);
    await tester.enterText(quantityField, '500');
    await tester.pumpAndSettle();

    // Click Save
    await tester.ensureVisible(saveBtn);
    await tester.tap(saveBtn);
    await tester.pump();
    await tester.pumpAndSettle();

    // Verify activity queued called with correct parameters
    verify(() => mockSyncService.queueActivityLog(
      userId: any(named: 'userId'),
      locationId: 'loc-1',
      type: 'PLANTING',
      productId: 'prod-1',
      notes: any(named: 'notes'),
      quantity: 500,
    )).called(1);
  });
}
