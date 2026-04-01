import 'dart:io';

import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/saved_exercise_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/saved_exercise_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';

void main() {
  late Isar isar;
  late SavedExerciseRepository exerciseRepository;
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

  group("Saving of a new exercise", () {
    test("Save a new exercise that does not yet exist", () async {
      String eName = "exercise1";
      expect(await isar.savedExerciseModels.count(), 0);
      bool success = await exerciseRepository.saveNewExerciseType(eName);
      expect(success, isTrue);
      expect(await isar.savedExerciseModels.count(), 1);

      String eName2 = "exercise2";
      expect(await isar.savedExerciseModels.count(), 1);
      bool success2 = await exerciseRepository.saveNewExerciseType(eName2);
      expect(success2, isTrue);
      expect(await isar.savedExerciseModels.count(), 2);
    });
    test("Save an exercise that already exists", () async {
      String eName = "exercise1";
      expect(await isar.savedExerciseModels.count(), 0);
      bool success = await exerciseRepository.saveNewExerciseType(eName);
      expect(success, isTrue);
      expect(await isar.savedExerciseModels.count(), 1);

      expect(await isar.savedExerciseModels.count(), 1);
      bool success2 = await exerciseRepository.saveNewExerciseType(eName);
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
      bool success = await exerciseRepository.saveNewExerciseType(eName);
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
        bool success = await exerciseRepository.saveNewExerciseType(eName);
        expect(success, isTrue);
      }

      List<ExerciseType> exercises = await exerciseRepository
          .getSavedExercises();
      expect(exercises.isEmpty, isFalse);
      expect(exercises.length, numExercises);
    });
  });
}
