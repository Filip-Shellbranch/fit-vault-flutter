import 'dart:io';

import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/workout_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/workout_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';

void main() {
  late Isar isar;
  late WorkoutRepository workoutRepository;
  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([
      ExerciseModelSchema,
      WorkoutModelSchema,
    ], directory: Directory.systemTemp.path);
    workoutRepository = WorkoutRepository(isar);
  });

  tearDown(() async {
    await isar.close(deleteFromDisk: true);
  });

  group("Test adding new workouts", () {
    test("Test adding an empty workout to the database.", () async {
      DateTime time = DateTime(10, 5, 2);
      Workout workout = Workout(time);

      expect(await isar.workoutModels.count(), 0);
      await workoutRepository.saveWorkout(workout);
      expect(await isar.workoutModels.count(), 1);
    });

    test("Test saving a workout assigns workout ID to the workout.", () async {
      DateTime time = DateTime(10, 5, 2);
      Workout workout = Workout(time);
      Workout newWorkout = await workoutRepository.saveWorkout(workout);
      expect(newWorkout.id, isNotNull);
    });

    test("Test saving a workout with an exercise updates database.", () async {
      String exerciseName = "Benchpress";

      DateTime time = DateTime(15, 5, 2);
      Workout workout = Workout(time);
      Exercise exercise = Exercise(exerciseName);
      workout.exercises.add(exercise);

      expect(await isar.workoutModels.count(), 0);
      expect(await isar.exerciseModels.count(), 0);
      await workoutRepository.saveWorkout(workout);
      expect(await isar.workoutModels.count(), 1);
      expect(await isar.exerciseModels.count(), 1);
    });

    test(
      "Test saving a workout with an exercise assigns exercise ID:s.",
      () async {
        String exerciseName = "Benchpress";

        DateTime time = DateTime(15, 5, 2);
        Workout workout = Workout(time);
        Exercise exercise = Exercise(exerciseName);
        workout.exercises.add(exercise);

        Workout newWorkout = await workoutRepository.saveWorkout(workout);
        expect(newWorkout.id, isNotNull);
        expect(newWorkout.exercises.length, 1);
        for (Exercise exercise in newWorkout.exercises) {
          expect(exercise.id, isNotNull);
        }
      },
    );

    test(
      "Test saving a workout with multiple exercises updates database.",
      () async {
        String exerciseName = "Benchpress";
        String exerciseName2 = "Leg press";

        DateTime time = DateTime(15, 5, 2);
        Workout workout = Workout(time);
        Exercise exercise = Exercise(exerciseName);
        workout.exercises.add(exercise);
        Exercise exercise2 = Exercise(exerciseName2);
        workout.exercises.add(exercise2);

        expect(await isar.workoutModels.count(), 0);
        expect(await isar.exerciseModels.count(), 0);
        await workoutRepository.saveWorkout(workout);
        expect(await isar.workoutModels.count(), 1);
        expect(await isar.exerciseModels.count(), 2);
      },
    );

    test(
      "Test saving a workout with multiple exercises assigns exercise ID:s.",
      () async {
        String exerciseName = "Benchpress";
        String exerciseName2 = "Leg press";

        DateTime time = DateTime(15, 5, 2);
        Workout workout = Workout(time);
        Exercise exercise = Exercise(exerciseName);
        workout.exercises.add(exercise);
        Exercise exercise2 = Exercise(exerciseName2);
        workout.exercises.add(exercise2);

        Workout newWorkout = await workoutRepository.saveWorkout(workout);
        expect(newWorkout.id, isNotNull);
        expect(newWorkout.exercises.length, 2);
        for (Exercise exercise in newWorkout.exercises) {
          expect(exercise.id, isNotNull);
        }
      },
    );

    test("Test saving a workout with a specific ID.", () async {
      int id = 9;
      DateTime time = DateTime(15, 5, 2);
      Workout workout = Workout(time);
      workout.id = 9;

      Workout newWorkout = await workoutRepository.saveWorkout(workout);
      expect(newWorkout.id, id);
    });
  });

  group("Test overwriting workouts", () {
    test("Test overwriting a workout without exercises", () async {
      int id = 4;
      DateTime time = DateTime(10, 5, 2);
      Workout workout = Workout(time);
      workout.id = id;

      await workoutRepository.saveWorkout(workout);
      DateTime newTime = DateTime(1, 1, 1, 1);
      workout.startTime = newTime;
      Workout newWorkout = await workoutRepository.saveWorkout(workout);
      expect(newWorkout.startTime, newTime);
      expect(newWorkout.id, id);
    });

    test(
      "Test overwriting a workout with exercises removes orphan exercises",
      () async {
        int id = 99;

        Workout workout = Workout(DateTime(10, 5, 2));
        workout.id = id;

        workout.exercises.add(Exercise("Benchpress"));
        await workoutRepository.saveWorkout(workout);
        expect(await isar.workoutModels.count(), 1);
        expect(await isar.exerciseModels.count(), 1);

        Workout newWorkout = Workout(DateTime(1, 1, 1, 1));
        newWorkout.id = id;
        await workoutRepository.saveWorkout(newWorkout);
        expect(await isar.workoutModels.count(), 1);
        expect(await isar.exerciseModels.count(), 0);
      },
    );
  });

  group("Test getting workouts", () {
    test("Get all workouts when there are no workouts", () async {
      expect(await isar.workoutModels.count(), 0);
      List<Workout> allWorkouts = await workoutRepository.getAllWorkouts();
      expect(allWorkouts.isEmpty, true);
    });
    test("Get all workouts when there is only 1 workout", () async {
      DateTime date = DateTime(10, 5, 2);
      Workout workout = Workout(date);
      await workoutRepository.saveWorkout(workout);

      expect(await isar.workoutModels.count(), 1);
      List<Workout> allWorkouts = await workoutRepository.getAllWorkouts();
      expect(allWorkouts.length, 1);
    });
    test("Get all workouts when there are multiple workouts", () async {
      int numWorkouts = 4;
      expect(
        numWorkouts,
        greaterThan(1),
      ); // This test should be done with multiple workouts.
      for (var i = 0; i < numWorkouts; i++) {
        Workout workout = Workout(DateTime(i));
        await workoutRepository.saveWorkout(workout);
      }

      expect(await isar.workoutModels.count(), numWorkouts);
      List<Workout> allWorkouts = await workoutRepository.getAllWorkouts();
      expect(allWorkouts.length, numWorkouts);
    });

    test(
      "Check that loaded workout information is correct when there is only 1 workout",
      () async {
        DateTime date = DateTime(10, 5, 2);
        int id = 5;
        Workout workout = Workout(date);
        workout.id = 5;

        String exerciseName = "Bench";
        Exercise e = Exercise(exerciseName);
        double setWeight = 10;
        int setReps = 4;
        e.addSet(setWeight, setReps);
        workout.addExercises([e]);
        await workoutRepository.saveWorkout(workout);

        expect(await isar.workoutModels.count(), 1);
        List<Workout> allWorkouts = await workoutRepository.getAllWorkouts();
        Workout foundWorkout = allWorkouts.first;
        expect(foundWorkout.startTime, date);
        expect(foundWorkout.id, id);
        expect(foundWorkout.exercises.length, 1);

        Exercise loadedExercise = foundWorkout.exercises.first;
        expect(loadedExercise.name, exerciseName);
        expect(loadedExercise.sets.length, 1);
        expect(loadedExercise.sets.first.reps, setReps);
        expect(loadedExercise.sets.first.weight, setWeight);
      },
    );
  });
}
