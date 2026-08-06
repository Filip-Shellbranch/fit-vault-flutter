import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/pace.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fl_chart/fl_chart.dart';

typedef GraphFunc = double? Function(RunPoint, List<RunPoint>);

class GraphRepository {
  List<FlSpot> _generateGraph(
    List<RunPoint> points,
    GraphFunc calcY, {
    int previousSamples = 0,
  }) {
    final List<FlSpot> spots = [];
    double currentX = 0;
    if (points.length < 2) {
      return spots;
    }

    final List<RunPoint> previousPoints = [points.first];
    final List<double> previousValues = [];

    for (RunPoint point in points.skip(1)) {
      if (point.type == PointType.resume) {
        previousValues.clear();
        previousPoints.clear();
        previousPoints.add(point);
        continue;
      }
      //Calculate the new Y based on previous points.
      double? y = calcY(point, previousPoints);
      dPrint(point.type.toString());
      dPrint(y.toString());
      if (y != null && y.isFinite) {
        double sum = previousValues.fold(
          y,
          (a, b) => a + b,
        ); // Equals y if previousValues is empty
        double smoothedY = sum / (1 + previousValues.length);

        final spot = FlSpot(currentX, smoothedY);
        spots.add(spot);

        if (previousSamples > 0) {
          previousValues.add(y);
          if (previousValues.length > previousSamples) {
            previousValues.removeAt(0);
          }
        }
      } else {
        previousValues.clear();
      }

      currentX += point.distanceTo(previousPoints.last);
      previousPoints.add(point);
    }

    return spots;
  }

  List<FlSpot> paceGraph(List<RunPoint> points) {
    double? calcPace(RunPoint point, List<RunPoint> previousPoints) {
      if (previousPoints.isEmpty) {
        return null;
      }
      Pace? currentPace = point.pacebetween(previousPoints.last);
      if (currentPace == null || currentPace.metersPerSecond == 0) {
        return null;
      }
      return currentPace.metersPerSecond;
    }

    return _generateGraph(points, calcPace, previousSamples: 5);
  }

  List<FlSpot> elevationGraph(List<RunPoint> points) {
    double? getElevation(RunPoint point, List<RunPoint> previousPoints) {
      return point.altitude;
    }

    return _generateGraph(points, getElevation, previousSamples: 10);
  }
}
