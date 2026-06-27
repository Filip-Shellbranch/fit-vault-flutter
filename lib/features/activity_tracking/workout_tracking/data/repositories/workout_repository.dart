import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/models/exercise_model.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/models/exercise_type_model.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/models/workout_model.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/repositories/exercise_repository.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/repositories/exercise_type_repository.dart';
import 'package:isar_community/isar.dart';

class WorkoutRepository {
  Isar db;
  WorkoutRepository(this.db);

  Future<Workout> saveWorkout(
    Workout workout, {
    bool isCompleted = false,
  }) async {
    /*
    Saves the WorkoutModel and ExerciseModels described by the Workout,
    returns a new Workout with the database ID:s for the workout and exercises.
    */
    workout.endTime = workout.endTime ?? DateTime.now();
    WorkoutModel newWorkout = WorkoutModel.fromWorkout(workout);
    newWorkout.currentState = isCompleted
        ? WorkoutState.completed
        : WorkoutState.active;

    final newExercises = workout.exercises.map((exercise) {
      final newModel = ExerciseModel.fromExercise(exercise);

      if (newWorkout.currentState == WorkoutState.active) {
        newModel.isLocked = exercise.isLocked;
      } else {
        newModel.isLocked = true;
      }
      return newModel;
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

      final List<Id> exerciseIds = await db.exerciseModels.putAll(newExercises);
      for (int i = 0; i < workout.exercises.length; i++) {
        workout.exercises[i].id = exerciseIds[i];
      }

      final typeRepo = ExerciseTypeRepository(db);
      for (var i = 0; i < workout.exercises.length; i++) {
        Exercise exercise = workout.exercises.elementAt(i);
        ExerciseModel model = newExercises.elementAt(i);
        Id? id = await typeRepo.findExerciseTypeIdFromName(exercise.name);
        if (id != null) {
          final typeModel = await db.exerciseTypeModels.get(id);
          model.exerciseType.value = typeModel;
          model.exerciseType.save();
        }
      }

      newWorkout.exercises.clear();
      newWorkout.exercises.addAll(newExercises);
      await newWorkout.exercises.save();
    });
    if (!isCompleted) {
      workout.endTime = null;
    }

    return workout;
  }

  Future<void> deleteWorkoutById(int id) async {
    await db.writeTxn(() async {
      final workoutModel = await db.workoutModels.get(id);
      if (workoutModel == null) {
        return;
      }
      await workoutModel.exercises.load();

      final List<int> exerciseIds = workoutModel.exercises
          .map((exerciseModel) => exerciseModel.id)
          .toList();
      await db.exerciseModels.deleteAll(exerciseIds);
      await db.workoutModels.delete(id);
    });
  }

  Future<Workout> _loadWorkoutFromModel(WorkoutModel model) async {
    Workout workout = Workout.fromModel(model);
    final exerciseRepo = ExerciseRepository(db);

    await model.exercises.load();
    List<Future<Exercise>> loadExerciseTasks = model.exercises.map(
      (exerciseModel) async {
        final exercise = await exerciseRepo.loadExerciseFromModel(
          exerciseModel,
        );
        if (workout.currentState == WorkoutState.completed) {
          exercise.setLock(true);
        }
        return exercise;
      }, // exerciseRepo.loadExerciseFromModel(exerciseModel),
    ).toList();

    List<Exercise> newExercises = await Future.wait(loadExerciseTasks);
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

  Future<List<Workout>> getWorkoutsWithExercise(String exerciseName) async {
    List<WorkoutModel> models = await db.workoutModels
        .filter()
        .exercises((e) => e.exerciseType((q) => q.nameEqualTo(exerciseName)))
        .findAll();
    Future<List<Workout>> workouts = Future.wait(
      models.map((model) => _loadWorkoutFromModel(model)),
    );
    return workouts;
  }

  Future<int> countWorkoutsWithExercise(String exerciseName) async {
    return db.workoutModels
        .filter()
        .exercises((e) => e.exerciseType((q) => q.nameEqualTo(exerciseName)))
        .count();
  }

  Future<Workout?> loadCurrentWorkout() async {
    List<WorkoutModel> activeWorkouts = await db.workoutModels
        .filter()
        .currentStateEqualTo(WorkoutState.active)
        .findAll();
    if (activeWorkouts.isEmpty) {
      return null;
    }
    if (activeWorkouts.length > 1) {
      throw StateError("Multiple active workouts found!");
    }
    WorkoutModel currentModel = activeWorkouts.single;
    Workout workout = await _loadWorkoutFromModel(currentModel);
    workout.endTime = null;
    return workout;
  }
}
