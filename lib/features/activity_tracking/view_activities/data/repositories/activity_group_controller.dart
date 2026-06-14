import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/grouped_activity.dart';

class ActivityGroupController {
  String _calculateGroup(Activity activity) {
    final timestamp = activity.timestamp;
    final today = DateTime.now();
    final weekstart = today.subtract(Duration(days: today.weekday - 1));
    //if (timestamp.)
    return "lol";
  }

  GroupedActivity _assignDisplayGroup(Activity activity) {
    return GroupedActivity(_calculateGroup(activity), activity);
  }

  List<GroupedActivity> groupActivites(List<Activity> activities) {
    return activities.map((activity) => _assignDisplayGroup(activity)).toList();
  }
}
