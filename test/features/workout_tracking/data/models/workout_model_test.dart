import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/workout_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test create model from Workout", () {
    Workout workout = Workout(DateTime(2, 2, 2));
    workout.endTime = DateTime(1, 1, 1);
    workout.id = 9;

    WorkoutModel model = WorkoutModel.fromWorkout(workout);
    expect(model.startTime, workout.startTime);
    expect(model.endTime, workout.endTime);
    expect(model.id, workout.id);
  });
}
