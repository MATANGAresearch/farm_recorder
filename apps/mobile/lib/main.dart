import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'core/db/app_database.dart';
import 'core/services/api_service.dart';
import 'core/services/auth_service.dart';
import 'core/services/sync_service.dart';
import 'core/theme/app_theme.dart';
import 'features/activity/record_activity_screen.dart';
import 'features/tasks/my_tasks_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Top-level service instances for simple dependency injection
late ApiService apiService;
late SyncService syncService;
late AuthService authService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.init();

  final dio = Dio(BaseOptions(
    baseUrl: 'https://farmrecorder.matangaresearch.com/api/v1',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  authService = AuthService();

  apiService = ApiService(dio: dio, authService: authService);
  syncService = SyncService(apiService: apiService);

  runApp(const FarmRecorderApp());
}

class FarmRecorderApp extends StatefulWidget {
  const FarmRecorderApp({super.key});

  @override
  State<FarmRecorderApp> createState() => _FarmRecorderAppState();
}

class _FarmRecorderAppState extends State<FarmRecorderApp> {
  int _currentIndex = 0;
  bool _isAuthenticated = false;
  bool _checkingAuth = true;
  bool _showSignup = false;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await authService.getToken();
    setState(() {
      _isAuthenticated = token != null;
      _checkingAuth = false;
      if (_isAuthenticated) {
        _initScreens();
      }
    });
  }

  void _initScreens() {
    _screens = [
      MyTasksScreen(
        apiService: apiService, 
        syncService: syncService,
        onLogout: _handleLogout,
      ),
      RecordActivityScreen(apiService: apiService, syncService: syncService),
    ];
  }

  void _handleLoginSuccess() {
    setState(() {
      _isAuthenticated = true;
      _showSignup = false;
      _initScreens();
    });
  }

  void _handleSignupSuccess() {
    setState(() {
      _isAuthenticated = true;
      _showSignup = false;
      _initScreens();
    });
  }

  void _handleLogout() async {
    await authService.logout();
    setState(() {
      _isAuthenticated = false;
      _currentIndex = 0;
      _showSignup = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingAuth) {
      return MaterialApp(
        title: 'Farm Recorder',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: Colors.green),
          ),
        ),
      );
    }

    if (!_isAuthenticated) {
      return MaterialApp(
        title: 'Farm Recorder',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: _showSignup
            ? SignupScreen(
                authService: authService,
                apiService: apiService,
                onSignupSuccess: _handleSignupSuccess,
                onNavigateToLogin: () => setState(() => _showSignup = false),
              )
            : LoginScreen(
                authService: authService,
                onLoginSuccess: _handleLoginSuccess,
                onNavigateToSignup: () => setState(() => _showSignup = true),
              ),
      );
    }

    return MaterialApp(
      title: 'Farm Recorder',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.task_alt, size: 24),
              activeIcon: Icon(Icons.task_alt, size: 28),
              label: 'My Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline, size: 24),
              activeIcon: Icon(Icons.add_circle, size: 28),
              label: 'Record',
            ),
          ],
        ),
      ),
    );
  }
}
