import 'package:farm_recorder_mobile/features/auth/signup_screen.dart';
import 'package:farm_recorder_mobile/core/services/auth_service.dart';
import 'package:farm_recorder_mobile/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}
class MockApiService extends Mock implements ApiService {}

void main() {
  late MockAuthService mockAuthService;
  late MockApiService mockApiService;
  late bool signupSuccessCalled;
  late bool navigateToLoginCalled;

  setUp(() {
    mockAuthService = MockAuthService();
    mockApiService = MockApiService();
    signupSuccessCalled = false;
    navigateToLoginCalled = false;
  });

  Widget buildTestWidget() {
    return MaterialApp(
      home: SignupScreen(
        authService: mockAuthService,
        apiService: mockApiService,
        onSignupSuccess: () => signupSuccessCalled = true,
        onNavigateToLogin: () => navigateToLoginCalled = true,
      ),
    );
  }

  testWidgets('SignupScreen renders fields and buttons', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    expect(find.byType(TextField), findsNWidgets(4));
    expect(find.text('Farm Name'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });

  testWidgets('SignupScreen shows validation error on empty fields', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    final btn = find.text('Sign Up');
    await tester.ensureVisible(btn);
    await tester.tap(btn);
    await tester.pump();

    expect(find.text('Please fill in all fields.'), findsOneWidget);
    expect(signupSuccessCalled, isFalse);
  });

  testWidgets('SignupScreen shows validation error on mismatching passwords', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    await tester.enterText(find.byType(TextField).at(0), 'My Farm');
    await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'pass123');
    await tester.enterText(find.byType(TextField).at(3), 'pass456');

    final btn = find.text('Sign Up');
    await tester.ensureVisible(btn);
    await tester.tap(btn);
    await tester.pump();

    expect(find.text('Passwords do not match.'), findsOneWidget);
    expect(signupSuccessCalled, isFalse);
  });

  testWidgets('SignupScreen shows validation error on short password', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    await tester.enterText(find.byType(TextField).at(0), 'My Farm');
    await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(2), '123');
    await tester.enterText(find.byType(TextField).at(3), '123');

    final btn = find.text('Sign Up');
    await tester.ensureVisible(btn);
    await tester.tap(btn);
    await tester.pump();

    expect(find.text('Password must be at least 6 characters.'), findsOneWidget);
    expect(signupSuccessCalled, isFalse);
  });

  testWidgets('SignupScreen handles successful signup flow', (tester) async {
    when(() => mockAuthService.signUp('test@example.com', 'password123'))
        .thenAnswer((_) async => true);
    when(() => mockApiService.createFarm({'name': 'My Farm'}))
        .thenAnswer((_) async => {'id': 'farm-123', 'name': 'My Farm'});

    await tester.pumpWidget(buildTestWidget());

    await tester.enterText(find.byType(TextField).at(0), 'My Farm');
    await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password123');
    await tester.enterText(find.byType(TextField).at(3), 'password123');

    final btn = find.text('Sign Up');
    await tester.ensureVisible(btn);
    await tester.tap(btn);
    await tester.pump(); // Start signup
    await tester.pump(); // Complete signup & call apiService
    await tester.pump(); // Final rebuild

    expect(signupSuccessCalled, isTrue);
    verify(() => mockAuthService.signUp('test@example.com', 'password123')).called(1);
    verify(() => mockApiService.createFarm({'name': 'My Farm'})).called(1);
  });

  testWidgets('SignupScreen handles auth failure', (tester) async {
    when(() => mockAuthService.signUp('test@example.com', 'password123'))
        .thenAnswer((_) async => false);

    await tester.pumpWidget(buildTestWidget());

    await tester.enterText(find.byType(TextField).at(0), 'My Farm');
    await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password123');
    await tester.enterText(find.byType(TextField).at(3), 'password123');

    final btn = find.text('Sign Up');
    await tester.ensureVisible(btn);
    await tester.tap(btn);
    await tester.pump(); // Start signup
    await tester.pump(); // Complete signup

    expect(find.text('Failed to create user account.'), findsOneWidget);
    expect(signupSuccessCalled, isFalse);
    verify(() => mockAuthService.signUp('test@example.com', 'password123')).called(1);
    verifyNever(() => mockApiService.createFarm(any()));
  });

  testWidgets('SignupScreen navigates to LoginScreen when Sign In tapped', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    final btn = find.text('Sign In');
    await tester.ensureVisible(btn);
    await tester.tap(btn);
    await tester.pump();

    expect(navigateToLoginCalled, isTrue);
  });
}
