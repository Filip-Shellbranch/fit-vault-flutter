import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/workout_model.dart';
import 'package:isar_community/isar.dart';

part 'exercise_model.g.dart';

@collection
@Name("Exercise")
class ExerciseModel {
  Id id = Isar.autoIncrement;

  @Index()
  String name;

  @Backlink(to: 'exercises')
  final workout = IsarLink<WorkoutModel>();

  List<ExerciseSetModel> sets = [];

  ExerciseModel(this.name);

  factory ExerciseModel.fromExercise(Exercise exercise) {
    final newModel = ExerciseModel(exercise.name);
    newModel.id = exercise.id ?? Isar.autoIncrement;
    for (ExerciseSet set in exercise.sets) {
      final newSet = ExerciseSetModel.fromSet(set);
      newModel.sets.add(newSet);
    }
    return newModel;
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
