import 'package:fit_vault_flutter/features/workout_tracking/views/edit_exercise_page.dart';
import 'package:flutter/material.dart';

class ExerciseSearchResults extends StatelessWidget {
  final List<String> searchResults;
  final SelectExerciseCallback selectExerciseFunc;
  const ExerciseSearchResults({
    super.key,
    required this.searchResults,
    required this.selectExerciseFunc,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, i) {
        String exerciseName = searchResults.elementAt(i);
        return TextButton(
          onPressed: () {
            selectExerciseFunc(exerciseName);
          },
          child: Text(exerciseName),
        );
      },
    );
  }
}
