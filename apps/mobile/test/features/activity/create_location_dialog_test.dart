import 'package:farm_recorder_mobile/features/activity/create_location_dialog.dart';
import 'package:farm_recorder_mobile/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });

  Widget buildTestWidget(BuildContext context) {
    return CreateLocationDialog(apiService: mockApiService);
  }

  testWidgets('CreateLocationDialog renders correctly', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (ctx) => buildTestWidget(ctx),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Add Field / Plot'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2)); // Name and GLN
    expect(find.text('Plot Name *'), findsOneWidget);
    expect(find.text('GS1 GLN (Optional)'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('CreateLocationDialog shows validator error on empty name', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (ctx) => buildTestWidget(ctx),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Name is required'), findsOneWidget);
    verifyNever(() => mockApiService.createLocation(any()));
  });

  testWidgets('CreateLocationDialog submits payload and pops with result', (tester) async {
    final expectedPayload = {
      'name': 'Greenhouse A',
      'type': 'FACILITY',
      'gln': '5012345678900',
      'geoJsonPolygon': '{"type": "Polygon", "coordinates": [[[0,0],[0,1],[1,1],[1,0],[0,0]]]}',
    };

    final mockResponse = {
      'id': 'loc-999',
      'name': 'Greenhouse A',
      'type': 'FACILITY',
      'gln': '5012345678900',
    };

    when(() => mockApiService.createLocation(expectedPayload))
        .thenAnswer((_) async => mockResponse);

    dynamic returnedResult;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () async {
              returnedResult = await showDialog(
                context: context,
                builder: (ctx) => buildTestWidget(ctx),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    // Enter name
    await tester.enterText(find.byType(TextFormField).at(0), 'Greenhouse A');

    // Change dropdown type to FACILITY
    await tester.tap(find.text('Field / Plot')); // open dropdown
    await tester.pumpAndSettle();
    await tester.tap(find.text('Facility / Barn').last);
    await tester.pumpAndSettle();

    // Enter GLN
    await tester.enterText(find.byType(TextFormField).at(1), '5012345678900');

    // Submit
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle(); // Wait for post and animation

    expect(returnedResult, equals(mockResponse));
    verify(() => mockApiService.createLocation(expectedPayload)).called(1);
  });

  testWidgets('CreateLocationDialog displays error message on API failure', (tester) async {
    when(() => mockApiService.createLocation(any()))
        .thenThrow(Exception('Backend database connection error'));

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (ctx) => buildTestWidget(ctx),
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Plot Z');
    await tester.tap(find.text('Save'));
    await tester.pump(); // Start async save
    await tester.pump(); // Finish save

    expect(find.text('Failed to create plot: Exception: Backend database connection error'), findsOneWidget);
  });
}
