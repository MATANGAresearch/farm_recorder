import 'package:farm_recorder_mobile/features/activity/create_product_dialog.dart';
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
    return CreateProductDialog(apiService: mockApiService);
  }

  testWidgets('CreateProductDialog renders correctly', (tester) async {
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

    expect(find.text('Add Crop / Product'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3)); // Name, GTIN, Variety
    expect(find.text('Product Name *'), findsOneWidget);
    expect(find.text('GS1 GTIN *'), findsOneWidget);
    expect(find.text('Variety (Optional)'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('CreateProductDialog validates name and GTIN fields', (tester) async {
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

    // Trigger validation with all fields empty
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Name is required'), findsOneWidget);
    expect(find.text('GTIN is required'), findsOneWidget);

    // Enter name, invalid short GTIN
    await tester.enterText(find.byType(TextFormField).at(0), 'Apples');
    await tester.enterText(find.byType(TextFormField).at(1), '12345'); // too short
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('GTIN must be a numeric string between 8 and 14 digits'), findsOneWidget);
    verifyNever(() => mockApiService.createProduct(any()));
  });

  testWidgets('CreateProductDialog submits payload and pops with result', (tester) async {
    final expectedPayload = {
      'name': 'Gala Apples',
      'type': 'CROP',
      'gtin': '01234567890123',
      'variety': 'Gala',
    };

    final mockResponse = {
      'id': 'prod-777',
      'name': 'Gala Apples',
      'type': 'CROP',
      'gtin': '01234567890123',
      'variety': 'Gala',
    };

    when(() => mockApiService.createProduct(expectedPayload))
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
    await tester.enterText(find.byType(TextFormField).at(0), 'Gala Apples');

    // Keep type as CROP (default)

    // Enter GTIN
    await tester.enterText(find.byType(TextFormField).at(1), '01234567890123');

    // Enter Variety
    await tester.enterText(find.byType(TextFormField).at(2), 'Gala');

    // Submit
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(returnedResult, equals(mockResponse));
    verify(() => mockApiService.createProduct(expectedPayload)).called(1);
  });

  testWidgets('CreateProductDialog displays error message on API failure', (tester) async {
    when(() => mockApiService.createProduct(any()))
        .thenThrow(Exception('Duplicate GTIN registered'));

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

    await tester.enterText(find.byType(TextFormField).at(0), 'Apples');
    await tester.enterText(find.byType(TextFormField).at(1), '12345678');
    await tester.tap(find.text('Save'));
    await tester.pump(); // Start save
    await tester.pump(); // Finish save

    expect(find.text('Failed to create crop: Exception: Duplicate GTIN registered'), findsOneWidget);
  });
}
