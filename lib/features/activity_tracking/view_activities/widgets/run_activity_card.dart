import 'package:fit_vault_flutter/features/activity_tracking/core/classes/activity.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/views/view_run_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityInfoDisplay extends StatelessWidget {
  final String title;
  final String displayedInfo;
  const ActivityInfoDisplay({
    super.key,
    required this.title,
    required this.displayedInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 18)),
        Text(
          displayedInfo,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }
}

class RunActivityCard extends ConsumerWidget {
  final RunActivity activity;
  Run get run => activity.run;

  const RunActivityCard({super.key, required this.activity});

  void openRun(BuildContext context, WidgetRef ref) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewRunPage(run: run)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).primaryColor, width: 4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImageIcon(
                        AssetImage("assets/icons/icons8-running-100.png"),
                        size: 40,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Run on"),
                        Text(
                          activity.formatTimestamp(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActivityInfoDisplay(
                      title: "Duration",
                      displayedInfo: run.formatDuration(),
                    ),
                    ActivityInfoDisplay(
                      title: "Distance",
                      displayedInfo: "${run.formatDistance()} km",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActivityInfoDisplay(
                      title: "Pace",
                      displayedInfo: "${run.formatPace()} min/km",
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                openRun(context, ref);
              },
              child: SizedBox(
                height: 80,
                child: Icon(Icons.arrow_forward_rounded, size: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
