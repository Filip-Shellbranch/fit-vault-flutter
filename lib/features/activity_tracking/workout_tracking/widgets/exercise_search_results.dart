import 'package:fit_vault_flutter/features/activity_tracking/statistics/views/exercise_info_page.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise_type_result.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/views/edit_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseSearchResults extends ConsumerWidget {
  final List<ExerciseTypeResult> searchResults;
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
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, i) {
        ExerciseType exerciseType = searchResults.elementAt(i).type;
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
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,

                          alignment: Alignment.centerLeft,
                        ),
                        onPressed: () {
                          selectExerciseFunc(exerciseType);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exerciseName,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 20),
                            ),
                            exerciseType.isBodyWeight
                                ? Text(
                                    "Uses bodyweight",
                                    style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ExerciseInfoPage(exerciseName: exerciseName);
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Show info",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
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
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        );
      },
    );
  }
}
