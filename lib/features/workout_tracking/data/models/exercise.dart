import 'package:fit_vault_flutter/features/workout_tracking/data/models/workout.dart';
import 'package:isar_community/isar.dart';

part 'exercise.g.dart';

@collection
class Exercise {
  Id id = Isar.autoIncrement;

  @Index()
  String name;

  final workout = IsarLink<Workout>();
  List<ExerciseSet> sets = [];

  Exercise(this.name);
}

@embedded
class ExerciseSet {
  double? weight;
  int? reps;

  ExerciseSet({this.weight, this.reps});
}
