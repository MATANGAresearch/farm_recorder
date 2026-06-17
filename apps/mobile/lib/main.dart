import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'core/db/app_database.dart';
import 'core/services/api_service.dart';
import 'core/services/auth_service.dart';
import 'core/services/sync_service.dart';
import 'core/theme/app_theme.dart';
import 'features/activity/record_activity_screen.dart';
import 'features/tasks/my_tasks_screen.dart';

// Top-level service instances for simple dependency injection
late final ApiService apiService;
late final SyncService syncService;
late final AuthService authService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.init();

  final dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8082/api/v1', // 10.0.2.2 for Android emulator
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  authService = AuthService();

  // Auto-login for development environment to ensure a fresh token
  debugPrint("Performing development auto-login...");
  final loginResult = await authService.login('farmuser', 'farmpass');
  debugPrint("Auto-login result: $loginResult");

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

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      MyTasksScreen(apiService: apiService, syncService: syncService),
      RecordActivityScreen(apiService: apiService, syncService: syncService),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
