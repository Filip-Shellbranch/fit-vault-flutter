import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';

class Exercise {
  int? id;

  String name;
  List<ExerciseSet> sets = [];

  Exercise(this.name);

  factory Exercise.fromModel(ExerciseModel model) {
    Exercise newExercise = Exercise(model.name);
    newExercise.id = model.id;

    for (ExerciseSetModel setModel in model.sets) {
      // TODO: Error handling on null values.
      newExercise.addSet(setModel.weight!, setModel.reps!);
    }

    return newExercise;
  }

  void addSet(double weight, int reps) {
    final newSet = ExerciseSet(weight, reps);
    sets.add(newSet);
  }
}

class ExerciseSet {
  double weight;
  int reps;

  ExerciseSet(this.weight, this.reps);
}
