import 'package:isar/isar.dart';

part 'offline_activity_log.g.dart';

@collection
class OfflineActivityLog {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  late String timestamp;
  late String userId;
  late String locationId;
  String? productId;
  String? taskId;
  late String type; // PLANTING, SPRAYING, HARVESTING, CLEANING, INSPECTION, DIRECT_SALE
  String? notes;
  double? gpsLat;
  double? gpsLng;
  
  // New fields for Harvest/Sale
  String? startTime;
  String? endTime;
  String? batchId;
  int? quantity;
  double? unitPrice;
  double? totalPrice;
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  
  // New fields for chemical spraying
  String? chemicalLotNumber;
  String? chemicalExpirationDate;
  String? applicationRate;
  double? totalQuantityApplied;
  double? weatherWindSpeed;
  String? weatherWindDirection;
  double? weatherTemperature;
  String? applicatorLicense;
  bool? isManualInput;
  String? manualInputComments;
  String? verificationStatus;
  String? verifiedBy;
  String? verifiedAt;
  String? reiEndTime;

  bool isSynced = false;
  DateTime createdAt = DateTime.now();
}
