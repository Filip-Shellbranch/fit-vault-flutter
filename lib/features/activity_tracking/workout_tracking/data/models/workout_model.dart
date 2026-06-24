import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/models/exercise_model.dart';
import 'package:isar_community/isar.dart';

part 'workout_model.g.dart';

enum WorkoutState { active, completed }

@collection
@Name("Workout")
class WorkoutModel {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  WorkoutState currentState;

  @Index()
  final DateTime startTime;
  DateTime? endTime;

  final exercises = IsarLinks<ExerciseModel>();

  WorkoutModel(
    this.startTime,
    this.endTime, {
    this.currentState = WorkoutState.completed,
  });

  factory WorkoutModel.fromWorkout(Workout workout) {
    WorkoutModel newWorkout = WorkoutModel(
      workout.startTime,
      workout.endTime,
      currentState: workout.currentState,
    );
    newWorkout.id = workout.id ?? Isar.autoIncrement;
    return newWorkout;
  }
}
