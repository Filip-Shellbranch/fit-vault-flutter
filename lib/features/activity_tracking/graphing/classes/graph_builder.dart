import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fl_chart/fl_chart.dart';

typedef GraphBuilder = List<FlSpot> Function(List<RunPoint>);
typedef TooltipBuilder = String Function(FlSpot);
typedef AxisTickBuilder = String Function(double);
