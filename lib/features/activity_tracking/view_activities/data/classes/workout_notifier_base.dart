import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise.dart';

//TODO: Move this file to a more suitable location.

abstract class WorkoutNotifierBase {
  void updateExercise(int index, Exercise exercise);
}
