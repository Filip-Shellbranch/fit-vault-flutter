import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test create model from Exercise without sets", () {
    String exerciseName = "Benchpress";
    Exercise exercise = Exercise(exerciseName);

    ExerciseModel model = ExerciseModel.fromExercise(exercise);
    expect(model.name, exerciseName);
    expect(model.id, isNotNull);
    expect(model.sets.isEmpty, true);
  });

  test("test create model from Exercise with sets", () {
    String exerciseName = "Benchpress";
    Exercise exercise = Exercise(exerciseName);
    int numSets = 3;
    for (var i = 0; i < numSets; i++) {
      exercise.addSet(i.toDouble(), i);
    }

    ExerciseModel model = ExerciseModel.fromExercise(exercise);
    expect(model.name, exerciseName);
    expect(model.id, isNotNull);
    expect(model.sets.isEmpty, false);
    expect(model.sets.length, numSets);
    for (var i = 0; i < numSets; i++) {
      expect(model.sets[i].weight, i.toDouble());
      expect(model.sets[i].reps, i);
    }
  });

  test("test create model from Exercise with id", () {
    String exerciseName = "Benchpress";
    int id = 6;
    Exercise exercise = Exercise(exerciseName);
    exercise.id = id;

    ExerciseModel model = ExerciseModel.fromExercise(exercise);
    expect(model.name, exerciseName);
    expect(model.id, id);
    expect(model.sets.isEmpty, true);
  });
}
