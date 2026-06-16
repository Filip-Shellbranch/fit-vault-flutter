import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/workout_notifier_base.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_workout_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentWorkout extends _$CurrentWorkout implements WorkoutNotifierBase {
  @override
  Workout build() {
    return Workout(DateTime.now());
  }

  void startWorkout({Workout? workout}) {
    workout ??= Workout(DateTime.now());
    state = workout;
  }

  @override
  void addExercise(Exercise newExercise) {
    final newState = state.copy();
    newState.addExercises([newExercise]);
    state = newState;
  }

  @override
  void updateExercise(int exerciseIndex, Exercise newExercise) {
    final newState = state.copy();
    newState.exercises.removeAt(exerciseIndex);
    newState.exercises.insert(exerciseIndex, newExercise);
    state = newState;
  }
}
