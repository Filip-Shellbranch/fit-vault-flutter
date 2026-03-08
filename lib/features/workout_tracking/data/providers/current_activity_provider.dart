import 'package:fit_vault_flutter/features/workout_tracking/data/classes/activity.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/current_activity_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentActivityRepositoryProvider = Provider<CurrentActivityRepository>((
  ref,
) {
  return CurrentActivityRepository();
});

class CurrentActivityNotifier extends Notifier<Activity> {
  @override
  Activity build() {
    // Initialize the state from the repository
    return ref.watch(currentActivityRepositoryProvider).currentActivity;
  }

  void startWorkout() {
    final repository = ref.read(currentActivityRepositoryProvider);
    repository.startWorkout();

    state = repository.currentActivity; // Triggers UI rebuild
  }

  void stop() {
    ref.read(currentActivityRepositoryProvider).stopActivity();
    state = NoActivity();
  }
}

final currentActivityProvider =
    NotifierProvider<CurrentActivityNotifier, Activity>(() {
      return CurrentActivityNotifier();
    });
