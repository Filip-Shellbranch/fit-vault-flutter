import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/activity_list_provider.dart';
import 'package:fit_vault_flutter/features/foreground_task/foreground_service_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityController {
  final Ref ref;
  final ForegroundServiceController fgController =
      ForegroundServiceController();

  ActivityController(this.ref);

  Future<void> ensureForegroundStarted() async {
    if (await fgController.isRunning()) {
      dInfo("Foreground service already running, restarting it.");
      await fgController.stopService();
    }
    await fgController.startService();
  }

  /// This function is the one used in the UI to start a new workout.
  Future<void> startWorkout() async {
    await ensureForegroundStarted();
    await ref.read(currentWorkoutProvider.notifier).startWorkout();
    ref.read(currentRunProvider.notifier).clearRun();
  }

  Future<void> stop() async {
    await ref.read(activityListProvider.notifier).updateList();
    await ref.read(currentRunProvider.notifier).clearRun();
    ref.read(currentWorkoutProvider.notifier).stopWorkout();
    await fgController.stopService();
  }

  Future<void> startRun() async {
    await ensureForegroundStarted();
    ref.read(currentWorkoutProvider.notifier).stopWorkout();
    ref.read(currentRunProvider.notifier).startRun();
  }
}
