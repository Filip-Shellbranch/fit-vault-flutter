import 'package:fit_vault_flutter/features/workout_tracking/data/classes/default_exercises.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_type_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/workout_repository.dart';
import 'package:isar_community/isar.dart';

class ExerciseTypeSaveResult {
  final ExerciseType? exerciseType;
  final bool success;

  ExerciseTypeSaveResult(this.success, {this.exerciseType});

  factory ExerciseTypeSaveResult.success(ExerciseType exerciseType) {
    return ExerciseTypeSaveResult(true, exerciseType: exerciseType);
  }
  factory ExerciseTypeSaveResult.fail() {
    return ExerciseTypeSaveResult(false);
  }

  bool isSuccess() {
    return success;
  }

  ExerciseType getType() {
    return exerciseType!;
  }
}

String formatExerciseName(String originalName) {
  String formattedName = originalName.trim().toLowerCase();
  if (formattedName.isNotEmpty) {
    formattedName =
        "${formattedName[0].toUpperCase()}${formattedName.substring(1)}";
  }
  return formattedName;
}

class ExerciseTypeRepository {
  Isar db;
  ExerciseTypeRepository(this.db);

  Future<void> ensurePopulated({List<ExerciseType>? defaultTypes}) async {
    defaultTypes ??= defaultExerciseList;

    final count = await db.exerciseTypeModels.count();
    if (count == 0) {
      await populateWithDefaults(defaultTypes);
    }
  }

  Future<void> populateWithDefaults(List<ExerciseType> defaultTypes) async {
    await db.writeTxn(() async {
      final models = defaultTypes
          .map(
            (final defaultType) =>
                ExerciseTypeModel.fromExerciseType(defaultType),
          )
          .toList();
      db.exerciseTypeModels.putAll(models);
    });
  }

  Future<ExerciseTypeSaveResult> saveNewExerciseType(
    ExerciseType newType,
  ) async {
    String exerciseName = formatExerciseName(newType.exerciseName);
    bool success = await db.writeTxn(() async {
      bool exists = await db.exerciseTypeModels
          .filter()
          .nameMatches(exerciseName)
          .isNotEmpty();
      if (!exists) {
        final newExercise = ExerciseTypeModel(
          exerciseName,
          newType.isBodyWeight,
        );
        await db.exerciseTypeModels.put(newExercise);
        return true;
      }
      return false;
    });
    if (success) {
      final savedType = ExerciseType(
        exerciseName,
        isBodyWeight: newType.isBodyWeight,
      );
      return ExerciseTypeSaveResult.success(savedType);
    }
    return ExerciseTypeSaveResult.fail();
  }

  Future<List<ExerciseType>> getExerciseTypes() async {
    List<ExerciseType> exerciseList = [];
    List<ExerciseTypeModel> savedExercises = await db.exerciseTypeModels
        .where()
        .findAll();
    for (var savedExercise in savedExercises) {
      final newExercise = ExerciseType.fromModel(savedExercise);
      exerciseList.add(newExercise);
    }
    return exerciseList;
  }

  Future<bool> tryDeleteExerciseType(String exerciseName) async {
    bool exists = await db.exerciseTypeModels
        .filter()
        .nameEqualTo(exerciseName)
        .isNotEmpty();
    if (!exists) {
      return true;
    }

    int numberOfOccurances = await WorkoutRepository(
      db,
    ).countWorkoutsWithExercise(exerciseName);
    if (numberOfOccurances == 0) {
      await db.writeTxn(() async {
        await db.exerciseTypeModels
            .where()
            .nameEqualTo(exerciseName)
            .deleteAll();
      });
      return true;
    }
    return false;
  }

  Future<Id?> findExerciseTypeIdFromName(String exerciseName) async {
    ExerciseTypeModel? foundModel = await db.exerciseTypeModels.getByName(
      exerciseName,
    );
    if (foundModel != null) {
      return foundModel.id;
    } else {
      return null;
    }
  }
}
