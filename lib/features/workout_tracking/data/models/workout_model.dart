import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
import 'package:isar_community/isar.dart';

part 'workout_model.g.dart';

@collection
@Name("Workout")
class WorkoutModel {
  Id id = Isar.autoIncrement;

  @Index()
  final DateTime startTime;
  DateTime? endTime;

  final exercises = IsarLinks<ExerciseModel>();

  WorkoutModel(this.startTime, this.endTime);

  factory WorkoutModel.fromWorkout(Workout workout) {
    WorkoutModel newWorkout = WorkoutModel(workout.startTime, workout.endTime);
    newWorkout.id = workout.id ?? Isar.autoIncrement;
    return newWorkout;
  }
}
