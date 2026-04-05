import 'package:fit_vault_flutter/features/workout_tracking/data/classes/default_exercises.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/saved_exercise_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/workout_repository.dart';
import 'package:isar_community/isar.dart';

String formatExerciseName(String originalName) {
  return originalName;
}

class SavedExerciseRepository {
  Isar db;
  SavedExerciseRepository(this.db);

  Future<void> ensurePopulated({List<ExerciseType>? defaultTypes}) async {
    defaultTypes ??= defaultExerciseList;

    final count = await db.savedExerciseModels.count();
    if (count == 0) {
      await populateWithDefaults(defaultTypes);
    }
  }

  Future<void> populateWithDefaults(List<ExerciseType> defaultTypes) async {
    await db.writeTxn(() async {
      final models = defaultTypes
          .map(
            (final defaultType) =>
                SavedExerciseModel.fromExerciseType(defaultType),
          )
          .toList();
      db.savedExerciseModels.putAll(models);
    });
  }

  Future<bool> saveNewExerciseType(ExerciseType newType) async {
    String exerciseName = formatExerciseName(newType.exerciseName);
    bool success = await db.writeTxn(() async {
      bool exists = await db.savedExerciseModels
          .filter()
          .nameMatches(exerciseName)
          .isNotEmpty();
      if (!exists) {
        final newExercise = SavedExerciseModel(
          exerciseName,
          newType.isBodyWeight,
        );
        await db.savedExerciseModels.put(newExercise);
        return true;
      } else {
        return false;
      }
    });
    return success;
  }

  Future<List<ExerciseType>> getSavedExercises() async {
    List<ExerciseType> exerciseList = [];
    List<SavedExerciseModel> savedExercises = await db.savedExerciseModels
        .where()
        .findAll();
    for (var savedExercise in savedExercises) {
      final newExercise = ExerciseType(savedExercise.name, isCustom: true);
      exerciseList.add(newExercise);
    }
    return exerciseList;
  }

  Future<List<ExerciseType>> getExerciseTypes() async {
    List<ExerciseType> savedExercises = await getSavedExercises();
    for (ExerciseType defaultExercise in defaultExerciseList) {
      if (!savedExercises.any(
        (exerciseType) =>
            exerciseType.exerciseName == defaultExercise.exerciseName,
      )) {
        savedExercises.add(defaultExercise);
      }
    }
    return savedExercises;
  }

  Future<bool> tryDeleteExerciseType(String exerciseName) async {
    exerciseName = formatExerciseName(exerciseName);
    bool exists = await db.savedExerciseModels
        .filter()
        .nameMatches(exerciseName)
        .isNotEmpty();
    if (!exists) {
      return true;
    }

    int numberOfOccurances = await WorkoutRepository(
      db,
    ).countWorkoutsWithExercise(exerciseName);
    if (numberOfOccurances == 0) {
      await db.writeTxn(() async {
        await db.savedExerciseModels
            .where()
            .nameEqualTo(exerciseName)
            .deleteAll();
      });
      return true;
    }
    return false;
  }

  Future<Id?> findExerciseTypeIdFromName(String exerciseName) async {
    SavedExerciseModel? foundModel = await db.savedExerciseModels.getByName(
      exerciseName,
    );
    if (foundModel != null) {
      return foundModel.id;
    } else {
      return null;
    }
  }
}
