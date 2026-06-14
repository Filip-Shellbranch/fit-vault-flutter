import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/providers/workout_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_list_provider.g.dart';

@riverpod
class ActivityList extends _$ActivityList {
  @override
  List<Activity> build() {
    return List<Activity>.empty();
  }

  void loadActivityList(WidgetRef ref) async {
    final activities = List<Activity>.empty();

    final workoutsRepo = ref.watch(workoutRepositoryProvider);
    final workouts = await workoutsRepo.getAllWorkouts();
    activities.addAll(
      workouts.map((workout) => WorkoutActivity.fromWorkout(workout)),
    );

    //TODO: Add all runs to the activites list.

    //TODO: Sort activites based on timestamp.

    state = activities;
  }
}
