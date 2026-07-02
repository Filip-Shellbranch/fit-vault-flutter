import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/grouped_activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/repositories/activity_group_controller.dart';

class RecentActivityRepository {
  final List<GroupedActivity> recentActivities;
  RecentActivityRepository(this.recentActivities);

  int countActivitiesInGroup(ActivityGroup targetGroup) {
    return recentActivities
        .where((GroupedActivity activity) => activity.group == targetGroup)
        .length;
  }
}
