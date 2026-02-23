import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/exercise_model.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/models/workout_model.dart';
import 'package:isar_community/isar.dart';

class WorkoutRepository {
  Isar db;
  WorkoutRepository(this.db);

  Future<Workout> saveWorkout(Workout workout) async {
    /*
    Saves the WorkoutModel and ExerciseModels described by the Workout,
    returns a new Workout with the database ID:s for the workout and exercises.
    */
    // TODO: Add exercise orphan cleanup in case an exercise was removed from an existing workout.
    workout.endTime = workout.endTime ?? DateTime.now();
    WorkoutModel newWorkout = WorkoutModel.fromWorkout(workout);

    List<ExerciseModel> newExerices = workout.exercises.map((
      Exercise exercise,
    ) {
      return ExerciseModel.fromExercise(exercise);
    }).toList();

    await db.writeTxn(() async {
      final Id workoutId = await db.workoutModels.put(newWorkout);
      workout.id = workoutId;

      final List<Id> exerciseIds = await db.exerciseModels.putAll(newExerices);
      for (int i = 0; i < workout.exercises.length; i++) {
        workout.exercises[i].id = exerciseIds[i];
      }

      newWorkout.exercises.addAll(newExerices);
      await newWorkout.exercises.save();
    });

    return workout;
  }
}
