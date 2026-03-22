import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_workout_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentWorkout extends _$CurrentWorkout {
  @override
  Workout build() {
    // You could also fetch a draft from a database here
    return Workout(DateTime.now());
  }

  void startWorkout({Workout? workout}) {
    workout ??= Workout(DateTime.now());
    Exercise e1 = Exercise("hej");
    e1.addSet(50, 10);
    e1.addSet(40, 10);
    workout.addExercises([e1, Exercise("tho")]); // TODO: Remove
    state = workout;
  }

  void addExercise(Exercise newExercise) {
    final newState = state.copy();
    newState.addExercises([newExercise]);
    state = newState;
  }

  void updateExercise(int exerciseIndex, Exercise newExercise) {
    final newState = state.copy();
    newState.exercises.removeAt(exerciseIndex);
    newState.exercises.insert(exerciseIndex, newExercise);
    state = newState;
  }
}
