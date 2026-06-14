import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/activity_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewActivitesPage extends StatefulWidget {
  const ViewActivitesPage({super.key});

  @override
  State<ViewActivitesPage> createState() => _ViewActivitesPageState();
}

class _ViewActivitesPageState extends State<ViewActivitesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Back"), foregroundColor: Colors.white),
      body: Consumer(
        builder: (context, ref, child) {
          final activityList = ref.watch(activityListProvider);
          return activityList.when(
            data: (activities) => Text(activities.length.toString()),
            error: (error, stackTrace) => Text("Error!"),
            loading: () => CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
