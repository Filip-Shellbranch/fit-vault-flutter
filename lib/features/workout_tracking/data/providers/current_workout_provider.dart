import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_workout_provider.g.dart';

@riverpod
class CurrentWorkout extends _$CurrentWorkout {
  @override
  Workout build() {
    // You could also fetch a draft from a database here
    return Workout(DateTime.now());
  }

  void startWorkout() {
    state = Workout(DateTime.now());
  }
}
