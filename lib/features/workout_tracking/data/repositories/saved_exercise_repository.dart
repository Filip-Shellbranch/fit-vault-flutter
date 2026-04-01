import 'package:fit_vault_flutter/features/workout_tracking/data/classes/default_exercises.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/saved_exercise_model.dart';
import 'package:isar_community/isar.dart';

String formatExerciseName(String originalName) {
  return originalName;
}

class SavedExerciseRepository {
  Isar db;
  SavedExerciseRepository(this.db);

  Future<bool> saveNewExerciseType(String exerciseName) async {
    exerciseName = formatExerciseName(exerciseName);
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

    //WorkoutRepository workoutRepo = WorkoutRepository(db).
    return false;
  }
}
