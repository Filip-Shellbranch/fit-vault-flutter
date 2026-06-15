import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:flutter/material.dart';

class WorkoutActivityCard extends StatelessWidget {
  final WorkoutActivity activity;
  const WorkoutActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final Workout workout = activity.workout;
    return Column(
      children: [
        Row(children: [Text("Workout on ${activity.formatTimestamp()}")]),
      ],
    );
  }
}
