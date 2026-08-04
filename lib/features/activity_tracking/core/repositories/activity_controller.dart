import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_activity_provider.dart';
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
    ref.read(currentRunProvider.notifier).stopRun();
  }

  void stop() {
    ref.read(activityListProvider.notifier).updateList();
    ref.read(currentRunProvider.notifier).stopRun();
    ref.read(currentWorkoutProvider.notifier).stopWorkout();
    ref.read(currentActivityProvider.notifier).stop();
  }

  Future<void> startRun() async {
    ref.read(currentWorkoutProvider.notifier).stopWorkout();
    await ref.read(currentRunProvider.notifier).startRun();
  }
}
