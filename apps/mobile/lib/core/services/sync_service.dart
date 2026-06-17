import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import '../db/app_database.dart';
import '../db/offline_activity_log.dart';
import '../db/cached_chemical.dart';
import '../db/cached_input_batch.dart';
import 'api_service.dart';

class SyncService {
  final ApiService _apiService;

  SyncService({required ApiService apiService}) : _apiService = apiService;

  Future<void> syncPendingLogs() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return;

    final pendingLogs = await AppDatabase.isar.offlineActivityLogs
        .filter()
        .isSyncedEqualTo(false)
        .findAll();

    for (final log in pendingLogs) {
      try {
        final payload = {
          'id': log.uuid,
          'timestamp': log.timestamp,
          'userId': log.userId,
          'locationId': log.locationId,
          'productId': log.productId,
          'taskId': log.taskId,
          'type': log.type,
          'notes': log.notes,
          'gpsLat': log.gpsLat,
          'gpsLng': log.gpsLng,
          'startTime': log.startTime,
          'endTime': log.endTime,
          'batchId': log.batchId,
          'quantity': log.quantity,
          'unitPrice': log.unitPrice,
          'totalPrice': log.totalPrice,
          'customerName': log.customerName,
          'customerPhone': log.customerPhone,
          'customerEmail': log.customerEmail,
          'chemicalLotNumber': log.chemicalLotNumber,
          'chemicalExpirationDate': log.chemicalExpirationDate,
          'applicationRate': log.applicationRate,
          'totalQuantityApplied': log.totalQuantityApplied,
          'weatherWindSpeed': log.weatherWindSpeed,
          'weatherWindDirection': log.weatherWindDirection,
          'weatherTemperature': log.weatherTemperature,
          'applicatorLicense': log.applicatorLicense,
          'isManualInput': log.isManualInput,
          'manualInputComments': log.manualInputComments,
          'verificationStatus': log.verificationStatus,
          'verifiedBy': log.verifiedBy,
          'verifiedAt': log.verifiedAt,
          'reiEndTime': log.reiEndTime,
        };

        await _apiService.createActivityLog(payload);
        
        await AppDatabase.isar.writeTxn(() async {
          log.isSynced = true;
          await AppDatabase.isar.offlineActivityLogs.put(log);
        });
      } catch (e) {
        print('Sync failed for log ${log.uuid}: $e');
      }
    }
  }

  Future<String> queueActivityLog({
    required String userId,
    required String locationId,
    required String type,
    String? productId,
    String? taskId,
    String? notes,
    double? gpsLat,
    double? gpsLng,
    String? startTime,
    String? endTime,
    String? batchId,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    String? customerName,
    String? customerPhone,
    String? customerEmail,
    String? chemicalLotNumber,
    String? chemicalExpirationDate,
    String? applicationRate,
    double? totalQuantityApplied,
    double? weatherWindSpeed,
    String? weatherWindDirection,
    double? weatherTemperature,
    String? applicatorLicense,
    bool? isManualInput,
    String? manualInputComments,
    String? verificationStatus,
    String? verifiedBy,
    String? verifiedAt,
    String? reiEndTime,
  }) async {
    final log = OfflineActivityLog()
      ..uuid = const Uuid().v4()
      ..timestamp = DateTime.now().toIso8601String()
      ..userId = userId
      ..locationId = locationId
      ..type = type
      ..productId = productId
      ..taskId = taskId
      ..notes = notes
      ..gpsLat = gpsLat
      ..gpsLng = gpsLng
      ..startTime = startTime
      ..endTime = endTime
      ..batchId = batchId
      ..quantity = quantity
      ..unitPrice = unitPrice
      ..totalPrice = totalPrice
      ..customerName = customerName
      ..customerPhone = customerPhone
      ..customerEmail = customerEmail
      ..chemicalLotNumber = chemicalLotNumber
      ..chemicalExpirationDate = chemicalExpirationDate
      ..applicationRate = applicationRate
      ..totalQuantityApplied = totalQuantityApplied
      ..weatherWindSpeed = weatherWindSpeed
      ..weatherWindDirection = weatherWindDirection
      ..weatherTemperature = weatherTemperature
      ..applicatorLicense = applicatorLicense
      ..isManualInput = isManualInput
      ..manualInputComments = manualInputComments
      ..verificationStatus = verificationStatus
      ..verifiedBy = verifiedBy
      ..verifiedAt = verifiedAt
      ..reiEndTime = reiEndTime
      ..isSynced = false;

    await AppDatabase.isar.writeTxn(() async {
      await AppDatabase.isar.offlineActivityLogs.put(log);
    });

    await syncPendingLogs();

    return log.uuid;
  }

  Future<void> queueMedia({
    required String activityLogUuid,
    required String mediaUrl,
    required String mediaType,
    double? capturedGpsLat,
    double? capturedGpsLng,
  }) async {
    try {
      final payload = {
        'activityLogId': activityLogUuid,
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
        'capturedGpsLat': capturedGpsLat,
        'capturedGpsLng': capturedGpsLng,
        'timestamp': DateTime.now().toIso8601String(),
      };

      await _apiService.createMedia(payload);
      print('Media queued/synced successfully');
    } catch (e) {
      print('Failed to sync media: $e');
    }
  }

  Future<void> fetchAndCacheInventory() async {
    try {
      // 1. Fetch products from server and update CachedChemical collection
      final products = await _apiService.getProducts();
      await AppDatabase.isar.writeTxn(() async {
        await AppDatabase.isar.cachedChemicals.clear();
        for (final prod in products) {
          final type = prod['type'] as String? ?? 'CROP';
          if (['PESTICIDE', 'HERBICIDE', 'FERTILIZER', 'CHEMICAL'].contains(type)) {
            final chemical = CachedChemical()
              ..gtin = prod['gtin'] as String? ?? ''
              ..name = prod['name'] as String? ?? ''
              ..variety = prod['variety'] as String?
              ..type = type
              ..epaRegistrationNumber = prod['epaRegistrationNumber'] as String?
              ..activeIngredients = prod['activeIngredients'] as String?
              ..reiHours = prod['reiHours'] as int?
              ..phiDays = prod['phiDays'] as int?
              ..isLocalOnly = prod['isLocalOnly'] as bool? ?? false;
            await AppDatabase.isar.cachedChemicals.put(chemical);
          }
        }
      });

      // 2. Fetch active input batches and update CachedInputBatch collection
      final batches = await _apiService.getInputBatches();
      await AppDatabase.isar.writeTxn(() async {
        await AppDatabase.isar.cachedInputBatchs.clear();
        for (final b in batches) {
          final batch = CachedInputBatch()
            ..gtin = b['gtin'] as String? ?? ''
            ..lotNumber = b['lotNumber'] as String? ?? ''
            ..productId = b['productId'] as String? ?? ''
            ..remainingQuantity = (b['remainingQuantity'] as num).toDouble()
            ..expirationDate = b['expirationDate'] as String? ?? ''
            ..unit = b['unit'] as String? ?? '';
          await AppDatabase.isar.cachedInputBatchs.put(batch);
        }
      });
      print('Inventory cache synchronized successfully.');
    } catch (e) {
      print('Failed to cache inventory: $e');
    }
  }
}
