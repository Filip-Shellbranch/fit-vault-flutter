import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise_type.dart';

class ExerciseTypeResult {
  final int count;
  final ExerciseType type;

  ExerciseTypeResult(this.type, {this.count = 0});
}
