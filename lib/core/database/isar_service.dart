import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

/// Creates an Isar connection to be used by the repositories.
class IsarService {
  late final Isar db;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    List<CollectionSchema> schemas = [];
    db = await Isar.open(schemas, directory: dir.path, inspector: true);
  }
}
