import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/views/edit_exercise_page.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/create_exercise_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseSearchResults extends ConsumerWidget {
  final List<ExerciseType> searchResults;
  final SelectExerciseCallback selectExerciseFunc;
  final CreateExerciseTypeCallback createExerciseFunc;
  final DeleteExerciseTypeCallback deleteExerciseFunc;
  const ExerciseSearchResults({
    super.key,
    required this.searchResults,
    required this.selectExerciseFunc,
    required this.createExerciseFunc,
    required this.deleteExerciseFunc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: searchResults.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CreateExerciseDialog(
                      createExerciseFunc: createExerciseFunc,
                    );
                  },
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).highlightColor,
                foregroundColor: Colors.white,
              ),
              child: Text("Add a new exercise type"),
            ),
          );
        }
        ExerciseType exerciseType = searchResults.elementAt(i - 1);
        String exerciseName = exerciseType.exerciseName;
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {
                      selectExerciseFunc(exerciseType);
                    },
                    child: Text(exerciseName),
                  ),
                ),
              ),
              exerciseType.isBodyWeight
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text("Uses body weight"),
                    )
                  : Container(),
              IconButton(
                onPressed: () async {
                  bool success = await deleteExerciseFunc(exerciseName);
                  if (!success && context.mounted) {
                    final snackBar = SnackBar(
                      content: Text(
                        "Exercise '$exerciseName' can not be deleted as it is used in one or more workouts!",
                      ),
                    );
                    final messenger = ScaffoldMessenger.of(context);
                    messenger.clearSnackBars();
                    messenger.showSnackBar(snackBar);
                  }
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        );
      },
    );
  }
}
