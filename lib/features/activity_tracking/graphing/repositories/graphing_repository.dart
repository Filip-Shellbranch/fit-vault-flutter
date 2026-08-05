import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/pace.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphRepository {
  List<FlSpot> elevationGraph(List<RunPoint> points) {
    final List<FlSpot> spots = [];
    double currentX = 0;
    if (points.isEmpty) {
      return spots;
    }
    RunPoint lastPoint = points.first;
    for (RunPoint point in points.skip(1)) {
      if (point.type != PointType.active) {
        continue;
      }
      final spot = FlSpot(currentX, point.altitude);
      spots.add(spot);

      currentX += point.distanceTo(lastPoint);
      lastPoint = point;
    }
    return spots;
  }

  List<FlSpot> paceGraph(List<RunPoint> points) {
    final List<FlSpot> spots = [];
    double currentX = 0;
    if (points.isEmpty) {
      return spots;
    }
    RunPoint lastPoint = points.first;
    Pace? previousPace;
    for (RunPoint point in points.skip(1)) {
      if (point.type != PointType.active) {
        continue;
      }
      Pace? currentPace = point.pacebetween(lastPoint);
      currentPace ??= previousPace ?? Pace(0, Duration(seconds: 1));
      final spot = FlSpot(currentX, currentPace.metersPerSecond);
      spots.add(spot);

      currentX += point.distanceTo(lastPoint);
      lastPoint = point;
    }
    return spots;
  }
}
