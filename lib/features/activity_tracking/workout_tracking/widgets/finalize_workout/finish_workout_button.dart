import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/providers/workout_repository_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/repositories/activity_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/deletion_confirm_dialog.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/finalize_workout/discard_workout_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/finalize_workout/save_workout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinishWorkoutButton extends ConsumerWidget {
  const FinishWorkoutButton({super.key});

  void onSavePressed(BuildContext context, WidgetRef ref) async {
    Workout currentWorkout = ref.read(currentWorkoutProvider);
    ActivityController(ref).stop();
    await ref.read(workoutRepositoryProvider).saveWorkout(currentWorkout);
    if (context.mounted) {
      Navigator.popUntil(context, ModalRoute.withName("/"));
    }
  }

  void onDiscardPressed(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return DeletionConfirmDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: PopupMenuButton<String>(
        color: Theme.of(context).secondaryHeaderColor, // Popup background
        onSelected: (value) {
          switch (value) {
            case "Save":
              onSavePressed(context, ref);
              break;
            case "Discard":
              onDiscardPressed(context, ref);
              break;
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor, // Open menu button color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.center,
            child: const Text(
              "Finish workout",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(child: Text("What would you like to do?")),
          PopupMenuItem(
            value: "Save",
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SaveWorkoutButton(fgColor: Colors.white),
              ),
            ),
          ),
          PopupMenuItem(
            value: "Discard",
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DiscardWorkoutButton(fgColor: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
