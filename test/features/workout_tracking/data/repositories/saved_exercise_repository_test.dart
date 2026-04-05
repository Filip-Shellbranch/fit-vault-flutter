import 'dart:io';

import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/saved_exercise_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/saved_exercise_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';

void main() {
  late Isar isar;
  late SavedExerciseRepository exerciseRepository;

  final testDefaultList = [
    ExerciseType("Abdominal"),
    ExerciseType("Chest press"),
  ];

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([
      SavedExerciseModelSchema,
    ], directory: Directory.systemTemp.path);
    exerciseRepository = SavedExerciseRepository(isar);
  });

  tearDown(() async {
    await isar.close(deleteFromDisk: true);
  });

  group("Test ensure populated with default exercises", () {
    test("Test populate default", () async {
      expect(await isar.savedExerciseModels.count(), 0);
      await exerciseRepository.populateWithDefaults(testDefaultList);
      expect(await isar.savedExerciseModels.count(), testDefaultList.length);

      final foundModels = await isar.savedExerciseModels.where().findAll();
      for (var type in testDefaultList) {
        bool wasFound = foundModels.any(
          (var model) => model.name == type.exerciseName,
        );
        expect(wasFound, isTrue);
      }
    });

    test("Test ensure populated populates if empty", () async {
      expect(await isar.savedExerciseModels.count(), 0);
      await exerciseRepository.ensurePopulated(defaultTypes: testDefaultList);
      expect(await isar.savedExerciseModels.count(), testDefaultList.length);

      final foundModels = await isar.savedExerciseModels.where().findAll();
      for (var type in testDefaultList) {
        bool wasFound = foundModels.any(
          (var model) => model.name == type.exerciseName,
        );
        expect(wasFound, isTrue);
      }
    });

    test("Test ensure populated does not populate if not empty", () async {
      await isar.writeTxn(() async {
        await isar.savedExerciseModels.put(
          SavedExerciseModel("Biceps curl", true),
        );
      });

      expect(await isar.savedExerciseModels.count(), 1);
      await exerciseRepository.ensurePopulated(defaultTypes: testDefaultList);
      expect(await isar.savedExerciseModels.count(), 1);

      final foundModels = await isar.savedExerciseModels.where().findAll();
      for (var type in testDefaultList) {
        bool wasFound = foundModels.any(
          (var model) => model.name == type.exerciseName,
        );
        expect(wasFound, isFalse);
      }
    });
  });

  group("Saving of a new exercise", () {
    test("Save a new exercise that does not yet exist", () async {
      String eName = "exercise1";
      expect(await isar.savedExerciseModels.count(), 0);
      bool success = await exerciseRepository.saveNewExerciseType(
        ExerciseType(eName),
      );
      expect(success, isTrue);
      expect(await isar.savedExerciseModels.count(), 1);

      String eName2 = "exercise2";
      expect(await isar.savedExerciseModels.count(), 1);
      bool success2 = await exerciseRepository.saveNewExerciseType(
        ExerciseType(eName2),
      );
      expect(success2, isTrue);
      expect(await isar.savedExerciseModels.count(), 2);
    });
    test("Save an exercise that already exists", () async {
      String eName = "exercise1";
      expect(await isar.savedExerciseModels.count(), 0);
      bool success = await exerciseRepository.saveNewExerciseType(
        ExerciseType(eName),
      );
      expect(success, isTrue);
      expect(await isar.savedExerciseModels.count(), 1);

      expect(await isar.savedExerciseModels.count(), 1);
      bool success2 = await exerciseRepository.saveNewExerciseType(
        ExerciseType(eName),
      );
      expect(success2, isFalse);
      expect(await isar.savedExerciseModels.count(), 1);
    });
  });
  group("Fetching saved exercises", () {
    test("Fetch exercises when there are no saved exercises", () async {
      List<ExerciseType> exercises = await exerciseRepository
          .getSavedExercises();
      expect(exercises.isEmpty, isTrue);
    });

    test("Fetch exercises when there is a saved exercise", () async {
      String eName = "exercise1";
      bool success = await exerciseRepository.saveNewExerciseType(
        ExerciseType(eName),
      );
      expect(success, isTrue);
      List<ExerciseType> exercises = await exerciseRepository
          .getSavedExercises();
      expect(exercises.isEmpty, isFalse);
      expect(exercises.length, 1);
    });
    test("Fetch exercises when there are multiple saved exercises", () async {
      int numExercises = 5;
      expect(numExercises, greaterThan(2));
      for (var i = 0; i < numExercises; i++) {
        String eName = "exercise_${i.toString()}";
        bool success = await exerciseRepository.saveNewExerciseType(
          ExerciseType(eName),
        );
        expect(success, isTrue);
      }

      List<ExerciseType> exercises = await exerciseRepository
          .getSavedExercises();
      expect(exercises.isEmpty, isFalse);
      expect(exercises.length, numExercises);
    });
  });

  test(
    "Test finding the ID of an ExerciseType using the exercise name",
    () async {
      String exerciseName1 = "Abdominal";
      String exerciseName2 = "Leg curl";
      final models = [
        SavedExerciseModel(exerciseName1, true),
        SavedExerciseModel(exerciseName2, false),
      ];

      await isar.writeTxn(() async {
        await isar.savedExerciseModels.put(models[0]);
        await isar.savedExerciseModels.put(models[1]);
      });
      Id? id1 = await exerciseRepository.findExerciseTypeIdFromName(
        exerciseName1,
      );
      Id? id2 = await exerciseRepository.findExerciseTypeIdFromName(
        exerciseName2,
      );
      expect(id1, 1);
      expect(id2, 2);
    },
  );
}
