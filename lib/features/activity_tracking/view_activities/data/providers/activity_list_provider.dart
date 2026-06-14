import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/grouped_activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/repositories/activity_group_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/providers/workout_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_list_provider.g.dart';

@riverpod
class ActivityList extends _$ActivityList {
  @override
  Future<List<GroupedActivity>> build() async {
    return _loadActivityList();
  }

  Future<List<GroupedActivity>> _loadActivityList() async {
    final activities = List<Activity>.empty(growable: true);

    final workoutsRepo = ref.read(workoutRepositoryProvider);
    final workouts = await workoutsRepo.getAllWorkouts();
    activities.addAll(
      workouts.map((workout) => WorkoutActivity.fromWorkout(workout)),
    );

    //TODO: Add all runs to the activites list.

    //TODO: Sort activites based on timestamp.

    final groupController = ActivityGroupController();
    final groupedActivities = groupController.groupActivites(activities);

    return groupedActivities;
  }
}
