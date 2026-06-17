import 'package:isar/isar.dart';

part 'cached_input_batch.g.dart';

@collection
class CachedInputBatch {
  Id id = Isar.autoIncrement;

  @Index()
  late String gtin;

  @Index()
  late String lotNumber;

  late String productId;
  late double remainingQuantity;
  late String expirationDate;
  late String unit;
}
