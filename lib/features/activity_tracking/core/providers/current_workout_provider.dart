import 'package:fit_vault_flutter/features/activity_tracking/core/classes/workout_notifier_base.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/models/workout_model.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/providers/workout_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_workout_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentWorkout extends _$CurrentWorkout implements WorkoutNotifierBase {
  @override
  Future<Workout?> build() async {
    return ref.read(workoutRepositoryProvider).loadCurrentWorkout();
  }

  Future<void> startWorkout({Workout? workout}) async {
    workout ??= Workout(DateTime.now(), currentState: WorkoutState.active);

    final newSavedWorkout = await ref
        .read(workoutRepositoryProvider)
        .saveWorkout(workout, isCompleted: false);
    state = AsyncValue.data(newSavedWorkout);
  }

  @override
  void updateExercise(int exerciseIndex, Exercise newExercise) async {
    if (!state.hasValue) {
      return;
    }
    final workout = state.value!.copy();
    workout.exercises.removeAt(exerciseIndex);
    workout.exercises.insert(exerciseIndex, newExercise);
    final savedWorkout = await ref
        .read(workoutRepositoryProvider)
        .saveWorkout(workout, isCompleted: false);
    state = AsyncValue.data(savedWorkout);
  }

  @override
  void addExercise(Exercise newExercise) async {
    if (!state.hasValue) {
      return;
    }
    final workout = state.value!.copy();
    workout.addExercises([newExercise]);
    final savedWorkout = await ref
        .read(workoutRepositoryProvider)
        .saveWorkout(workout, isCompleted: false);
    state = AsyncValue.data(savedWorkout);
  }

  @override
  void deleteExercise(int exerciseIndex) async {
    if (!state.hasValue) {
      return;
    }
    final workout = state.value!.copy();
    workout.removeExercise(exerciseIndex);
    final savedWorkout = await ref
        .read(workoutRepositoryProvider)
        .saveWorkout(workout, isCompleted: false);
    state = AsyncValue.data(savedWorkout);
  }
}
