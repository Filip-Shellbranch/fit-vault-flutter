import 'package:isar_community/isar.dart';

part 'saved_exercise_model.g.dart';

@collection
@Name("SavedExercise")
class SavedExerciseModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String name;

  SavedExerciseModel(this.name);
}
