import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/saved_exercise_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/workout_model.dart';
import 'package:isar_community/isar.dart';

part 'exercise_model.g.dart';

@collection
@Name("Exercise")
class ExerciseModel {
  Id id = Isar.autoIncrement;

  final exerciseType = IsarLink<SavedExerciseModel>();

  @Backlink(to: 'exercises')
  final workout = IsarLink<WorkoutModel>();

  List<ExerciseSetModel> sets = [];

  ExerciseModel();

  factory ExerciseModel.fromExercise(Exercise exercise) {
    final newModel = ExerciseModel();
    newModel.id = exercise.id ?? Isar.autoIncrement;
    for (ExerciseSet set in exercise.sets) {
      final newSet = ExerciseSetModel.fromSet(set);
      newModel.sets.add(newSet);
    }
    return newModel;
  }

  Future<void> setExerciseType(ExerciseType type) async {
    exerciseType.value = SavedExerciseModel.fromExerciseType(type);
  }
}

@embedded
class ExerciseSetModel {
  double? weight;
  int? reps;

  ExerciseSetModel({this.weight, this.reps});

  factory ExerciseSetModel.fromSet(ExerciseSet set) {
    return ExerciseSetModel(weight: set.weight, reps: set.reps);
  }
}
