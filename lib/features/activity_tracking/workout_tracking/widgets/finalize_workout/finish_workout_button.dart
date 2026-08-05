import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/activity_controller_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/edited_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/widgets/finish_activity_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/providers/workout_repository_provider.dart';
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

class FinishWorkoutButton extends StatelessWidget {
  final bool isCurrent;
  const FinishWorkoutButton({super.key, this.isCurrent = false});

  Future<void> saveFunc(BuildContext context, WidgetRef ref) async {
    late Workout workoutToSave;
    if (isCurrent) {
      Workout? currentWorkout = ref.read(currentWorkoutProvider).value;
      if (currentWorkout == null) {
        dWarn("Attempting to save when current workout is null");
        return;
      }
      workoutToSave = currentWorkout;
    } else {
      workoutToSave = ref.read(editedWorkoutProvider);
    }
    await ref
        .read(workoutRepositoryProvider)
        .saveWorkout(workoutToSave, isCompleted: true);
  }

  Future<void> discardFunc(BuildContext context, WidgetRef ref) async {
    if (isCurrent) {
      await deleteCurrentWorkout(ref);
      await ref.read(activityControllerProvider).stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FinishActivityButton(
      activityName: "workout",
      saveFunc: saveFunc,
      discardFunc: discardFunc,
    );
  }
}
