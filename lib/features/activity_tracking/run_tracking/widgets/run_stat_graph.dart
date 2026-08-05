import 'package:fit_vault_flutter/features/activity_tracking/graphing/classes/graph_builder.dart';
import 'package:fit_vault_flutter/features/activity_tracking/graphing/widgets/stat_line_graph.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 0),
            child: Text(
              yTitle,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: StatLineGraph(
                spots: builder(run.positions),
                toolTipBuilder: toolTipBuilder,
                tickBuilder: tickBuilder,
                xTitle: "Distance",
                xUnit: "km",
                yTitle: yTitle,
                yUnit: yUnit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
