import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
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
}
