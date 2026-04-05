import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';

class Exercise {
  int? id;

  ExerciseType? exerciseType;
  final List<ExerciseSet> _sets = [];
  List<ExerciseSet> get sets => _sets;

  String get name =>
      exerciseType == null ? "Unknown" : exerciseType!.exerciseName;

  Exercise({this.exerciseType});

  factory Exercise.fromModel(ExerciseModel model) {
    Exercise newExercise = Exercise();
    newExercise.id = model.id;

    for (ExerciseSetModel setModel in model.sets) {
      if (setModel.reps == null || setModel.weight == null) {
        continue;
      }
      newExercise.addSet(setModel.weight!, setModel.reps!);
    }

    return newExercise;
  }

  void addSet(double weight, int reps) {
    final newSet = ExerciseSet(weight, reps);
    _sets.add(newSet);
  }

  void updateSetAt(int index, double weight, int reps) {
    final oldSet = _sets.elementAt(index);
    oldSet.weight = weight;
    oldSet.reps = reps;
  }

  void removeSetAt(int index) {
    _sets.removeAt(index);
  }

  String formatSetsAndReps() {
    if (sets.isEmpty) {
      return "No sets registered";
    }
    if (isNumRepsConstant()) {
      return "${sets.length}x${sets.first.reps}";
    }
    String result = "";
    for (var set in sets) {
      result += set.reps.toString();
      if (set != sets.last) {
        result += "/";
      }
    }
    return result;
  }

  bool isNumRepsConstant() {
    if (sets.isEmpty) {
      return true;
    }
    int? prevNumReps;
    for (final set in sets) {
      if (prevNumReps != null && prevNumReps != set.reps) {
        return false;
      }
      prevNumReps = set.reps;
    }
    return true;
  }
}

class ExerciseSet {
  double weight;
  int reps;

  ExerciseSet(this.weight, this.reps);

  ExerciseSet copy() {
    return ExerciseSet(weight, reps);
  }
}
