import 'package:fit_vault_flutter/features/workout_tracking/data/classes/activity.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';

class CurrentActivityRepository {
  Activity _currentActivity = NoActivity();

  Activity get currentActivity => _currentActivity;

  void startWorkout() {
    _currentActivity = WorkoutActivity(Workout(DateTime.now()));
  }

  void stopActivity() {
    _currentActivity = NoActivity();
  }
}
