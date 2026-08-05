import 'package:fit_vault_flutter/features/activity_tracking/graphing/repositories/graphing_repository.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/run_stat_graph.dart';
import 'package:flutter/material.dart';

class RunElevationGraph extends StatelessWidget {
  final Run run;
  const RunElevationGraph({super.key, required this.run});

  @override
  Widget build(BuildContext context) {
    return RunStatGraph(
      run: run,
      yTitle: "Elevation",
      yUnit: "m",
      builder: GraphRepository().elevationGraph,
    );
  }
}
