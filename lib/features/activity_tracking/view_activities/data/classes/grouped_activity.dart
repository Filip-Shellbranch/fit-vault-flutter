import 'package:fit_vault_flutter/features/activity_tracking/core/classes/activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/repositories/activity_group_controller.dart';

class GroupedActivity {
  final ActivityGroup group;
  final Activity activity;
  GroupedActivity(this.group, this.activity);
}
