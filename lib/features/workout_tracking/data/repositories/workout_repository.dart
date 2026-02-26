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
    workout.endTime = workout.endTime ?? DateTime.now();
    WorkoutModel newWorkout = WorkoutModel.fromWorkout(workout);

    List<ExerciseModel> newExerices = workout.exercises.map((
      Exercise exercise,
    ) {
      return ExerciseModel.fromExercise(exercise);
    }).toList();

    await db.writeTxn(() async {
      if (workout.id != null) {
        final oldWorkout = await db.workoutModels.get(workout.id!);
        if (oldWorkout != null) {
          // Clean up orphan exercises if they are no longer a part of this workout.
          await oldWorkout.exercises.load();

          Set<int> idsToKeep = workout.exercises
              .where((exercise) => exercise.id != null)
              .map((exercise) => exercise.id!)
              .toSet(); // A set of all ID:s that will be a part of the new workout.

          List<Id> orphanIds = oldWorkout.exercises
              .where((exerciseModel) => !idsToKeep.contains(exerciseModel.id))
              .map((exerciseModel) => exerciseModel.id)
              .toList(); // A list of all ID:s that used to be a part of the workout but is not anymore.

          await db.exerciseModels.deleteAll(orphanIds);
        }
      }

      final Id workoutId = await db.workoutModels.put(newWorkout);
      workout.id = workoutId;

      final List<Id> exerciseIds = await db.exerciseModels.putAll(newExerices);
      for (int i = 0; i < workout.exercises.length; i++) {
        workout.exercises[i].id = exerciseIds[i];
      }

      newWorkout.exercises.clear();
      newWorkout.exercises.addAll(newExerices);
      await newWorkout.exercises.save();
    });

    return workout;
  }

  Future<Workout> _loadWorkoutFromModel(WorkoutModel model) async {
    Workout workout = Workout.fromModel(model);

    await model.exercises.load();
    List<Exercise> newExercises = model.exercises
        .map((exerciseModel) => Exercise.fromModel(exerciseModel))
        .toList();
    workout.addExercises(newExercises);
    return workout;
  }

  Future<List<Workout>> getAllWorkouts() async {
    List<WorkoutModel> models = await db.workoutModels.where().findAll();
    List<Workout> workouts = [];
    for (WorkoutModel model in models) {
      Workout workout = await _loadWorkoutFromModel(model);
      workouts.add(workout);
    }
    return workouts;
  }
}
