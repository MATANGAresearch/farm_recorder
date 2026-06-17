import 'package:isar/isar.dart';

part 'cached_chemical.g.dart';

@collection
class CachedChemical {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String gtin;

  late String name;
  String? variety;
  late String type;
  String? epaRegistrationNumber;
  String? activeIngredients;
  int? reiHours;
  int? phiDays;
  bool isLocalOnly = false;
  String? adminNotes;
}
