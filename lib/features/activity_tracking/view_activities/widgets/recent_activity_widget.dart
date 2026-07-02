import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/classes/grouped_activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/activity_list_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/repositories/activity_group_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/repositories/recent_activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityCountWidget extends StatelessWidget {
  final String text;
  final int count;
  const ActivityCountWidget({
    super.key,
    required this.text,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          count == 1 ? "Activity" : "Activities",
          style: TextStyle(fontSize: 14),
        ),
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class RecentActivityWidget extends ConsumerWidget {
  const RecentActivityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<GroupedActivity>? activityList;
    ref
        .watch(activityListProvider)
        .when(
          data: (updatedList) {
            activityList = updatedList;
          },
          error: (error, trace) {
            return Text(trace.toString());
          },
          loading: () {
            return CircularProgressIndicator();
          },
        );
    if (activityList == null) {
      return SizedBox();
    }
    final recentRepo = RecentActivityRepository(activityList!);
    final int lastWeek = recentRepo.countActivitiesInGroup(
      ActivityGroup.lastWeek,
    );
    final int thisWeek = recentRepo.countActivitiesInGroup(
      ActivityGroup.thisWeek,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActivityCountWidget(text: "Previous week", count: lastWeek),
                ActivityCountWidget(text: "This week", count: thisWeek),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
