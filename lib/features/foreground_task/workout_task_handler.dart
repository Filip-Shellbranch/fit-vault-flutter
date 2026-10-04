import 'dart:async';

import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/repositories/workout_repository.dart';
import 'package:fit_vault_flutter/features/foreground_task/notification_service.dart';
import 'package:isar_community/isar.dart';

class WorkoutTaskHandler {
  late final WorkoutRepository workoutRepository;
  final NotificationService notif = NotificationService();
  Timer? _secondTimer;
  Workout? _activeWorkout;

  bool isInitialized = false;

  Future<void> init(Isar db) async {
    workoutRepository = WorkoutRepository(db);
    isInitialized = true;

    Workout? currentWorkout = await workoutRepository.loadCurrentWorkout();
    if (currentWorkout != null) {
      _activeWorkout = currentWorkout;
      _beginNotificationUpdates();
    }
  }

  void _beginNotificationUpdates() {
    if (_secondTimer != null) {
      return;
    }
    _secondTimer = Timer.periodic(Duration(seconds: 1), (_) {
      Workout? workout = _activeWorkout;
      if (workout == null) {
        _secondTimer?.cancel();
        _secondTimer = null;
      } else {
        notif.updateWorkoutNotification(workout);
      }
    });
  }

  void startWorkout() async {
    Workout? currentWorkout = await workoutRepository.loadCurrentWorkout();
    if (currentWorkout != null) {
      _activeWorkout = currentWorkout;
      _beginNotificationUpdates();
    }
  }
}
