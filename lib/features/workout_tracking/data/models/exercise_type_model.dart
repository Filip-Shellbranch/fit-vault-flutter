import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:isar_community/isar.dart';

part 'exercise_type_model.g.dart';

@collection
@Name("ExerciseType")
class ExerciseTypeModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String name;

  bool isBodyWeight;

  ExerciseTypeModel(this.name, this.isBodyWeight);

  factory ExerciseTypeModel.fromExerciseType(ExerciseType exerciseType) {
    return ExerciseTypeModel(
      exerciseType.exerciseName,
      exerciseType.isBodyWeight,
    );
  }
}
