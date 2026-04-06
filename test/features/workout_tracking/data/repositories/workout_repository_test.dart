import 'dart:io';

import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_type_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/workout_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/exercise_type_repository.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/workout_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';

void main() {
  late Isar isar;
  late WorkoutRepository workoutRepository;

  final testDefaultList = [
    ExerciseType("Abdominal"),
    ExerciseType("Chest press"),
    ExerciseType("Bench press"),
    ExerciseType("Leg press"),
    ExerciseType("Biceps curl"),
    ExerciseType("Triceps press"),
  ];
  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([
      ExerciseModelSchema,
      WorkoutModelSchema,
      ExerciseTypeModelSchema,
    ], directory: Directory.systemTemp.path);
    workoutRepository = WorkoutRepository(isar);
    await ExerciseTypeRepository(
      isar,
    ).ensurePopulated(defaultTypes: testDefaultList);
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
      String exerciseName = "Bench press";

      DateTime time = DateTime(15, 5, 2);
      Workout workout = Workout(time);
      Exercise exercise = Exercise(exerciseType: ExerciseType(exerciseName));
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
        String exerciseName = "Bench press";

        DateTime time = DateTime(15, 5, 2);
        Workout workout = Workout(time);
        Exercise exercise = Exercise(exerciseType: ExerciseType(exerciseName));
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
        String exerciseName = "Bench press";
        String exerciseName2 = "Leg press";

        DateTime time = DateTime(15, 5, 2);
        Workout workout = Workout(time);
        Exercise exercise = Exercise(exerciseType: ExerciseType(exerciseName));
        workout.exercises.add(exercise);
        Exercise exercise2 = Exercise(
          exerciseType: ExerciseType(exerciseName2),
        );
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
        String exerciseName = "Bench press";
        String exerciseName2 = "Leg press";

        DateTime time = DateTime(15, 5, 2);
        Workout workout = Workout(time);
        Exercise exercise = Exercise(exerciseType: ExerciseType(exerciseName));
        workout.exercises.add(exercise);
        Exercise exercise2 = Exercise(
          exerciseType: ExerciseType(exerciseName2),
        );
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

        workout.exercises.add(
          Exercise(exerciseType: ExerciseType("Bench press")),
        );
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

        String exerciseName = "Bench press";
        Exercise e = Exercise(exerciseType: ExerciseType(exerciseName));
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

  group("Test finding workouts containing specific exercise", () {
    test("Test finding all workouts for exercise if there are none", () async {
      Workout w1 = Workout(DateTime(1));
      await workoutRepository.saveWorkout(w1);

      Workout w2 = Workout(DateTime(3, 3));
      w2.addExercises([Exercise(exerciseType: ExerciseType("Abdominal"))]);
      await workoutRepository.saveWorkout(w2);

      String exerciseName = "Chest press";
      List<Workout> workouts = await workoutRepository.getWorkoutsWithExercise(
        exerciseName,
      );
      int numWorkouts = await workoutRepository.countWorkoutsWithExercise(
        exerciseName,
      );
      expect(workouts, isEmpty);
      expect(numWorkouts, 0);
    });

    test("Test finding all workouts for exercise if there is one", () async {
      Workout w1 = Workout(DateTime(1));
      await workoutRepository.saveWorkout(w1);

      String exerciseName = "Chest press";

      Workout w2 = Workout(DateTime(3, 3));
      w2.addExercises([Exercise(exerciseType: ExerciseType(exerciseName))]);
      await workoutRepository.saveWorkout(w2);

      List<Workout> workouts = await workoutRepository.getWorkoutsWithExercise(
        exerciseName,
      );
      int numWorkouts = await workoutRepository.countWorkoutsWithExercise(
        exerciseName,
      );
      expect(workouts, isNotEmpty);
      expect(workouts.length, 1);
      expect(numWorkouts, 1);
    });

    test(
      "Test finding all workouts for exercise if there are several",
      () async {
        Workout w1 = Workout(DateTime(1));
        await workoutRepository.saveWorkout(w1);

        String exerciseName = "Biceps curl";
        int count = 5;
        final saveTasks = List.generate(count, (int i) {
          Workout w = Workout(DateTime(3, 3));
          w.addExercises([Exercise(exerciseType: ExerciseType(exerciseName))]);
          return workoutRepository.saveWorkout(w);
        });
        await Future.wait(saveTasks);

        String exerciseName2 = "Triceps press";
        int count2 = 3;
        final saveTasks2 = List.generate(count2, (int i) {
          Workout w = Workout(DateTime(3, 3));
          w.addExercises([Exercise(exerciseType: ExerciseType(exerciseName2))]);
          return workoutRepository.saveWorkout(w);
        });
        await Future.wait(saveTasks2);

        List<Workout> workouts = await workoutRepository
            .getWorkoutsWithExercise(exerciseName);
        int numWorkouts = await workoutRepository.countWorkoutsWithExercise(
          exerciseName,
        );
        expect(workouts, isNotEmpty);
        expect(workouts.length, count);
        expect(numWorkouts, count);

        List<Workout> workouts2 = await workoutRepository
            .getWorkoutsWithExercise(exerciseName2);
        int numWorkouts2 = await workoutRepository.countWorkoutsWithExercise(
          exerciseName,
        );
        expect(workouts2, isNotEmpty);
        expect(workouts2.length, count2);
        expect(numWorkouts2, count);
      },
    );

    test(
      "Test finding workout with exercise even if workouts also contain other exercises",
      () async {
        Workout w1 = Workout(DateTime(1));
        await workoutRepository.saveWorkout(w1);

        String exerciseName = "Chest press";
        Workout w2 = Workout(DateTime(3, 3));
        w2.addExercises([
          Exercise(exerciseType: ExerciseType(exerciseName)),
          Exercise(exerciseType: ExerciseType("Abdominal")),
        ]);
        await workoutRepository.saveWorkout(w2);

        List<Workout> workouts = await workoutRepository
            .getWorkoutsWithExercise(exerciseName);
        int numWorkouts = await workoutRepository.countWorkoutsWithExercise(
          exerciseName,
        );
        expect(workouts, isNotEmpty);
        expect(workouts.length, 1);
        expect(numWorkouts, 1);
      },
    );
  });
}
