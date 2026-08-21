import 'dart:collection';
import 'dart:math';

import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/pace.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fl_chart/fl_chart.dart';

typedef GraphFunc = double? Function(RunPoint, List<RunPoint>);

class GraphRepository {
  void _removeOutliers(
    List<FlSpot> spots, {
    double threshold = 0.75,
    int rollingCount = 30,
  }) {
    int i = 0;
    int start = i;
    int end = min(spots.length, rollingCount);
    final rolling = Queue<FlSpot>.from(spots.getRange(start, end));

    for (FlSpot spot in spots) {
      final newStart = max(0, i - rollingCount);
      final newEnd = min(spots.length, i + rollingCount);

      if (newEnd < end) {
        rolling.add(spots[newEnd]);
        end++;
      }
      if (newStart > start) {
        rolling.removeFirst();
        start++;
      }

      if (rolling.isEmpty) {
        end--;
        continue;
      }
      double mean =
          rolling.fold(0.0, (currentSum, b) => currentSum + b.y) /
          rolling.length;

      // Calculate the variance
      double variance =
          rolling.map((x) => pow(x.y - mean, 2)).reduce((a, b) => a + b) /
          (rolling.length - 1);

      // Calculate the standard deviation
      double standardDeviation = sqrt(variance);

      double outlierCoefficient = ((spot.y - mean).abs()) / standardDeviation;
      if (outlierCoefficient > threshold) {
        // Replace the y value with the average of surrounding values.
        spots[i] = FlSpot(spot.x, mean);
      }
      dPrint(spot.y.toString());
      if (start == i) {
        dPrint(spot.y.toString());
      }
      i++;
    }
  }

  List<FlSpot> _generateGraph(
    List<RunPoint> points,
    GraphFunc calcY, {
    int previousSamples = 0,
    bool trimOutliers = false,
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

    if (spots.length > 1 && trimOutliers) {
      _removeOutliers(spots);
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
      return -currentPace.metersPerSecond;
    }

    return _generateGraph(
      points,
      calcPace,
      previousSamples: 80,
      trimOutliers: true,
    );
  }

  List<FlSpot> elevationGraph(List<RunPoint> points) {
    double? getElevation(RunPoint point, List<RunPoint> previousPoints) {
      return point.altitude - 30;
    }

    return _generateGraph(points, getElevation, previousSamples: 20);
  }
}
