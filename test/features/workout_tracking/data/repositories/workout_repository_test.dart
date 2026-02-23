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
}
