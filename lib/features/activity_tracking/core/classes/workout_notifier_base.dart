import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise.dart';

abstract class WorkoutNotifierBase {
  void updateExercise(int index, Exercise exercise);
  void addExercise(Exercise newExercise);
  void deleteExercise(int exerciseIndex);
}
