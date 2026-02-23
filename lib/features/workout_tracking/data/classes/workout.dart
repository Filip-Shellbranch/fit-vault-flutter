import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/workout_model.dart';

class Workout {
  int? id;

  DateTime startTime;
  DateTime? endTime;

  List<Exercise> exercises = [];

  Workout(this.startTime);

  factory Workout.fromModel(WorkoutModel model) {
    /*
    Creates a new Workout from the WorkoutModel, since the exercise links are most likely not yet loaded
    the Workout does not have Exercises and must be loaded separately where appropriate in WorkoutRepository.
    */
    final newWorkout = Workout(model.startTime);
    newWorkout.id = model.id;
    newWorkout.endTime = model.endTime;

    return newWorkout;
  }
}
