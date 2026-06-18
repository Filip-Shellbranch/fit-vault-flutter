import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:intl/intl.dart';

sealed class Activity {
  final DateTime timestamp;
  Activity(this.timestamp);

  String formatTimestamp() {
    final formatted = DateFormat('dd MMM yyyy HH:mm').format(timestamp);
    return formatted;
  }
}

class WorkoutActivity extends Activity {
  final Workout workout;

  WorkoutActivity(super.timestamp, this.workout);

  WorkoutActivity.fromWorkout(Workout workout)
    : this(workout.startTime, workout);
}

//TODO: Create RunActivity
/*class RunActivity extends Activity {
  //Workout workout;
  //WorkoutActivity(this.workout)
}
*/
