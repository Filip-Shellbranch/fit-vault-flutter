import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/grouped_activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/repositories/activity_group_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/widgets/workout_activity_card.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class ActivityListDisplay extends StatelessWidget {
  final List<GroupedActivity> activities;
  const ActivityListDisplay({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return Text("No activities found!");
    }
    return GroupedListView(
      elements: activities,
      groupBy: (activity) => activity.group,
      groupComparator: (a, b) => b.index.compareTo(a.index),
      order: GroupedListOrder.DESC,
      groupSeparatorBuilder: (ActivityGroup group) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              labelFromGroup(group),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      itemBuilder: (context, groupedActivity) {
        switch (groupedActivity.activity) {
          case WorkoutActivity():
            return WorkoutActivityCard(
              activity: groupedActivity.activity as WorkoutActivity,
            );
        }
      },
    );
  }
}
