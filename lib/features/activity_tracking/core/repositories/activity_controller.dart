import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/activity_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityController {
  final Ref ref;

  ActivityController(this.ref);

  /// This function is the one used in the UI to start a new workout.
  Future<void> startWorkout() async {
    await ref.read(currentWorkoutProvider.notifier).startWorkout();
    ref.read(currentRunProvider.notifier).clearRun();
  }

  Future<void> stop() async {
    await ref.read(activityListProvider.notifier).updateList();
    await ref.read(currentRunProvider.notifier).clearRun();
    ref.read(currentWorkoutProvider.notifier).stopWorkout();
  }

  Future<void> startRun() async {
    ref.read(currentWorkoutProvider.notifier).stopWorkout();
    await ref.read(currentRunProvider.notifier).startRun();
  }
}
