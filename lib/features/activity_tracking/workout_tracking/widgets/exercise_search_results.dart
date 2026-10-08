import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/views/edit_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseSearchResults extends ConsumerWidget {
  final List<ExerciseType> searchResults;
  final SelectExerciseCallback selectExerciseFunc;
  final DeleteExerciseTypeCallback deleteExerciseFunc;
  const ExerciseSearchResults({
    super.key,
    required this.searchResults,
    required this.selectExerciseFunc,
    required this.deleteExerciseFunc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(overscroll: false),
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, i) {
          ExerciseType exerciseType = searchResults.elementAt(i);
          String exerciseName = exerciseType.exerciseName;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 6),
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
                      child: Text(exerciseName, style: TextStyle(fontSize: 20)),
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
      ),
    );
  }
}
