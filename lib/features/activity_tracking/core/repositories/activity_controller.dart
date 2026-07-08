import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_activity_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/activity_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityController {
  final WidgetRef ref;

  ActivityController(this.ref);

  /// This function is the one used in the UI to start a new workout.
  Future<void> startWorkout() async {
    await ref.watch(currentWorkoutProvider.notifier).startWorkout();
    ref.watch(currentActivityProvider.notifier).startWorkout();
    // TODO: Remove currentRun if any
  }

  /// The stop function only marks the current activity as none because there
  /// is no need to also remove the Workout/Run from the respective providers.
  void stop() {
    ref.watch(currentActivityProvider.notifier).stop();
    ref.watch(activityListProvider.notifier).updateList();
  }

  Future<void> startRun() async {
    bool success = await ref.watch(currentRunProvider.notifier).startRun();
    if (success) {
      ref.watch(currentActivityProvider.notifier).startRun();
    }
    // TODO: Remove currentWorkout if any
  }
}
