import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test create model from Exercise without Sets", () {
    String exerciseName = "Benchpress";
    Exercise exercise = Exercise(exerciseName);

    ExerciseModel model = ExerciseModel.fromExercise(exercise);
    expect(model.name, exerciseName);
    expect(model.id, isNotNull);
    expect(model.sets.isEmpty, true);
  });
}
