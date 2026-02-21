import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise.dart';
import 'package:isar_community/isar.dart';

part 'workout.g.dart';

@collection
class Workout {
  Id id = Isar.autoIncrement;

  @Index()
  final DateTime startTime;
  DateTime? endTime;

  @Backlink(to: "workout")
  final exercises = IsarLinks<Exercise>();

  Workout(this.startTime);
}
