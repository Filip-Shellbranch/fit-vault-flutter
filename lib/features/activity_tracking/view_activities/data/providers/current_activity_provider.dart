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
  ActivityType build() => ActivityType.none;

  void startWorkout() => state = ActivityType.workout;
  void startRun() => state = ActivityType.run;
  void stop() => state = ActivityType.none;
}
