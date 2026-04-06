import 'dart:io';

import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_type_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/exercise_type_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';

void main() {
  late Isar isar;
  late ExerciseTypeRepository exerciseRepository;

  final testDefaultList = [
    ExerciseType("Abdominal"),
    ExerciseType("Chest press"),
  ];

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([
      ExerciseTypeModelSchema,
    ], directory: Directory.systemTemp.path);
    exerciseRepository = ExerciseTypeRepository(isar);
  });

  tearDown(() async {
    await isar.close(deleteFromDisk: true);
  });

  group("Test ensure populated with default exercises", () {
    test("Test populate default", () async {
      expect(await isar.exerciseTypeModels.count(), 0);
      await exerciseRepository.populateWithDefaults(testDefaultList);
      expect(await isar.exerciseTypeModels.count(), testDefaultList.length);

      final foundModels = await isar.exerciseTypeModels.where().findAll();
      for (var type in testDefaultList) {
        bool wasFound = foundModels.any(
          (var model) => model.name == type.exerciseName,
        );
        expect(wasFound, isTrue);
      }
    });

    test("Test ensure populated populates if empty", () async {
      expect(await isar.exerciseTypeModels.count(), 0);
      await exerciseRepository.ensurePopulated(defaultTypes: testDefaultList);
      expect(await isar.exerciseTypeModels.count(), testDefaultList.length);

      final foundModels = await isar.exerciseTypeModels.where().findAll();
      for (var type in testDefaultList) {
        bool wasFound = foundModels.any(
          (var model) => model.name == type.exerciseName,
        );
        expect(wasFound, isTrue);
      }
    });

    test("Test ensure populated does not populate if not empty", () async {
      await isar.writeTxn(() async {
        await isar.exerciseTypeModels.put(
          ExerciseTypeModel("Biceps curl", true),
        );
      });

      expect(await isar.exerciseTypeModels.count(), 1);
      await exerciseRepository.ensurePopulated(defaultTypes: testDefaultList);
      expect(await isar.exerciseTypeModels.count(), 1);

      final foundModels = await isar.exerciseTypeModels.where().findAll();
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
      expect(await isar.exerciseTypeModels.count(), 0);
      ExerciseTypeSaveResult result = await exerciseRepository
          .saveNewExerciseType(ExerciseType(eName));
      expect(result.isSuccess(), isTrue);
      expect(result.exerciseType, isNotNull);
      expect(await isar.exerciseTypeModels.count(), 1);

      String eName2 = "exercise2";
      expect(await isar.exerciseTypeModels.count(), 1);
      ExerciseTypeSaveResult result2 = await exerciseRepository
          .saveNewExerciseType(ExerciseType(eName2));
      expect(result2.isSuccess(), isTrue);
      expect(result2.exerciseType, isNotNull);
      expect(await isar.exerciseTypeModels.count(), 2);
    });
    test("Save an exercise that already exists", () async {
      String eName = "exercise1";
      expect(await isar.exerciseTypeModels.count(), 0);
      ExerciseTypeSaveResult result = await exerciseRepository
          .saveNewExerciseType(ExerciseType(eName));
      expect(result.isSuccess(), isTrue);
      expect(result.exerciseType, isNotNull);
      expect(await isar.exerciseTypeModels.count(), 1);

      expect(await isar.exerciseTypeModels.count(), 1);
      ExerciseTypeSaveResult result2 = await exerciseRepository
          .saveNewExerciseType(ExerciseType(eName));
      expect(result2.isSuccess(), isFalse);
      expect(result2.exerciseType, isNull);
      expect(await isar.exerciseTypeModels.count(), 1);
    });
  });
  group("Fetching saved exercises", () {
    test("Fetch exercises when there are no saved exercises", () async {
      List<ExerciseType> exercises = await exerciseRepository
          .getExerciseTypes();
      expect(exercises.isEmpty, isTrue);
    });

    test("Fetch exercises when there is a saved exercise", () async {
      String eName = "exercise1";
      ExerciseTypeSaveResult result = await exerciseRepository
          .saveNewExerciseType(ExerciseType(eName));
      expect(result.isSuccess(), isTrue);
      expect(result.exerciseType, isNotNull);
      List<ExerciseType> exercises = await exerciseRepository
          .getExerciseTypes();
      expect(exercises.isEmpty, isFalse);
      expect(exercises.length, 1);
    });
    test("Fetch exercises when there are multiple saved exercises", () async {
      int numExercises = 5;
      expect(numExercises, greaterThan(2));
      for (var i = 0; i < numExercises; i++) {
        String eName = "exercise_${i.toString()}";
        ExerciseTypeSaveResult result = await exerciseRepository
            .saveNewExerciseType(ExerciseType(eName));
        expect(result.isSuccess(), isTrue);
        expect(result.exerciseType, isNotNull);
      }

      List<ExerciseType> exercises = await exerciseRepository
          .getExerciseTypes();
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
        ExerciseTypeModel(exerciseName1, true),
        ExerciseTypeModel(exerciseName2, false),
      ];

      await isar.writeTxn(() async {
        await isar.exerciseTypeModels.put(models[0]);
        await isar.exerciseTypeModels.put(models[1]);
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

  group("Test formatting of exercise type names", () {
    test("Format an empty string returns an empty string", () {
      expect(formatExerciseName(""), matches(""));
      expect(formatExerciseName("     "), matches(""));
    });

    test("Format a string capitalizes the first character", () {
      expect(formatExerciseName("hejsan"), matches("Hejsan"));
      expect(formatExerciseName("a"), matches("A"));
      expect(formatExerciseName("exErciSe tYpe"), matches("Exercise type"));
      expect(formatExerciseName("  biceps CURL    "), matches("Biceps curl"));
    });
  });
}
