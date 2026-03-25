import 'package:fit_vault_flutter/features/workout_tracking/data/classes/default_exercises.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/exercise_search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef SelectExerciseCallback = void Function(String exerciseName);

class EditExercisePage extends ConsumerStatefulWidget {
  final int? exerciseIndex;
  final Exercise? exercise;
  const EditExercisePage({super.key, this.exerciseIndex, this.exercise});

  @override
  ConsumerState<EditExercisePage> createState() => _EditExercisePageState();
}

class _EditExercisePageState extends ConsumerState<EditExercisePage> {
  final exerciseList = defaultExerciseList;

  final ValueNotifier<List<String>> _searchResults =
      ValueNotifier<List<String>>(defaultExerciseList);

  final searchController = TextEditingController();

  void selectExercise(String exerciseName) {
    bool isNewExercise =
        widget.exercise == null || widget.exerciseIndex == null;
    final newExercise = widget.exercise ?? Exercise(exerciseName);

    if (isNewExercise) {
      ref.read(currentWorkoutProvider.notifier).addExercise(newExercise);
    } else {
      newExercise.name = exerciseName;
      ref
          .read(currentWorkoutProvider.notifier)
          .updateExercise(widget.exerciseIndex!, newExercise);
    }
    Navigator.pop(context);
  }

  void searchForExercise(String searchQuery) {
    final foundExercises = exerciseList.where((exerciseName) {
      return exerciseName.toLowerCase().contains(
        searchQuery.toLowerCase().trim(),
      );
    }).toList();
    _searchResults.value = foundExercises;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextField(
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
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _searchResults,
                builder: (context, value, child) => ExerciseSearchResults(
                  searchResults: _searchResults.value,
                  selectExerciseFunc: selectExercise,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
