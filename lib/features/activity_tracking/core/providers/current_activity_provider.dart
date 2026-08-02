import 'package:fit_vault_flutter/core/utils/debug.dart';
import 'package:fit_vault_flutter/core/utils/logging/app_logger.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_workout_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_activity_provider.g.dart';

enum ActivityType { none, workout, run }

extension ActivityTypeChecks on ActivityType {
  bool isWorkout() {
    return this == ActivityType.workout;
  }

  bool isRun() {
    return this == ActivityType.run;
  }

  bool isNone() {
    return this == ActivityType.none;
  }
}

@riverpod
class CurrentActivity extends _$CurrentActivity {
  @override
  ActivityType build() {
    if (ref.watch(currentWorkoutProvider).value != null) {
      dPrint("Current Activity: Workout");
      return ActivityType.workout;
    } else if (ref.watch(currentRunProvider).value != null) {
      dPrint("Current Activity: Run");
      return ActivityType.run;
    }
    dPrint("Current Activity: None");
    return ActivityType.none;
  }

  void stop() => state = ActivityType.none;
}
