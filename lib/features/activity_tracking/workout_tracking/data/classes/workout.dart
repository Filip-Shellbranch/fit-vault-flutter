import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/models/workout_model.dart';

class Workout {
  int? id;

  DateTime startTime;
  DateTime? endTime;

  List<Exercise> exercises = [];

  WorkoutState currentState;

  Workout(this.startTime, {this.currentState = WorkoutState.completed});

  factory Workout.fromModel(WorkoutModel model) {
    /*
    Creates a new Workout from the WorkoutModel, since the exercise links are most likely not yet loaded
    the Workout does not have Exercises and must be loaded separately where appropriate in WorkoutRepository.
    */
    final newWorkout = Workout(
      model.startTime,
      currentState: model.currentState,
    );
    newWorkout.id = model.id;
    newWorkout.endTime = model.endTime;

    return newWorkout;
  }

  void addExercises(List<Exercise> newExercises) {
    exercises.addAll(newExercises);
  }

  void removeExercise(int exerciseIndex) {
    if (exercises.length >= exerciseIndex + 1) {
      exercises.removeAt(exerciseIndex);
    }
  }

  Duration calculateDuration() {
    if (endTime == null) {
      return DateTime.now().difference(startTime);
    } else {
      return endTime!.difference(startTime);
    }
  }

  String formatDuration() {
    Duration duration = calculateDuration();
    int hours = (duration.inMinutes / 60).floor();
    int minutes = (duration.inMinutes - 60 * hours);
    if (hours == 0) {
      if (minutes == 0) {
        return "<1 min";
      }
      return "$minutes min";
    } else {
      return "$hours h $minutes min";
    }
  }

  Workout copy() {
    Workout newWorkout = Workout(startTime);
    newWorkout.endTime = endTime;
    newWorkout.exercises = exercises
        .map((exercise) => exercise.copy())
        .toList();
    newWorkout.id = id;
    return newWorkout;
  }
}
