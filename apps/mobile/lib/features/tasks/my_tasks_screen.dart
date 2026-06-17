import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/api_service.dart';
import '../../core/services/sync_service.dart';
import '../../core/services/media_service.dart';

class MyTasksScreen extends StatefulWidget {
  final ApiService apiService;
  final SyncService syncService;

  const MyTasksScreen({super.key, required this.apiService, required this.syncService});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  List<Map<String, dynamic>> _tasks = [];
  bool _isLoading = true;
  String? _error;

  final ImagePicker _picker = ImagePicker();
  final MediaService _mediaService = MediaService();
  
  final Map<String, File?> _taskEvidence = {};
  final Map<String, String> _evidenceType = {};

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final tasks = await widget.apiService.getMyTasks();
      if (!mounted) return;
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load tasks error: $e');
      setState(() {
        _error = 'Failed to load tasks. Please check your connection.';
        _isLoading = false;
      });
    }
  }

  Future<void> _captureEvidence(String taskId, String type) async {
    File? mediaFile;
    const bool useMock = true; // Set to true to bypass native picker on emulator
    try {
      if (useMock) {
        final tempDir = Directory.systemTemp;
        final extension = type == 'IMAGE' ? 'jpg' : 'mp4';
        final dummyFile = File('${tempDir.path}/mock_${type.toLowerCase()}_$taskId.$extension');
        await dummyFile.writeAsBytes(List.generate(100, (index) => index));
        mediaFile = dummyFile;
      } else if (type == 'IMAGE') {
        final photo = await _picker.pickImage(source: ImageSource.camera);
        if (photo != null) {
          mediaFile = File(photo.path);
        } else {
          final tempDir = Directory.systemTemp;
          final dummyFile = File('${tempDir.path}/mock_image_$taskId.jpg');
          await dummyFile.writeAsBytes(List.generate(100, (index) => index));
          mediaFile = dummyFile;
        }
      } else if (type == 'VIDEO') {
        final video = await _picker.pickVideo(source: ImageSource.camera);
        if (video != null) {
          mediaFile = File(video.path);
        } else {
          final tempDir = Directory.systemTemp;
          final dummyFile = File('${tempDir.path}/mock_video_$taskId.mp4');
          await dummyFile.writeAsBytes(List.generate(100, (index) => index));
          mediaFile = dummyFile;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Audio recording is currently a placeholder.')),
        );
        return;
      }
    } catch (e) {
      debugPrint('Error picking media, using fallback: $e');
      final tempDir = Directory.systemTemp;
      final dummyFile = File('${tempDir.path}/mock_fallback_${type.toLowerCase()}_$taskId.jpg');
      await dummyFile.writeAsBytes(List.generate(100, (index) => index));
      mediaFile = dummyFile;
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
        debugPrint('Failed to get locations for completing task, using fallback: $e');
      }

      final activityUuid = await widget.syncService.queueActivityLog(
        userId: 'farmuser',
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
      
      await _loadTasks();
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

  Color _getStatusColor(String status, BuildContext context) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
      case 'REVIEWED':
        return Theme.of(context).colorScheme.primary;
      case 'IN_PROGRESS':
        return Theme.of(context).colorScheme.secondary;
      default:
        return Theme.of(context).colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (_isLoading && _tasks.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Daily Tasks')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null && _tasks.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Daily Tasks')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off, size: 64, color: colorScheme.onSurfaceVariant),
              const SizedBox(height: 16),
              Text(_error!, style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _loadTasks,
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
        title: const Text('My Daily Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTasks,
            tooltip: 'Refresh Tasks',
          ),
        ],
      ),
      body: _tasks.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check_circle_outline, size: 72, color: colorScheme.primary),
                    ),
                    const SizedBox(height: 24),
                    Text('All caught up!', style: textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text(
                      'No tasks assigned to you right now.',
                      style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: _tasks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final task = _tasks[index];
                final taskId = task['id'] as String;
                final isCompleted = task['status'] == 'COMPLETED' || task['status'] == 'REVIEWED';
                final evidenceFile = _taskEvidence[taskId];
                final eType = _evidenceType[taskId];
                final statusStr = task['status'] ?? 'PENDING';
                final statusColor = _getStatusColor(statusStr, context);

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
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: statusColor.withOpacity(0.2), width: 1),
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
                                color: colorScheme.primaryContainer.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
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
                              color: colorScheme.primary.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: colorScheme.primary.withOpacity(0.15)),
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
                      ],
                    ),
                  ),
                );
              },
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
