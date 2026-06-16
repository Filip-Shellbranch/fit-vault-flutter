import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/edited_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/views/edit_workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class WorkoutActivityCard extends ConsumerWidget {
  final WorkoutActivity activity;
  Workout get workout => activity.workout;

  const WorkoutActivityCard({super.key, required this.activity});

  void openWorkout(BuildContext context, WidgetRef ref) {
    ref.read(editedWorkoutProvider.notifier).editWorkout(workout);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditWorkoutPage(isCurrentWorkout: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          activity.formatTimestamp(),
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
                      title: "Duration",
                      displayedInfo: workout.formatDuration(),
                    ),
                    ActivityInfoDisplay(
                      title: "Exercises",
                      displayedInfo: workout.exercises.length.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                openWorkout(context, ref);
              },
              child: SizedBox(
                height: 80,
                child: Icon(Icons.arrow_forward_rounded, size: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
