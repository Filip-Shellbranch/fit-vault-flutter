import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test create Exercise from Exercise Model without sets.", () {
    ExerciseModel model = ExerciseModel("Benchpress");
    model.id = 99;

    Exercise exercise = Exercise.fromModel(model);
    expect(exercise.id, model.id);
    expect(exercise.name, model.name);
    expect(exercise.sets.isEmpty, true);
  });

  test("test create Exercise from Exercise Model with multiple sets.", () {
    ExerciseModel model = ExerciseModel("Benchpress");
    model.id = 49;
    int numSets = 3;
    for (var i = 0; i < numSets; i++) {
      model.sets.add(ExerciseSetModel(weight: i.toDouble(), reps: i));
    }

    Exercise exercise = Exercise.fromModel(model);
    expect(exercise.name, model.name);
    expect(exercise.id, model.id);
    expect(exercise.sets.length, numSets);
    for (var i = 0; i < numSets; i++) {
      expect(model.sets[i].weight, exercise.sets[i].weight);
      expect(model.sets[i].reps, exercise.sets[i].reps);
    }
  });
}
