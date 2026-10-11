import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/statistics/widgets/exercise_info_stat.dart';
import 'package:fit_vault_flutter/features/activity_tracking/statistics/widgets/history_set_item.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/providers/exercise_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseInfoPage extends ConsumerWidget {
  final String exerciseName;
  const ExerciseInfoPage({super.key, required this.exerciseName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseRepo = ref.read(exerciseRepositoryProvider);

    final getHistoryAsync = exerciseRepo.getExerciseHistory(exerciseName);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getHistoryAsync,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            dError("Error loading exercise history");
            return Center(child: Text("Error loading exercise history"));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final exerciseHistory = snapshot.data!;
          final lastSet = exerciseRepo.getLastSetFromHistory(exerciseHistory);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Exercise:", style: TextStyle(fontSize: 16)),
                    Text(
                      exerciseName,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withAlpha(90),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Basic statistics",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ExerciseInfoStat(
                            statName: "Number logged",
                            value: exerciseHistory.length.toString(),
                          ),
                          ExerciseInfoStat(
                            statName: "Recent weight",
                            value: lastSet == null
                                ? "NONE"
                                : lastSet.weight == 0
                                ? "Bodyweight"
                                : "${lastSet.weight} kg",
                            borderOnLeft: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withAlpha(90),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Exercise history",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior().copyWith(overscroll: false),
                    child: ListView.builder(
                      itemCount: exerciseHistory.length,
                      itemBuilder: (context, i) {
                        final exercise = exerciseHistory.elementAt(
                          exerciseHistory.length - i - 1,
                        );
                        return ExerciseHistoryItem(exercise: exercise);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
