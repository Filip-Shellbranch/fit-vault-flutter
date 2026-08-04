import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/models/exercise_model.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/models/exercise_type_model.dart';
import 'package:isar_community/isar.dart';

class ExerciseRepository {
  Isar db;
  ExerciseRepository(this.db);

  Future<Exercise> loadExerciseFromModel(ExerciseModel model) async {
    Exercise exercise = Exercise.fromModel(model);

    await model.exerciseType.load();
    final typeModel = model.exerciseType.value;
    if (typeModel != null) {
      ExerciseType type = ExerciseType.fromModel(typeModel);
      exercise.exerciseType = type;
    }

    return exercise;
  }

  Future<List<ExerciseModel>> getExerciseHistory(String exerciseName) async {
    final allExercises = await db.exerciseModels
        .filter()
        .exerciseType((q) => q.nameEqualTo(exerciseName))
        .sortByDate()
        .findAll();
    return allExercises;
  }

  Future<double?> getLastWeightForExercise(String exerciseName) async {
    final history = await getExerciseHistory(exerciseName);
    if (history.isEmpty || history.last.sets.isEmpty) {
      return null;
    }
    return history.last.sets.last.weight;
  }
}
