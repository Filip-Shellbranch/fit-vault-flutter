import 'package:fit_vault_flutter/features/workout_tracking/data/classes/default_exercises.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/saved_exercise_repository_provider.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/exercise_search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef SelectExerciseCallback = void Function(ExerciseType exerciseType);
typedef CreateExerciseTypeCallback =
    Future<bool> Function(ExerciseType exerciseType);
typedef DeleteExerciseTypeCallback = Future<bool> Function(String exerciseName);

Exercise createDefaultExercise(ExerciseType exerciseType) {
  final newExercise = Exercise();
  newExercise.exerciseType = exerciseType;
  newExercise.addSet(0, 10);
  return newExercise;
}

class EditExercisePage extends ConsumerStatefulWidget {
  final int? exerciseIndex;
  final Exercise? exercise;
  const EditExercisePage({super.key, this.exerciseIndex, this.exercise});
  @override
  ConsumerState<EditExercisePage> createState() => _EditExercisePageState();
}

class _EditExercisePageState extends ConsumerState<EditExercisePage> {
  List<ExerciseType> exerciseList = defaultExerciseList;

  final ValueNotifier<List<ExerciseType>> _searchResults =
      ValueNotifier<List<ExerciseType>>(defaultExerciseList);

  final searchController = TextEditingController();

  void updateExerciseList(List<ExerciseType> newList) {
    exerciseList = newList;
    _searchResults.value = newList;
  }

  void selectExercise(ExerciseType exerciseType) {
    bool isNewExercise =
        widget.exercise == null || widget.exerciseIndex == null;
    final newExercise = widget.exercise ?? createDefaultExercise(exerciseType);

    if (isNewExercise) {
      ref.read(currentWorkoutProvider.notifier).addExercise(newExercise);
    } else {
      newExercise.exerciseType = exerciseType;
      ref
          .read(currentWorkoutProvider.notifier)
          .updateExercise(widget.exerciseIndex!, newExercise);
    }
    Navigator.pop(context);
  }

  void searchForExercise(String searchQuery) {
    final foundExercises = exerciseList.where((exerciseType) {
      return exerciseType.exerciseName.toLowerCase().contains(
        searchQuery.toLowerCase().trim(),
      );
    }).toList();
    _searchResults.value = foundExercises;
  }

  Future<bool> createExerciseType(ExerciseType newType) async {
    final repository = ref.read(savedExerciseRepositoryProvider);

    bool success = await repository.saveNewExerciseType(newType);
    if (success) {
      final newList = [...exerciseList, newType];
      updateExerciseList(newList);
    }
    return success;
  }

  Future<bool> tryDeleteExerciseType(String exerciseName) async {
    final currentWorkout = ref.read(currentWorkoutProvider);
    if (currentWorkout.exercises.any(
      (Exercise exercise) => exercise.name == exerciseName,
    )) {
      // The exercise is used in the current workout and should not be able to be deleted.
      return false;
    }
    final repository = ref.read(savedExerciseRepositoryProvider);
    bool success = await repository.tryDeleteExerciseType(exerciseName);
    if (success) {
      final newList = [...exerciseList];
      newList.removeWhere((e) => e.exerciseName == exerciseName);
      updateExerciseList(newList);
    }
    return success;
  }

  @override
  void initState() {
    final repository = ref.read(savedExerciseRepositoryProvider);
    repository.getExerciseTypes().then((List<ExerciseType> savedExercises) {
      updateExerciseList(savedExercises);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                controller: searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search for an exercise",
                ),
                onChanged: (searchQuery) {
                  searchForExercise(searchQuery);
                },
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _searchResults,
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExerciseSearchResults(
                    searchResults: _searchResults.value,
                    selectExerciseFunc: selectExercise,
                    createExerciseFunc: createExerciseType,
                    deleteExerciseFunc: tryDeleteExerciseType,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
