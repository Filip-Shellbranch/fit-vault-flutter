import 'package:fit_vault_flutter/features/workout_tracking/data/classes/activity.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_activity_provider.dart';
import 'package:fit_vault_flutter/features/workout_tracking/views/edit_workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveWorkoutButton extends StatelessWidget {
  const SaveWorkoutButton({super.key});

  final SnackBar infoMessage = const SnackBar(
    content: Text("Workout tracking has not yet been implemented."),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return FloatingActionButton.extended(
          onPressed: () {
            ref.read(currentActivityProvider.notifier).stop();
            Navigator.pop(context);
          },
          heroTag: null,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icon(Icons.save),
          label: SizedBox(
            width: 200,
            child: Text("Save workout", style: TextStyle(fontSize: 26)),
          ),
        );
      },
    );
  }
}
