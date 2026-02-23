import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/workout_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test create Workout from Workout Model", () {
    WorkoutModel model = WorkoutModel(DateTime(2, 4, 3), DateTime(1, 1, 1));
    model.id = 99;

    Workout workout = Workout.fromModel(model);
    expect(workout.id, model.id);
    expect(workout.startTime, model.startTime);
    expect(workout.endTime, model.endTime);
    expect(workout.endTime, isNotNull);
  });
}
