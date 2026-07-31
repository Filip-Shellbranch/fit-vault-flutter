import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/run_stat_widget.dart';
import 'package:flutter/material.dart';

class RunDetails extends StatelessWidget {
  final Run run;
  const RunDetails({super.key, required this.run});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RunStatWidget("Duration", run.formatDuration()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: RunStatWidget(
                    "Distance",
                    run.formatDistance(),
                    unit: "km",
                  ),
                ),
                Expanded(
                  child: RunStatWidget(
                    "Avg Pace",
                    run.formatPace(),
                    unit: "min/km",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
