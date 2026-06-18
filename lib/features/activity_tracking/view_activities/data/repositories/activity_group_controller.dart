import 'package:fit_vault_flutter/features/activity_tracking/core/classes/activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/grouped_activity.dart';

enum ActivityGroup { thisWeek, lastWeek, earlier }

String labelFromGroup(ActivityGroup group) {
  switch (group) {
    case ActivityGroup.thisWeek:
      return "This week";
    case ActivityGroup.lastWeek:
      return "Last week";
    case ActivityGroup.earlier:
      return "Earlier";
  }
}

class ActivityGroupController {
  ActivityGroup calculateGroup(DateTime timestamp, DateTime today) {
    final todayWithoutHM = DateTime(today.year, today.month, today.day);
    final weekStart = todayWithoutHM.subtract(
      Duration(days: today.weekday - 1),
    );
    if (timestamp.isAfter(weekStart) || timestamp.isAtSameMomentAs(weekStart)) {
      return ActivityGroup.thisWeek;
    }
    final lastWeekStart = weekStart.subtract(Duration(days: 7));
    if (timestamp.isAfter(lastWeekStart) ||
        timestamp.isAtSameMomentAs(lastWeekStart)) {
      return ActivityGroup.lastWeek;
    }
    return ActivityGroup.earlier;
  }

  GroupedActivity assignDisplayGroup(Activity activity) {
    return GroupedActivity(
      calculateGroup(activity.timestamp, DateTime.now()),
      activity,
    );
  }

  List<GroupedActivity> groupActivites(List<Activity> activities) {
    return activities.map((activity) => assignDisplayGroup(activity)).toList();
  }
}
