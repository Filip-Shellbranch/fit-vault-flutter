import 'package:fit_vault_flutter/features/activity_tracking/graphing/repositories/graphing_repository.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/pace.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/run_stat_graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RunPaceGraph extends StatelessWidget {
  final Run run;
  const RunPaceGraph({super.key, required this.run});

  String generateToolTip(FlSpot spot) {
    return Pace.fromMps(spot.y).asMinsPerKm();
  }

  String generateTick(double mps) {
    return Pace.fromMps(mps).asMinsPerKm();
  }

  @override
  Widget build(BuildContext context) {
    return RunStatGraph(
      run: run,
      yTitle: "Pace",
      yUnit: "min/km",
      builder: GraphRepository().paceGraph,
      toolTipBuilder: generateToolTip,
      tickBuilder: generateTick,
    );
  }
}
