import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_activity_provider.dart';
import 'package:fit_vault_flutter/features/workout_tracking/views/edit_workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContinueActivityButton extends StatefulWidget {
  const ContinueActivityButton({super.key});

  @override
  State<ContinueActivityButton> createState() => _ContinueActivityButtonState();
}

class _ContinueActivityButtonState extends State<ContinueActivityButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ActivityType currentActivity = ref.watch(currentActivityProvider);
        return FloatingActionButton.extended(
          onPressed: () {
            if (currentActivity.isWorkout()) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditWorkoutPage()),
              );
            }
          },
          heroTag: null,
          backgroundColor: Colors.green,
          icon: Icon(Icons.edit, size: 32),
          label: Text(
            style: TextStyle(fontSize: 22),
            currentActivity.isWorkout()
                ? "Continue workout"
                : "Error unknown activity",
          ),
        );
      },
    );
  }
}
