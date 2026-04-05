import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/saved_exercise_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/workout_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/saved_exercise_repository.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

/// Creates an Isar connection to be used by the repositories.
class IsarService {
  late final Isar db;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    List<CollectionSchema> schemas = [
      WorkoutModelSchema,
      ExerciseModelSchema,
      SavedExerciseModelSchema,
    ];
    db = await Isar.open(schemas, directory: dir.path, inspector: true);

    await SavedExerciseRepository(db).ensurePopulated();
  }
}
