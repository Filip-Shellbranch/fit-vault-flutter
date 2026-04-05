import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test create Exercise from Exercise Model without sets.", () {
    ExerciseModel model = ExerciseModel();
    model.id = 99;

    Exercise exercise = Exercise.fromModel(model);
    expect(exercise.id, model.id);
    expect(exercise.sets.isEmpty, true);
  });

  test("test create Exercise from Exercise Model with multiple sets.", () {
    ExerciseModel model = ExerciseModel();
    model.id = 49;
    int numSets = 3;
    for (var i = 0; i < numSets; i++) {
      model.sets.add(ExerciseSetModel(weight: i.toDouble(), reps: i));
    }

    Exercise exercise = Exercise.fromModel(model);
    expect(exercise.id, model.id);
    expect(exercise.sets.length, numSets);
    for (var i = 0; i < numSets; i++) {
      expect(model.sets[i].weight, exercise.sets[i].weight);
      expect(model.sets[i].reps, exercise.sets[i].reps);
    }
  });

  group("test isNumRepsConstant", () {
    test("test on exercise without sets should be true", () {
      final e = Exercise();
      expect(e.isNumRepsConstant(), true);
    });

    test("test on exercise with 1 set should be true", () {
      final e = Exercise();
      e.addSet(10, 5);
      expect(e.isNumRepsConstant(), true);
    });

    test(
      "test on exercise with 2 set with same number of reps should be true",
      () {
        final e = Exercise();
        e.addSet(10, 5);
        e.addSet(30, 5);
        expect(e.isNumRepsConstant(), true);
      },
    );

    test(
      "test on exercise with 2 set with different number of reps should be false",
      () {
        final e = Exercise();
        e.addSet(10, 5);
        e.addSet(30, 2);
        expect(e.isNumRepsConstant(), false);
      },
    );
  });

  group("test formatting of sets and reps", () {
    test("test format Exercise without sets", () {
      final e = Exercise();
      expect(e.sets.isEmpty, true);
      expect(e.formatSetsAndReps(), "No sets registered");
    });

    test("test format Exercise with 1 set", () {
      final e = Exercise();
      e.addSet(10, 4);
      expect(e.sets.length, 1);

      String formatted = e.formatSetsAndReps();
      expect(formatted, "1x4");

      final e2 = Exercise();
      e2.addSet(10, 9);
      expect(e2.sets.length, 1);

      String formatted2 = e2.formatSetsAndReps();
      expect(formatted2, "1x9");
    });

    test("test format Exercise with several sets with equal reps", () {
      final e = Exercise();
      e.addSet(10, 4);
      e.addSet(20, 4);
      expect(e.sets.length, 2);

      String formatted = e.formatSetsAndReps();
      expect(formatted, "2x4");

      final e2 = Exercise();
      e2.addSet(10, 9);
      e2.addSet(500, 9);
      e2.addSet(102, 9);
      expect(e2.sets.length, 3);

      String formatted2 = e2.formatSetsAndReps();
      expect(formatted2, "3x9");
    });

    test("test format Exercise with several sets with non-equal reps", () {
      final e = Exercise();
      e.addSet(10, 5);
      e.addSet(20, 4);
      expect(e.sets.length, 2);

      String formatted = e.formatSetsAndReps();
      expect(formatted, "5/4");

      final e2 = Exercise();
      e2.addSet(10, 2);
      e2.addSet(500, 7);
      e2.addSet(102, 4);
      expect(e2.sets.length, 3);

      String formatted2 = e2.formatSetsAndReps();
      expect(formatted2, "2/7/4");
    });
  });
}
