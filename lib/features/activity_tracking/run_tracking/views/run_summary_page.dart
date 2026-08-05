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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FinishRunButton(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          spacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Run completed, well done!",
                style: TextStyle(fontSize: 30),
              ),
            ),
            RunDetails(run: run),
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: Scrollbar(
                  thumbVisibility: true,
                  interactive: true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(15),
                            child: IgnorePointer(
                              child: SizedBox(
                                height: 350,
                                width: double.infinity,
                                child: RunningMap(),
                              ),
                            ),
                          ),
                          RunPaceGraph(run: run),
                          RunElevationGraph(run: run),
                        ],
                      ),
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
