import 'package:fit_vault_flutter/core/widgets/confirm_dialog.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/edited_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/providers/workout_repository_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/repositories/activity_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/finalize_workout/discard_workout_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/finalize_workout/save_workout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> deleteCurrentWorkout(WidgetRef ref) async {
  Workout? currentWorkout = ref.read(currentWorkoutProvider).value;
  if (currentWorkout == null) {
    return;
  }
  int? id = currentWorkout.id;
  if (id != null) {
    await ref.read(workoutRepositoryProvider).deleteWorkoutById(id);
  }
}

class FinishWorkoutButton extends ConsumerWidget {
  final bool isCurrentWorkout;
  const FinishWorkoutButton({super.key, required this.isCurrentWorkout});

  void onSavePressed(BuildContext context, WidgetRef ref) async {
    late Workout workoutToSave;
    if (isCurrentWorkout) {
      Workout? loadedValue = ref.read(currentWorkoutProvider).value;
      if (loadedValue == null) {
        return;
      }
      workoutToSave = loadedValue;
    } else {
      workoutToSave = ref.read(editedWorkoutProvider);
    }
    ActivityController(ref).stop();
    await ref
        .read(workoutRepositoryProvider)
        .saveWorkout(workoutToSave, isCompleted: true);
    if (context.mounted) {
      Navigator.popUntil(context, ModalRoute.withName("/"));
    }
  }

  void onDiscardPressed(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          onConfirmFunc: () async {
            if (isCurrentWorkout) {
              await deleteCurrentWorkout(ref);
            }

            ActivityController(ref).stop();
            if (context.mounted) {
              Navigator.popUntil(context, ModalRoute.withName("/"));
            }
          },
          prompt: "Are you sure you want to discard the workout?",
        );
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
            child: Text(
              isCurrentWorkout ? "Finish workout" : "Finish editing",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text(
              isCurrentWorkout
                  ? "What would you like to do?"
                  : "Do you want to save your changes?",
            ),
          ),
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
