import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_activity_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/activity_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityController {
  final Ref ref;

  ActivityController(this.ref);

  /// This function is the one used in the UI to start a new workout.
  Future<void> startWorkout() async {
    await ref.read(currentWorkoutProvider.notifier).startWorkout();
    ref.read(currentActivityProvider.notifier).startWorkout();
    // TODO: Remove currentRun if any
  }

  /// The stop function only marks the current activity as none because there
  /// is no need to also remove the Workout/Run from the respective providers.
  void stop() {
    ref.read(currentActivityProvider.notifier).stop();
    ref.read(activityListProvider.notifier).updateList();
  }

  Future<void> startRun() async {
    bool success = await ref.read(currentRunProvider.notifier).startRun();
    debugPrint("success?");
    debugPrint(success.toString());
    if (success) {
      ref.read(currentActivityProvider.notifier).startRun();
    }
    // TODO: Remove currentWorkout if any
  }
}
