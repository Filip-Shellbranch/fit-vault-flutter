import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_type_model.dart';

class ExerciseType {
  int? id;

  final String exerciseName;
  final bool isBodyWeight;
  ExerciseType(this.exerciseName, {this.isBodyWeight = false});

  factory ExerciseType.fromModel(ExerciseTypeModel model) {
    final newType = ExerciseType(model.name, isBodyWeight: model.isBodyWeight);
    newType.id = model.id;
    return newType;
  }
}
