import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/models/exercise_model.dart';
import 'package:flutter/material.dart';

class ActivityInfoDisplay extends StatelessWidget {
  final String title;
  final String displayedInfo;
  const ActivityInfoDisplay({
    super.key,
    required this.title,
    required this.displayedInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 18)),
        Text(
          displayedInfo,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }
}

class ExerciseHistoryItem extends StatelessWidget {
  final ExerciseModel exercise;
  const ExerciseHistoryItem({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final reps = exercise.sets.last.reps!;
    final weight = exercise.sets.last.weight!;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).primaryColor, width: 4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImageIcon(
                        AssetImage("assets/icons/icons8-gym-100.png"),
                        size: 40,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Workout on"),
                        Text(
                          formatDate(
                            exercise.date == null
                                ? DateTime.now()
                                : exercise.date!,
                          ),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActivityInfoDisplay(
                      title: "Reps",
                      displayedInfo: reps.toString(),
                    ),
                    ActivityInfoDisplay(
                      title: "Weight",
                      displayedInfo: weight == 0.0
                          ? "Bodyweight"
                          : "${weight.toString()} kg",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
