import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';

sealed class Activity {}

class NoActivity extends Activity {}

class WorkoutActivity extends Activity {
  Workout activeWorkout;

  WorkoutActivity(this.activeWorkout);
}

//TODO: Implement runs

/*class RunActivity extends Activity {
  Run activeRun;

  RunActivity(this.activeRun)
}*/
