import 'package:fit_vault_flutter/features/activity_tracking/graphing/classes/graph_builder.dart';
import 'package:fit_vault_flutter/features/activity_tracking/graphing/widgets/stat_line_graph.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RunStatGraph extends StatelessWidget {
  const RunStatGraph({
    super.key,
    required this.run,
    required this.yTitle,
    required this.yUnit,
    required this.builder,
    this.toolTipBuilder,
    this.tickBuilder,
  });

  final Run run;
  final String yTitle;
  final String yUnit;
  final GraphBuilder builder;
  final TooltipBuilder? toolTipBuilder;
  final AxisTickBuilder? tickBuilder;

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = builder(run.positions);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          yTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        spots.length < 2
            ? Expanded(
                child: Center(
                  child: Text("Not enough points to graph this statistic."),
                ),
              )
            : AspectRatio(
                aspectRatio: 1,
                child: StatLineGraph(
                  spots: spots,
                  toolTipBuilder: toolTipBuilder,
                  tickBuilder: tickBuilder,
                  xTitle: "Distance",
                  xUnit: "km",
                  yTitle: yTitle,
                  yUnit: yUnit,
                ),
              ),
      ],
    );
  }
}
