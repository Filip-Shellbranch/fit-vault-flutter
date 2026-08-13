import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/finalize_run/finish_run_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/graphs/run_elevation_graph.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/graphs/run_pace_graph.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/run_details.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/running_map.dart';
import 'package:flutter/material.dart';

class RunSummaryPage extends StatelessWidget {
  final Run run;
  const RunSummaryPage(this.run, {super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Run summary"),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FinishRunButton(isCurrent: true),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          spacing: 20,
          children: [
            RunDetails(run: run),
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: Scrollbar(
                  controller: controller,
                  thumbVisibility: true,
                  interactive: true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PageView(
                      controller: controller,
                      scrollDirection: Axis.vertical,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Center(
                                child: Text(
                                  "Well done! Scroll to view your stats.",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(10),
                                child: RunningMap(interactable: false),
                              ),
                            ),
                          ],
                        ),
                        RunPaceGraph(run: run),
                        RunElevationGraph(run: run),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
