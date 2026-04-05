import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:isar_community/isar.dart';

part 'saved_exercise_model.g.dart';

@collection
@Name("SavedExercise")
class SavedExerciseModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String name;

  bool isBodyWeight;

  SavedExerciseModel(this.name, this.isBodyWeight);

  factory SavedExerciseModel.fromExerciseType(ExerciseType exerciseType) {
    return SavedExerciseModel(
      exerciseType.exerciseName,
      exerciseType.isBodyWeight,
    );
  }
}
