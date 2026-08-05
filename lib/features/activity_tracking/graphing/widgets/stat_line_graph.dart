import 'package:fit_vault_flutter/features/activity_tracking/graphing/classes/graph_builder.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

String defaultToolTip(FlSpot spot) {
  return spot.y.toString();
}

String defaultTick(double value) {
  return value.round().toString();
}

class StatLineGraph extends StatelessWidget {
  const StatLineGraph({
    super.key,
    required this.spots,
    required this.xTitle,
    required this.yTitle,
    this.xUnit,
    this.yUnit,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.linear,
    TooltipBuilder? toolTipBuilder,
    AxisTickBuilder? tickBuilder,
  }) : toolTipBuilder = toolTipBuilder ?? defaultToolTip,
       tickBuilder = tickBuilder ?? defaultTick;

  final TooltipBuilder toolTipBuilder;
  final AxisTickBuilder tickBuilder;
  final List<FlSpot> spots;

  final String xTitle;
  final String yTitle;

  final String? xUnit;
  final String? yUnit;

  final Duration duration;
  final Curve curve;

  String _axisLabel(String title, String? unit) {
    if (unit == null || unit.isEmpty) return title;
    return '$title ($unit)';
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) => spots
                .map(
                  (spot) => LineTooltipItem(
                    toolTipBuilder(spot),
                    const TextStyle(color: Colors.white),
                  ),
                )
                .toList(),
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            axisNameSize: 32,
            axisNameWidget: Text(_axisLabel(xTitle, xUnit)),
          ),
          leftTitles: AxisTitles(
            axisNameSize: 32,
            axisNameWidget: Text(_axisLabel(yTitle, yUnit)),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              minIncluded: false,
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) => Text(tickBuilder(value)),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 32),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            color: Theme.of(context).primaryColor,
            barWidth: 3,
            isCurved: false,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
      duration: duration,
      curve: curve,
    );
  }
}
