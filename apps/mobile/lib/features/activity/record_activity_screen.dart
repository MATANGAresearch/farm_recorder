import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../core/services/api_service.dart';
import '../../core/services/sync_service.dart';
import '../../core/services/media_service.dart';
import '../../core/db/app_database.dart';
import '../../core/db/cached_chemical.dart';
import '../../core/db/cached_input_batch.dart';
import 'create_location_dialog.dart';
import 'create_product_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/gs1_parser.dart';

class RecordActivityScreen extends StatefulWidget {
  final ApiService apiService;
  final SyncService syncService;
  final MediaService? mediaService;

  const RecordActivityScreen({
    super.key,
    required this.apiService,
    required this.syncService,
    this.mediaService,
  });

  @override
  State<RecordActivityScreen> createState() => _RecordActivityScreenState();
}

class _RecordActivityScreenState extends State<RecordActivityScreen> {
  late final MediaService _mediaService;
  final _notesController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _customerEmailController = TextEditingController();
  final _inputUsedController = TextEditingController();

  // New chemical and spraying controllers
  final _chemicalLotController = TextEditingController();
  final _chemicalExpController = TextEditingController();
  final _applicationRateController = TextEditingController();
  final _quantityAppliedController = TextEditingController();
  final _windSpeedController = TextEditingController();
  final _windDirectionController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _applicatorLicenseController = TextEditingController();
  final _manualInputCommentsController = TextEditingController();

  String? _selectedType;
  String? _selectedLocationId;
  String? _selectedProductId;
  String? _selectedBatchId;
  String? _inspectionType;

  DateTime? _startTime;
  DateTime? _endTime;

  File? _capturedMedia;
  MediaType _selectedMediaType = MediaType.IMAGE;
  double? _gpsLat;
  double? _gpsLng;
  bool _isProcessing = false;

  List<Map<String, dynamic>> _locations = [];
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _batches = [];
  bool _isLoadingData = true;

  // Spraying specifics
  bool _isManualInput = false;
  bool _autoVerify = false;
  String? _selectedOperatorId;
  CachedChemical? _resolvedChemical;
  CachedInputBatch? _matchedInputBatch;
  final List<String> _operators = ['farmuser', 'worker_1', 'worker_2'];

  final List<String> _activityTypes = ['PLANTING', 'HARVESTING', 'SPRAYING', 'INSPECTION', 'CLEANING', 'DIRECT_SALE'];
  final List<String> _inspectionTypes = ['PEST', 'DISEASE', 'SOIL', 'GAP_AUDIT', 'OTHER'];

  @override
  void initState() {
    super.initState();
    _mediaService = widget.mediaService ?? MediaService();
    _loadInitialData();
  }

  @override
  void dispose() {
    _notesController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _customerEmailController.dispose();
    _inputUsedController.dispose();
    _chemicalLotController.dispose();
    _chemicalExpController.dispose();
    _applicationRateController.dispose();
    _quantityAppliedController.dispose();
    _windSpeedController.dispose();
    _windDirectionController.dispose();
    _temperatureController.dispose();
    _applicatorLicenseController.dispose();
    _manualInputCommentsController.dispose();
    super.dispose();
  }

  Future<void> _fetchLocalWeather() async {
    if (_gpsLat == null || _gpsLng == null) return;
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': _gpsLat,
          'longitude': _gpsLng,
          'current': 'temperature_2m,wind_speed_10m,wind_direction_10m',
        },
      );
      final current = response.data['current'];
      if (current != null) {
        final double temp = current['temperature_2m'];
        final double windSpeed = current['wind_speed_10m'];
        final double windDirDeg = current['wind_direction_10m'];
        final windDir = _getCardinalDirection(windDirDeg);

        setState(() {
          _temperatureController.text = temp.toString();
          _windSpeedController.text = windSpeed.toString();
          _windDirectionController.text = windDir;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Local weather auto-fetched from GPS location.')),
        );
      }
    } catch (e) {
      debugPrint('Failed to fetch weather locally: $e');
    }
  }

  String _getCardinalDirection(double degrees) {
    final directions = ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', 'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW'];
    final index = ((degrees % 360) / 22.5).round();
    return directions[index % 16];
  }

  Future<void> _fetchGPSAndWeather() async {
    setState(() => _isProcessing = true);
    try {
      final location = await _mediaService.getCurrentLocation();
      if (location != null) {
        setState(() {
          _gpsLat = location.latitude;
          _gpsLng = location.longitude;
        });
        await _fetchLocalWeather();
      }
    } catch (e) {
      debugPrint('Failed to get location: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _selectExpirationDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) {
      setState(() {
        _chemicalExpController.text = picked.toIso8601String().substring(0, 10);
      });
    }
  }

  Future<void> _showScanDialog() async {
    final controller = TextEditingController(text: '(01)00871234567890(17)281231(10)LOT-CHEM-999');
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Simulate Barcode Scanner'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter a raw GS1-128 or GS1 DataMatrix barcode:'),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Raw Barcode',
                hintText: '(01)GTIN(17)YYMMDD(10)LOT',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final raw = controller.text;
              final parsed = Gs1Parser.parse(raw);

              CachedInputBatch? matchedBatch;
              if (parsed.gtin != null && parsed.lotNumber != null) {
                matchedBatch = await AppDatabase.isar.cachedInputBatchs
                    .filter()
                    .gtinEqualTo(parsed.gtin!)
                    .lotNumberEqualTo(parsed.lotNumber!)
                    .findFirst();
              }

              setState(() {
                _isManualInput = false;
                _chemicalLotController.text = parsed.lotNumber ?? '';
                _matchedInputBatch = matchedBatch;
                if (matchedBatch != null) {
                  _chemicalExpController.text = matchedBatch.expirationDate.substring(0, 10);
                } else if (parsed.expirationDate != null) {
                  _chemicalExpController.text = parsed.expirationDate!.toIso8601String().substring(0, 10);
                } else {
                  _chemicalExpController.text = '';
                }
              });

              if (parsed.gtin != null) {
                final cached = await AppDatabase.isar.cachedChemicals
                    .filter()
                    .gtinEqualTo(parsed.gtin!)
                    .findFirst();
                if (!mounted) return;
                if (cached != null) {
                  setState(() {
                    _resolvedChemical = cached;
                    _inputUsedController.text = cached.name;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Chemical resolved: ${cached.name}')),
                  );
                } else {
                  setState(() {
                    _resolvedChemical = null;
                    _inputUsedController.text = 'GTIN: ${parsed.gtin}';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Unrecognized chemical GTIN.')),
                  );
                }
              }
            },
            child: const Text('Parse'),
          ),
        ],
      ),
    );
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoadingData = true);
    try {
      final locations = await widget.apiService.getLocations();
      final products = await widget.apiService.getProducts();
      await widget.syncService.fetchAndCacheInventory();
      if (!mounted) return;
      setState(() {
        _locations = locations;
        _products = products;
        _isLoadingData = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingData = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to load data: $e',
            style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
        ),
      );
    }
  }

  Future<void> _loadBatches() async {
    if (_selectedProductId == null) return;
    try {
      final batches = await widget.apiService.getAvailableBatches(_selectedProductId!);
      if (!mounted) return;
      setState(() => _batches = batches);
    } catch (e) {
      debugPrint('Failed to load batches: $e');
    }
  }

  void _toggleTimer() {
    if (_startTime == null) {
      setState(() => _startTime = DateTime.now());
    } else if (_endTime == null) {
      setState(() => _endTime = DateTime.now());
    } else {
      setState(() {
        _startTime = DateTime.now();
        _endTime = null;
      });
    }
  }

  Future<void> _captureMedia() async {
    setState(() => _isProcessing = true);
    try {
      final location = await _mediaService.getCurrentLocation();
      if (location != null) {
        if (!mounted) return;
        setState(() {
          _gpsLat = location.latitude;
          _gpsLng = location.longitude;
        });
        _fetchLocalWeather();
      }

      final media = await _mediaService.captureMedia(_selectedMediaType);
      if (media != null) {
        if (!mounted) return;
        setState(() => _capturedMedia = media);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error capturing media: $e',
            style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
        ),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  bool _validateForm() {
    if (_selectedType == null || _selectedLocationId == null) return false;
    
    final requiresProduct = ['PLANTING', 'HARVESTING', 'SPRAYING', 'INSPECTION'].contains(_selectedType);
    if (requiresProduct && _selectedProductId == null) return false;

    if (['PLANTING', 'HARVESTING', 'DIRECT_SALE'].contains(_selectedType)) {
      if (_quantityController.text.isEmpty) return false;
    }

    if (_selectedType == 'DIRECT_SALE') {
      if (_selectedBatchId == null || _unitPriceController.text.isEmpty) return false;
    }

    if (_selectedType == 'SPRAYING') {
      if (_inputUsedController.text.isEmpty) return false;
      if (_chemicalLotController.text.isEmpty) return false;
      if (_quantityAppliedController.text.isEmpty) return false;
    }

    return true;
  }

  Future<void> _saveActivity() async {
    if (!_validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all required fields for the selected activity type.',
            style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      double? unitPrice = _unitPriceController.text.isNotEmpty ? double.tryParse(_unitPriceController.text) : null;
      int? quantity = _quantityController.text.isNotEmpty ? int.tryParse(_quantityController.text) : null;
      double? totalPrice = (unitPrice != null && quantity != null) ? (unitPrice * quantity) : null;

      String finalNotes = _notesController.text;
      if (_selectedType == 'SPRAYING') {
        finalNotes = 'Input Used: ${_inputUsedController.text}\n\n$finalNotes';
      } else if (_selectedType == 'INSPECTION') {
        finalNotes = 'Inspection Type: $_inspectionType\n\n$finalNotes';
      }

      final activityUuid = await widget.syncService.queueActivityLog(
        userId: _selectedOperatorId ?? 'farmuser',
        locationId: _selectedLocationId!,
        type: _selectedType!,
        productId: _selectedProductId,
        notes: finalNotes,
        gpsLat: _gpsLat,
        gpsLng: _gpsLng,
        startTime: _startTime?.toIso8601String(),
        endTime: _endTime?.toIso8601String(),
        batchId: _selectedBatchId,
        quantity: quantity,
        unitPrice: unitPrice,
        totalPrice: totalPrice,
        customerName: _customerNameController.text.isNotEmpty ? _customerNameController.text : null,
        customerPhone: _customerPhoneController.text.isNotEmpty ? _customerPhoneController.text : null,
        customerEmail: _customerEmailController.text.isNotEmpty ? _customerEmailController.text : null,
        chemicalLotNumber: _selectedType == 'SPRAYING' && _chemicalLotController.text.isNotEmpty ? _chemicalLotController.text : null,
        chemicalExpirationDate: _selectedType == 'SPRAYING' && _chemicalExpController.text.isNotEmpty ? _chemicalExpController.text : null,
        applicationRate: _selectedType == 'SPRAYING' && _applicationRateController.text.isNotEmpty ? _applicationRateController.text : null,
        totalQuantityApplied: _selectedType == 'SPRAYING' && _quantityAppliedController.text.isNotEmpty ? double.tryParse(_quantityAppliedController.text) : null,
        weatherWindSpeed: _windSpeedController.text.isNotEmpty ? double.tryParse(_windSpeedController.text) : null,
        weatherWindDirection: _windDirectionController.text.isNotEmpty ? _windDirectionController.text : null,
        weatherTemperature: _temperatureController.text.isNotEmpty ? double.tryParse(_temperatureController.text) : null,
        applicatorLicense: _selectedType == 'SPRAYING' && _applicatorLicenseController.text.isNotEmpty ? _applicatorLicenseController.text : null,
        isManualInput: _selectedType == 'SPRAYING' ? _isManualInput : null,
        manualInputComments: _selectedType == 'SPRAYING' && _isManualInput && _manualInputCommentsController.text.isNotEmpty ? _manualInputCommentsController.text : null,
        verificationStatus: _selectedType == 'SPRAYING' ? (_autoVerify ? 'VERIFIED' : 'PENDING') : null,
        verifiedBy: _selectedType == 'SPRAYING' && _autoVerify ? 'farmuser' : null,
        verifiedAt: _selectedType == 'SPRAYING' && _autoVerify ? DateTime.now().toIso8601String() : null,
      );

      if (_capturedMedia != null) {
        final prefs = await SharedPreferences.getInstance();
        final farmId = prefs.getString('active_farm_id') ?? 'farm-123';
        final mediaUrl = await _mediaService.uploadMediaToMinIO(_capturedMedia!, _selectedMediaType, farmId, 'task-none', widget.apiService);
        if (mediaUrl != null) {
          await widget.syncService.queueMedia(
            activityLogUuid: activityUuid,
            mediaUrl: mediaUrl,
            mediaType: _selectedMediaType.name,
            capturedGpsLat: _gpsLat,
            capturedGpsLng: _gpsLng,
          );
        }
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Activity and media recorded successfully!',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
      );

      setState(() {
        _selectedType = null;
        _selectedLocationId = null;
        _selectedProductId = null;
        _selectedBatchId = null;
        _inspectionType = null;
        _startTime = null;
        _endTime = null;
        _quantityController.clear();
        _unitPriceController.clear();
        _customerNameController.clear();
        _customerPhoneController.clear();
        _customerEmailController.clear();
        _inputUsedController.clear();
        _notesController.clear();
        _capturedMedia = null;
        _gpsLat = null;
        _gpsLng = null;
        _batches = [];
        _chemicalLotController.clear();
        _chemicalExpController.clear();
        _applicationRateController.clear();
        _quantityAppliedController.clear();
        _windSpeedController.clear();
        _windDirectionController.clear();
        _temperatureController.clear();
        _applicatorLicenseController.clear();
        _manualInputCommentsController.clear();
        _isManualInput = false;
        _autoVerify = false;
        _selectedOperatorId = null;
        _resolvedChemical = null;
        _matchedInputBatch = null;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error saving activity: $e',
            style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
        ),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--:--';
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour % 12 == 0 ? 12 : hour % 12;
    return '$formattedHour:$minute $period';
  }

  String _getDurationText() {
    if (_startTime == null) return 'No active session';
    final end = _endTime ?? DateTime.now();
    final diff = end.difference(_startTime!);
    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);
    final seconds = diff.inSeconds.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  String _formatEnumValue(String value) {
    return value.replaceAll('_', ' ').toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return '';
      if (word == 'gap') return 'GAP';
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bool requiresProduct = ['PLANTING', 'HARVESTING', 'SPRAYING', 'INSPECTION'].contains(_selectedType);
    final bool requiresQuantity = ['PLANTING', 'HARVESTING', 'DIRECT_SALE'].contains(_selectedType);
    final bool isSale = _selectedType == 'DIRECT_SALE';
    final bool isSpraying = _selectedType == 'SPRAYING';
    final bool isInspection = _selectedType == 'INSPECTION';

    if (_isLoadingData) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Activity')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Record Activity')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SectionHeader(title: 'Basic Information', icon: Icons.info_outline),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Location / Plot *',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                    value: _selectedLocationId,
                    items: _locations
                        .map((loc) => DropdownMenuItem(
                              value: loc['id'] as String,
                              child: Text(
                                '${loc['name']} (${loc['gln']})',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => _selectedLocationId = value),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                  onPressed: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => CreateLocationDialog(apiService: widget.apiService),
                    );
                    if (result != null) {
                      final updatedLocations = await widget.apiService.getLocations();
                      setState(() {
                        _locations = updatedLocations;
                        _selectedLocationId = result['id'] as String;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Activity Type *',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              initialValue: _selectedType,
              items: _activityTypes
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(
                          _formatEnumValue(type),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                  _selectedProductId = null;
                  _selectedBatchId = null;
                  _batches = [];
                  if (value == 'DIRECT_SALE' && _selectedProductId != null) _loadBatches();
                });
              },
            ),
            
            if (requiresProduct) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Crop / Product *',
                        prefixIcon: Icon(Icons.eco_outlined),
                      ),
                      value: _selectedProductId,
                      hint: const Text(
                        'Select the crop being managed',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      items: _products
                          .map((prod) => DropdownMenuItem(
                                value: prod['id'] as String,
                                child: Text(
                                  prod['name'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedProductId = value;
                          if (_selectedType == 'DIRECT_SALE') _loadBatches();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                    onPressed: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (context) => CreateProductDialog(apiService: widget.apiService),
                      );
                      if (result != null) {
                        final updatedProducts = await widget.apiService.getProducts();
                        setState(() {
                          _products = updatedProducts;
                          _selectedProductId = result['id'] as String;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],

            const SizedBox(height: 36),
            const _SectionHeader(title: 'Activity Details', icon: Icons.description_outlined),
            const SizedBox(height: 20),

            if (isSpraying) ...[
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chemical Tracking (GS1 Scan / Manual)',
                            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          IconButton.filledTonal(
                            onPressed: _showScanDialog,
                            icon: const Icon(Icons.qr_code_scanner),
                            tooltip: 'Scan Chemical Barcode',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        title: const Text('Manual Input Mode'),
                        subtitle: const Text('Toggle to manually input chemical information if barcode is damaged or missing.'),
                        value: _isManualInput,
                        onChanged: (value) {
                          setState(() {
                            _isManualInput = value;
                            if (!value) {
                              _inputUsedController.clear();
                              _chemicalLotController.clear();
                              _chemicalExpController.clear();
                              _resolvedChemical = null;
                            }
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _inputUsedController,
                        enabled: _isManualInput,
                        decoration: InputDecoration(
                          labelText: 'Input / Chemical Used *',
                          prefixIcon: const Icon(Icons.science_outlined),
                          hintText: _isManualInput
                              ? 'e.g., Organic Neem Oil'
                              : 'Scan barcode to populate chemical info',
                        ),
                      ),
                      if (_isManualInput) ...[
                        const SizedBox(height: 12),
                        TextField(
                          controller: _manualInputCommentsController,
                          decoration: const InputDecoration(
                            labelText: 'Reason for Manual Entry',
                            prefixIcon: Icon(Icons.comment_outlined),
                            hintText: 'e.g., Barcode is ripped / unavailable',
                          ),
                        ),
                      ],
                      if (_matchedInputBatch != null) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.inventory_2_outlined, color: colorScheme.primary),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Active Inventory Lot Found',
                                      style: textTheme.labelLarge?.copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Remaining Stock: ${_matchedInputBatch!.remainingQuantity.toStringAsFixed(2)} ${_matchedInputBatch!.unit}',
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (_resolvedChemical != null) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: colorScheme.errorContainer.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: colorScheme.error.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.warning_amber_rounded, color: colorScheme.error),
                                  const SizedBox(width: 8),
                                  Text(
                                    'GAP Compliance Safety Information',
                                    style: textTheme.labelLarge?.copyWith(
                                      color: colorScheme.error,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Chemical: ${_resolvedChemical!.name}',
                                style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              if (_resolvedChemical!.variety != null)
                                Text('Variety/Brand: ${_resolvedChemical!.variety}'),
                              if (_resolvedChemical!.epaRegistrationNumber != null)
                                Text('EPA Reg No: ${_resolvedChemical!.epaRegistrationNumber}'),
                              if (_resolvedChemical!.activeIngredients != null)
                                Text('Active Ingredients: ${_resolvedChemical!.activeIngredients}'),
                              const Divider(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _SafetyIndicator(
                                      label: 'REI Lockout',
                                      value: _resolvedChemical!.reiHours != null
                                          ? '${_resolvedChemical!.reiHours} hours'
                                          : 'N/A',
                                      icon: Icons.lock_clock_outlined,
                                      color: colorScheme.error,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _SafetyIndicator(
                                      label: 'PHI Wait Time',
                                      value: _resolvedChemical!.phiDays != null
                                          ? '${_resolvedChemical!.phiDays} days'
                                          : 'N/A',
                                      icon: Icons.calendar_today_outlined,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _chemicalLotController,
                              decoration: const InputDecoration(
                                labelText: 'Lot Number *',
                                prefixIcon: Icon(Icons.numbers_outlined),
                                hintText: 'Lot number',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _chemicalExpController,
                              readOnly: true,
                              onTap: _selectExpirationDate,
                              decoration: const InputDecoration(
                                labelText: 'Expiration Date',
                                prefixIcon: Icon(Icons.date_range_outlined),
                                hintText: 'YYYY-MM-DD',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _applicationRateController,
                              decoration: const InputDecoration(
                                labelText: 'Application Rate',
                                prefixIcon: Icon(Icons.speed_outlined),
                                hintText: 'e.g. 1.5 L/ha',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _quantityAppliedController,
                              decoration: const InputDecoration(
                                labelText: 'Total Qty Applied (L) *',
                                prefixIcon: Icon(Icons.scale_outlined),
                                hintText: 'e.g. 10.5',
                              ),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _applicatorLicenseController,
                        decoration: const InputDecoration(
                          labelText: 'Applicator License Number',
                          prefixIcon: Icon(Icons.badge_outlined),
                          hintText: 'e.g. LIC-998877',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            if (isInspection) ...[
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Inspection Type',
                  prefixIcon: Icon(Icons.search_outlined),
                ),
                initialValue: _inspectionType,
                items: _inspectionTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(
                            _formatEnumValue(type),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _inspectionType = value),
              ),
              const SizedBox(height: 20),
            ],

            if (requiresQuantity) ...[
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity *',
                  prefixIcon: const Icon(Icons.scale_outlined),
                  hintText: isSale
                      ? 'Bunches sold'
                      : (isSpraying ? 'Liters applied' : 'Units planted/harvested'),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
            ],

            if (isSale) ...[
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Harvest Batch *',
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                ),
                initialValue: _selectedBatchId,
                hint: const Text(
                  'Select batch being sold',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                items: _batches
                    .map((b) => DropdownMenuItem<String>(
                          value: b['id'] as String,
                          child: Text(
                            '${b['batchNumber']} (${b['remainingQuantity']} left)',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedBatchId = value),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _unitPriceController,
                decoration: const InputDecoration(
                  labelText: 'Unit Price (\$) *',
                  prefixIcon: Icon(Icons.attach_money_outlined),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 20),
              if (_unitPriceController.text.isNotEmpty && _quantityController.text.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Revenue:',
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '\$${(double.parse(_unitPriceController.text) * int.parse(_quantityController.text)).toStringAsFixed(2)}',
                        style: textTheme.headlineMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
              TextField(
                controller: _customerNameController,
                decoration: const InputDecoration(
                  labelText: 'Customer Name',
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Walk-in or Registered',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _customerPhoneController,
                decoration: const InputDecoration(
                  labelText: 'Customer Phone',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
            ],

            const SizedBox(height: 36),
            const _SectionHeader(title: 'Environmental Conditions (GAP)', icon: Icons.wb_sunny_outlined),
            const SizedBox(height: 20),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _gpsLat != null && _gpsLng != null
                                ? 'GPS: ${_gpsLat!.toStringAsFixed(5)}, ${_gpsLng!.toStringAsFixed(5)}'
                                : 'GPS Coordinates: Not captured',
                            style: textTheme.bodyMedium,
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: _fetchGPSAndWeather,
                          icon: const Icon(Icons.gps_fixed),
                          label: const Text('Fetch GPS & Weather'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _temperatureController,
                            decoration: const InputDecoration(
                              labelText: 'Temperature (°C)',
                              prefixIcon: Icon(Icons.thermostat_outlined),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _windSpeedController,
                            decoration: const InputDecoration(
                              labelText: 'Wind Speed (km/h)',
                              prefixIcon: Icon(Icons.air_outlined),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _windDirectionController,
                      decoration: const InputDecoration(
                        labelText: 'Wind Direction (e.g. N, SW, ENE)',
                        prefixIcon: Icon(Icons.explore_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 36),
            const _SectionHeader(title: 'Labor & Notes', icon: Icons.access_time_outlined),
            const SizedBox(height: 20),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer_outlined, color: colorScheme.primary, size: 22),
                            const SizedBox(width: 8),
                            Text('Labor Tracking', style: textTheme.titleMedium),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _startTime == null
                                ? colorScheme.outline.withValues(alpha: 0.08)
                                : (_endTime == null
                                    ? colorScheme.primary.withValues(alpha: 0.08)
                                    : colorScheme.secondary.withValues(alpha: 0.08)),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _startTime == null
                                  ? colorScheme.outline.withValues(alpha: 0.2)
                                  : (_endTime == null
                                      ? colorScheme.primary.withValues(alpha: 0.2)
                                      : colorScheme.secondary.withValues(alpha: 0.2)),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_startTime != null && _endTime == null) ...[
                                _PulsingDot(color: colorScheme.primary),
                                const SizedBox(width: 6),
                              ],
                              Text(
                                _startTime == null
                                    ? 'No Session'
                                    : (_endTime == null ? 'Active' : 'Completed'),
                                style: textTheme.labelMedium?.copyWith(
                                  color: _startTime == null
                                      ? colorScheme.outline
                                      : (_endTime == null
                                          ? colorScheme.primary
                                          : colorScheme.secondary),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _TimeRow(label: 'Start time', value: _formatTime(_startTime)),
                              const SizedBox(height: 8),
                              _TimeRow(label: 'End time', value: _formatTime(_endTime)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        FilledButton(
                          onPressed: _isProcessing ? null : _toggleTimer,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(110, 48),
                            backgroundColor: _startTime == null
                                ? colorScheme.primary
                                : (_endTime == null ? colorScheme.error : colorScheme.secondary),
                            foregroundColor: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(_startTime == null
                                  ? Icons.play_arrow
                                  : (_endTime == null ? Icons.stop : Icons.restart_alt)),
                              const SizedBox(width: 6),
                              Text(_startTime == null
                                  ? 'Start'
                                  : (_endTime == null ? 'Stop' : 'Reset')),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_startTime != null) ...[
                      const Divider(height: 32, thickness: 0.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Session Duration:',
                            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                          Text(
                            _getDurationText(),
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'GAP Compliance Notes',
                prefixIcon: Icon(Icons.note_add_outlined),
                hintText: 'Weather, soil conditions, observations...',
                alignLabelWithHint: true,
              ),
              maxLines: 4,
            ),

            const SizedBox(height: 36),
            const _SectionHeader(title: 'Supervisor Actions & Verification', icon: Icons.admin_panel_settings_outlined),
            const SizedBox(height: 20),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: colorScheme.primary.withValues(alpha: 0.2)),
              ),
              color: colorScheme.primaryContainer.withValues(alpha: 0.05),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Applicator / Operator Override',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      initialValue: _selectedOperatorId,
                      hint: const Text('Default (Current worker)'),
                      items: _operators
                          .map((op) => DropdownMenuItem(
                                value: op,
                                child: Text(op),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() => _selectedOperatorId = value),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(
                        'Auto-Verify & Sign Off Record',
                        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text(
                        'Marks record as verified immediately. No verification task will be assigned.',
                      ),
                      value: _autoVerify,
                      onChanged: (value) => setState(() => _autoVerify = value),
                      activeThumbColor: colorScheme.primary,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 36),
            const _SectionHeader(title: 'Evidence', icon: Icons.camera_alt_outlined),
            const SizedBox(height: 20),
            
            SegmentedButton<MediaType>(
              segments: const [
                ButtonSegment(value: MediaType.IMAGE, label: Text('Photo'), icon: Icon(Icons.camera_alt_outlined)),
                ButtonSegment(value: MediaType.VIDEO, label: Text('Video'), icon: Icon(Icons.videocam_outlined)),
                ButtonSegment(value: MediaType.AUDIO, label: Text('Voice'), icon: Icon(Icons.mic_outlined)),
              ],
              selected: {_selectedMediaType},
              onSelectionChanged: (Set<MediaType> newSelection) {
                setState(() => _selectedMediaType = newSelection.first);
              },
            ),
            const SizedBox(height: 20),
            
            OutlinedButton.icon(
              onPressed: _isProcessing ? null : _captureMedia,
              icon: const Icon(Icons.add_a_photo_outlined),
              label: Text('Capture ${_formatEnumValue(_selectedMediaType.name)}'),
            ),

            if (_capturedMedia != null) ...[
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _selectedMediaType == MediaType.IMAGE
                    ? Image.file(_capturedMedia!, height: 200, width: double.infinity, fit: BoxFit.cover)
                    : Container(
                        height: 200,
                        color: colorScheme.surfaceContainer,
                        child: Center(
                          child: Icon(
                            _selectedMediaType == MediaType.VIDEO ? Icons.play_circle : Icons.audiotrack,
                            color: colorScheme.onSurfaceVariant,
                            size: 64,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              if (_gpsLat != null && _gpsLng != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.secondary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.gps_fixed, size: 18, color: colorScheme.secondary),
                      const SizedBox(width: 8),
                      Text(
                        'GPS Metadata: ${_gpsLat!.toStringAsFixed(5)}, ${_gpsLng!.toStringAsFixed(5)}',
                        style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurface),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ],
            
            const SizedBox(height: 40),
            FilledButton(
              onPressed: _isProcessing ? null : _saveActivity,
              child: _isProcessing
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save_outlined, size: 22),
                        SizedBox(width: 8),
                        Text('Save Activity Record'),
                      ],
                    ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Row(
      children: [
        Icon(icon, size: 22, color: colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  final String label;
  final String value;
  const _TimeRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          '$label: ',
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

class _SafetyIndicator extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SafetyIndicator({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
