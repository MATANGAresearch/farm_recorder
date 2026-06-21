import 'package:farm_recorder_mobile/features/auth/login_screen.dart';
import 'package:farm_recorder_mobile/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuthService;
  late bool loginSuccessCalled;
  late bool navigateToSignupCalled;

  setUp(() {
    mockAuthService = MockAuthService();
    loginSuccessCalled = false;
    navigateToSignupCalled = false;
  });

  Widget buildTestWidget() {
    return MaterialApp(
      home: LoginScreen(
        authService: mockAuthService,
        onLoginSuccess: () => loginSuccessCalled = true,
        onNavigateToSignup: () => navigateToSignupCalled = true,
      ),
    );
  }

  testWidgets('LoginScreen renders fields and buttons', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('LoginScreen shows validation error on empty fields', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    final btn = find.text('Sign In');
    await tester.ensureVisible(btn);
    await tester.tap(btn);
    await tester.pump();

    expect(find.text('Please fill in all fields.'), findsOneWidget);
    expect(loginSuccessCalled, isFalse);
  });

  testWidgets('LoginScreen handles successful login', (tester) async {
    when(() => mockAuthService.login('test@example.com', 'pass123'))
        .thenAnswer((_) async => true);

    await tester.pumpWidget(buildTestWidget());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'pass123');

    final btn = find.text('Sign In');
    await tester.ensureVisible(btn);
    await tester.tap(btn);
    await tester.pump(); // Start login
    await tester.pump(); // Complete login

    expect(loginSuccessCalled, isTrue);
  });

  testWidgets('LoginScreen handles failed login', (tester) async {
    when(() => mockAuthService.login('test@example.com', 'wrong'))
        .thenAnswer((_) async => false);

    await tester.pumpWidget(buildTestWidget());

    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'wrong');

    final btn = find.text('Sign In');
    await tester.ensureVisible(btn);
    await tester.tap(btn);
    await tester.pump(); // Start login
    await tester.pump(); // Complete login

    expect(find.text('Invalid email or password.'), findsOneWidget);
    expect(loginSuccessCalled, isFalse);
  });

  testWidgets('LoginScreen navigates to SignupScreen when Sign Up tapped', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    final btn = find.text('Sign Up');
    await tester.ensureVisible(btn);
    await tester.tap(btn);
    await tester.pump();

    expect(navigateToSignupCalled, isTrue);
  });
}
