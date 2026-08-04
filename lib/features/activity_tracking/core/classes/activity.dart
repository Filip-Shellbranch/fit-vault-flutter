import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_summary.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';

sealed class Activity {
  final DateTime timestamp;
  Activity(this.timestamp);

  String formatTimestamp() {
    return formatDate(timestamp);
  }
}

class WorkoutActivity extends Activity {
  final Workout workout;
  WorkoutActivity(super.timestamp, this.workout);
  WorkoutActivity.fromWorkout(Workout workout)
    : this(workout.startTime, workout);
}

class RunActivity extends Activity {
  RunSummary summary;
  RunActivity(super.timestamp, this.summary);
  RunActivity.fromRunSummary(RunSummary summary)
    : this(summary.startTime, summary);
}
