import 'package:fit_vault_flutter/features/workout_tracking/data/classes/default_exercises.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/saved_exercise_model.dart';
import 'package:isar_community/isar.dart';

class SavedExerciseRepository {
  Isar db;
  SavedExerciseRepository(this.db);

  Future<bool> saveNewExerciseType(String exerciseName) async {
    bool success = await db.writeTxn(() async {
      bool exists = await db.savedExerciseModels
          .filter()
          .nameMatches(exerciseName)
          .isNotEmpty();
      if (!exists) {
        final newExercise = SavedExerciseModel(exerciseName);
        await db.savedExerciseModels.put(newExercise);
        return true;
      } else {
        return false;
      }
    });
    return success;
  }

  Future<List<String>> getSavedExercises() async {
    List<String> exerciseList = [];
    List<SavedExerciseModel> savedExercises = await db.savedExerciseModels
        .where()
        .findAll();
    for (var savedExercise in savedExercises) {
      exerciseList.add(savedExercise.name);
    }
    return exerciseList;
  }

  Future<List<String>> getExerciseTypes() async {
    List<String> savedExercises = await getSavedExercises();
    savedExercises.addAll(defaultExerciseList);
    final exerciseTypes = savedExercises.toSet().toList();
    return exerciseTypes;
  }
}
