import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/api_service.dart';
import '../../core/services/sync_service.dart';
import '../../core/services/media_service.dart';
import '../../main.dart'; // To access authService
import 'package:shared_preferences/shared_preferences.dart';

class MyTasksScreen extends StatefulWidget {
  final ApiService apiService;
  final SyncService syncService;
  final VoidCallback onLogout;

  const MyTasksScreen({
    super.key,
    required this.apiService,
    required this.syncService,
    required this.onLogout,
  });

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  List<Map<String, dynamic>> _tasks = [];
  List<Map<String, dynamic>> _farms = [];
  Map<String, dynamic>? _selectedFarm;
  
  String _userRole = 'FARM_WORKER';
  String _userEmail = '';
  bool _isAdminMode = false;
  
  List<String> _farmWorkers = [];
  
  bool _isLoading = true;
  String? _error;
  final bool _useMock = true;

  final ImagePicker _picker = ImagePicker();
  final MediaService _mediaService = MediaService();
  
  final Map<String, File?> _taskEvidence = {};
  final Map<String, String> _evidenceType = {};

  // Controllers for Admin actions
  final _taskTitleController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  final _workerEmailController = TextEditingController();
  final _promoteEmailController = TextEditingController();
  String _assignTargetWorkerEmail = '';
  DateTime _selectedDueDate = DateTime.now().add(const Duration(days: 1));

  // Admin sub-tab selection (0 = Tasks, 1 = Assign Task, 2 = Manage Workers)
  int _adminTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
    _workerEmailController.dispose();
    _promoteEmailController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      _userRole = await authService.getUserRole();
      _userEmail = await authService.getUserEmail();
      
      final farms = await widget.apiService.getFarms();
      _farms = farms;
      if (_farms.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        final savedFarmId = prefs.getString('active_farm_id');
        if (savedFarmId != null && _farms.any((f) => f['id'] == savedFarmId)) {
          _selectedFarm = _farms.firstWhere((f) => f['id'] == savedFarmId);
        } else {
          _selectedFarm = _farms.first;
          await prefs.setString('active_farm_id', _selectedFarm!['id'] as String);
        }
      }
      
      await _loadTasksAndDetails();
    } catch (e) {
      debugPrint('Error loading initial data: $e');
      setState(() {
        _error = 'Failed to load initial data. Please try again.';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadTasksAndDetails() async {
    if (_selectedFarm == null) {
      setState(() {
        _tasks = [];
        _isLoading = false;
      });
      return;
    }

    final farmId = _selectedFarm!['id'] as String;

    try {
      if (_userRole == 'ADMIN' && _isAdminMode) {
        final tasks = await widget.apiService.getTasksByFarm(farmId);
        final farmWorkerEmails = await widget.apiService.getFarmWorkers(farmId);

        setState(() {
          _tasks = tasks;
          _farmWorkers = farmWorkerEmails;
          _isLoading = false;
        });
      } else {
        final tasks = await widget.apiService.getMyTasks();
        final filteredTasks = tasks.where((t) => t['farmId'] == farmId).toList();
        setState(() {
          _tasks = filteredTasks;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading tasks: $e');
      setState(() {
        _error = 'Failed to load tasks for selected farm.';
        _isLoading = false;
      });
    }
  }

  Future<void> _captureEvidence(String taskId, String type) async {
    File? mediaFile;
    try {
      if (_useMock) {
        final tempDir = Directory.systemTemp;
        final extension = type == 'IMAGE' ? 'jpg' : 'mp4';
        final dummyFile = File('${tempDir.path}/mock_${type.toLowerCase()}_$taskId.$extension');
        await dummyFile.writeAsBytes(List.generate(100, (index) => index));
        mediaFile = dummyFile;
      } else if (type == 'IMAGE') {
        final photo = await _picker.pickImage(source: ImageSource.camera);
        if (photo != null) {
          mediaFile = File(photo.path);
        }
      } else if (type == 'VIDEO') {
        final video = await _picker.pickVideo(source: ImageSource.camera);
        if (video != null) {
          mediaFile = File(video.path);
        }
      }
    } catch (e) {
      debugPrint('Error picking media, using fallback: $e');
    }

    if (mediaFile != null) {
      setState(() {
        _taskEvidence[taskId] = mediaFile;
        _evidenceType[taskId] = type;
      });
    }
  }

  Future<void> _completeTask(Map<String, dynamic> task) async {
    final taskId = task['id'] as String;
    final evidenceFile = _taskEvidence[taskId];
    final eType = _evidenceType[taskId];

    if (evidenceFile == null || eType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please attach photo or video evidence before completing.',
            style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final mediaType = eType == 'IMAGE' ? MediaType.IMAGE : MediaType.VIDEO;
      final farmId = task['farmId'] ?? 'default-farm';
      
      final mediaUrl = await _mediaService.uploadMediaToMinIO(evidenceFile, mediaType, farmId, taskId, widget.apiService);
      if (mediaUrl == null) throw Exception('Failed to upload media');

      String locationId = '019ecc19-b6be-76d9-b997-5e89f6c0e35a'; // Fallback to seeded North Field
      try {
        final locations = await widget.apiService.getLocations();
        if (locations.isNotEmpty) {
          locationId = locations.first['id'] as String;
        }
      } catch (e) {
        debugPrint('Failed to get locations, using fallback: $e');
      }

      final activityUuid = await widget.syncService.queueActivityLog(
        userId: _userEmail.isNotEmpty ? _userEmail : 'farmuser',
        locationId: locationId,
        type: 'INSPECTION',
        taskId: taskId,
        notes: 'Task completed with evidence',
      );

      await widget.syncService.queueMedia(
        activityLogUuid: activityUuid,
        mediaUrl: mediaUrl,
        mediaType: eType,
      );

      await widget.apiService.updateTaskStatus(taskId, 'COMPLETED');

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Task marked as COMPLETED successfully!',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
      );

      setState(() {
        _taskEvidence.remove(taskId);
        _evidenceType.remove(taskId);
      });
      
      await _loadTasksAndDetails();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to complete task: $e',
            style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Admin Actions
  Future<void> _handleCreateTask() async {
    final title = _taskTitleController.text.trim();
    final desc = _taskDescriptionController.text.trim();
    if (title.isEmpty || _assignTargetWorkerEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title and select a worker.')),
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      await widget.apiService.createTask({
        'farmId': _selectedFarm!['id'],
        'title': title,
        'assignedTo': _assignTargetWorkerEmail,
        'description': desc,
        'dueDate': _selectedDueDate.toUtc().toIso8601String(),
      });
      _taskTitleController.clear();
      _taskDescriptionController.clear();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task assigned successfully!')),
      );
      setState(() {
        _adminTabIndex = 0; // Return to task list
      });
      await _loadTasksAndDetails();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to assign task: $e')),
      );
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleAssignWorker() async {
    final email = _workerEmailController.text.trim();
    if (email.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      await widget.apiService.assignWorkerToFarm(_selectedFarm!['id'], email);
      _workerEmailController.clear();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Worker assigned to farm.')),
      );
      await _loadTasksAndDetails();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to assign worker: $e')),
      );
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleUnassignWorker(String email) async {
    setState(() => _isLoading = true);
    try {
      await widget.apiService.unassignWorkerFromFarm(_selectedFarm!['id'], email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Worker unassigned from farm.')),
      );
      await _loadTasksAndDetails();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to unassign worker: $e')),
      );
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handlePromoteWorker() async {
    final email = _promoteEmailController.text.trim();
    if (email.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      await widget.apiService.promoteWorker(email);
      _promoteEmailController.clear();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Worker promoted to Admin successfully!')),
      );
      await _loadTasksAndDetails();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to promote worker: $e')),
      );
      setState(() => _isLoading = false);
    }
  }

  Color _getStatusColor(String status, BuildContext context) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return Colors.green;
      case 'REVIEWED':
        return Colors.blue;
      case 'IN_PROGRESS':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (_isLoading && _farms.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Daily Tasks'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: widget.onLogout,
              tooltip: 'Sign Out',
            ),
          ],
        ),
        body: const Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    if (_error != null && _farms.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Daily Tasks'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: widget.onLogout,
              tooltip: 'Sign Out',
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off, size: 64, color: colorScheme.onSurfaceVariant),
              const SizedBox(height: 16),
              Text(_error!, style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _loadInitialData,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    String formatStatus(String status) {
      return status.replaceAll('_', ' ').toLowerCase().split(' ').map((word) {
        if (word.isEmpty) return '';
        return word[0].toUpperCase() + word.substring(1);
      }).join(' ');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Recorder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: widget.onLogout,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Column(
        children: [
          // User Card / Info header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userEmail,
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _userRole == 'ADMIN' ? Colors.green.withValues(alpha: 0.2) : Colors.blue.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _userRole,
                              style: textTheme.labelSmall?.copyWith(
                                color: _userRole == 'ADMIN' ? Colors.green : Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (_userRole == 'ADMIN') ...[
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isAdminMode = !_isAdminMode;
                                  _isLoading = true;
                                });
                                _loadTasksAndDetails();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _isAdminMode ? Colors.purple.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  _isAdminMode ? 'ADMIN VIEW' : 'WORKER VIEW',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: _isAdminMode ? Colors.purple : Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                if (_farms.isNotEmpty)
                  DropdownButton<Map<String, dynamic>>(
                    value: _selectedFarm,
                    onChanged: (farm) async {
                      if (farm != null) {
                        setState(() {
                          _selectedFarm = farm;
                          _isLoading = true;
                        });
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('active_farm_id', farm['id'] as String);
                        _loadTasksAndDetails();
                      }
                    },
                    items: _farms.map<DropdownMenuItem<Map<String, dynamic>>>((farm) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: farm,
                        child: Text(farm['name'] ?? 'Unnamed Farm'),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),

          // Sub-navigation for Admins
          if (_userRole == 'ADMIN' && _isAdminMode) ...[
            Container(
              color: colorScheme.surface,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _navButton(0, 'Tasks', Icons.assignment_outlined),
                  _navButton(1, 'Assign Task', Icons.add_task),
                  _navButton(2, 'Workers', Icons.people_outline),
                ],
              ),
            ),
            const Divider(height: 1),
          ],

          // Main Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.green))
                : _buildMainContent(colorScheme, textTheme, formatStatus),
          ),
        ],
      ),
    );
  }

  Widget _navButton(int index, String label, IconData icon) {
    final isSelected = _adminTabIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _adminTabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.green : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: isSelected ? Colors.green : Colors.grey),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.green : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(ColorScheme colorScheme, TextTheme textTheme, String Function(String) formatStatus) {
    if (_userRole == 'ADMIN' && _isAdminMode) {
      if (_adminTabIndex == 1) {
        return _buildAssignTaskView(colorScheme, textTheme);
      } else if (_adminTabIndex == 2) {
        return _buildManageWorkersView(colorScheme, textTheme);
      }
    }

    // Default Tasks List View
    if (_tasks.isEmpty) {
      return RefreshIndicator(
        onRefresh: _loadTasksAndDetails,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle_outline, size: 72, color: colorScheme.primary),
                ),
                const SizedBox(height: 24),
                Text('No tasks here!', style: textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  'There are no tasks for this farm right now.',
                  style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadTasksAndDetails,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: _tasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, index) {
          final task = _tasks[index];
          final taskId = task['id'] as String;
          final isCompleted = task['status'] == 'COMPLETED' || task['status'] == 'REVIEWED';
          final evidenceFile = _taskEvidence[taskId];
          final eType = _evidenceType[taskId];
          final statusStr = task['status'] ?? 'PENDING';
          final statusColor = _getStatusColor(statusStr, context);
          final assignedTo = task['assignedTo'] ?? 'Unassigned';

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task['title'] ?? 'Untitled Task',
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (task['description'] != null && (task['description'] as String).isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                task['description'] as String,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  height: 1.4,
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Text(
                              'Assigned To: $assignedTo',
                              style: textTheme.bodySmall?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: statusColor.withValues(alpha: 0.2), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              formatStatus(statusStr),
                              style: textTheme.labelMedium?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32, thickness: 1),

                  // If Admin Mode, show task status review buttons
                  if (_userRole == 'ADMIN' && _isAdminMode) ...[
                    if (task['status'] == 'COMPLETED') ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton.icon(
                            style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                            onPressed: () async {
                              setState(() => _isLoading = true);
                              try {
                                await widget.apiService.updateTaskStatus(taskId, 'REVIEWED');
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Task status updated to REVIEWED.')),
                                );
                                await _loadTasksAndDetails();
                              } catch (e) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to update status: $e')),
                                );
                                setState(() => _isLoading = false);
                              }
                            },
                            icon: const Icon(Icons.rate_review_outlined, size: 18),
                            label: const Text('Approve & Review'),
                          ),
                        ],
                      )
                    ] else ...[
                      Text(
                        'Status: ${formatStatus(statusStr)}',
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ]
                  ] else ...[
                    // Standard Worker View
                    if (!isCompleted) ...[
                      Text(
                        'Attach Evidence (Required)',
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 14,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _EvidenceButton(
                              icon: Icons.camera_alt_outlined,
                              label: 'Photo',
                              isSelected: eType == 'IMAGE',
                              onPressed: () => _captureEvidence(taskId, 'IMAGE'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _EvidenceButton(
                              icon: Icons.videocam_outlined,
                              label: 'Video',
                              isSelected: eType == 'VIDEO',
                              onPressed: () => _captureEvidence(taskId, 'VIDEO'),
                            ),
                          ),
                        ],
                      ),
                      if (evidenceFile != null && eType != null) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                eType == 'IMAGE' ? Icons.image_outlined : Icons.video_file_outlined,
                                color: colorScheme.primary,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '${eType == 'IMAGE' ? 'Photo' : 'Video'} attached successfully',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.cancel_outlined, size: 20, color: colorScheme.error),
                                onPressed: () {
                                  setState(() {
                                    _taskEvidence.remove(taskId);
                                    _evidenceType.remove(taskId);
                                  });
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: _isLoading ? null : () => _completeTask(task),
                        icon: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.check_circle_outline, size: 20),
                        label: Text(_isLoading ? 'Processing...' : 'Mark as Completed'),
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.15)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: colorScheme.primary, size: 22),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Completed with evidence attached.',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAssignTaskView(ColorScheme colorScheme, TextTheme textTheme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Assign New Farm Task', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(
            controller: _taskTitleController,
            decoration: const InputDecoration(
              labelText: 'Task Title *',
              border: OutlineInputBorder(),
              hintText: 'e.g. Inspect tomato patch A for pests',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _taskDescriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description / Instructions',
              border: OutlineInputBorder(),
              hintText: 'Instructions for safety gear, application rates...',
            ),
          ),
          const SizedBox(height: 16),
          
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Assign To Worker *',
              border: OutlineInputBorder(),
            ),
            initialValue: _assignTargetWorkerEmail.isEmpty ? null : _assignTargetWorkerEmail,
            onChanged: (email) {
              if (email != null) {
                setState(() {
                  _assignTargetWorkerEmail = email;
                });
              }
            },
            items: _farmWorkers.map((email) {
              return DropdownMenuItem<String>(
                value: email,
                child: Text(email),
              );
            }).toList(),
            hint: const Text('Select an assigned farm worker'),
          ),
          const SizedBox(height: 16),

          ListTile(
            title: const Text('Due Date'),
            subtitle: Text('${_selectedDueDate.toLocal()}'),
            trailing: const Icon(Icons.calendar_today),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(4),
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _selectedDueDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date != null) {
                if (!mounted) return;
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(_selectedDueDate),
                );
                if (time != null) {
                  setState(() {
                    _selectedDueDate = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );
                  });
                }
              }
            },
          ),
          const SizedBox(height: 24),
          
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _handleCreateTask,
            icon: const Icon(Icons.add_task),
            label: const Text('Assign Task', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildManageWorkersView(ColorScheme colorScheme, TextTheme textTheme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section 1: Assigned Workers list
          Text(
            'Assigned Farm Workers',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _farmWorkers.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No workers assigned to this farm yet.',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _farmWorkers.length,
                    itemBuilder: (context, idx) {
                      final email = _farmWorkers[idx];
                      return ListTile(
                        title: Text(email),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                          onPressed: () => _handleUnassignWorker(email),
                          tooltip: 'Unassign Worker',
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 24),

          // Section 2: Assign worker to farm
          Text(
            'Assign Worker to Farm',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _workerEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Worker Email',
                    border: OutlineInputBorder(),
                    hintText: 'enter.email@domain.com',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.green),
                onPressed: _handleAssignWorker,
                child: const Text('Assign'),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Section 3: Promote worker to Admin
          Text(
            'Promote Worker to Admin (SaaS Global)',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promoteEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Worker Email',
                    border: OutlineInputBorder(),
                    hintText: 'enter.email@domain.com',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: _handlePromoteWorker,
                child: const Text('Promote'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EvidenceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _EvidenceButton({required this.icon, required this.label, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
        backgroundColor: isSelected ? colorScheme.primaryContainer : Colors.transparent,
        side: BorderSide(color: isSelected ? colorScheme.primary : colorScheme.outline, width: isSelected ? 2 : 1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}
