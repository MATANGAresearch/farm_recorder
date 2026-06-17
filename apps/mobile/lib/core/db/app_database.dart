import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'offline_activity_log.dart';
import 'cached_chemical.dart';
import 'cached_input_batch.dart';

class AppDatabase {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [OfflineActivityLogSchema, CachedChemicalSchema, CachedInputBatchSchema],
      directory: dir.path,
    );
  }
}
