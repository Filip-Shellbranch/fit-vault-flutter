import 'dart:math';

import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/pace.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fl_chart/fl_chart.dart';

typedef GraphFunc = double? Function(RunPoint, List<RunPoint>);

class GraphRepository {
  void _removeOutliers(List<FlSpot> spots, {double threshold = 3}) {
    double mean =
        spots.fold(0.0, (currentSum, b) => currentSum + b.y) / spots.length;

    // Calculate the variance
    double variance =
        spots.map((x) => pow(x.y - mean, 2)).reduce((a, b) => a + b) /
        (spots.length - 1);

    // Calculate the standard deviation
    double standardDeviation = sqrt(variance);
    if (standardDeviation != 0) {
      double lastUsableValue = mean;
      int i = 0;
      int numOutliers = 0;
      for (FlSpot spot in spots) {
        double outlierCoefficient = ((spot.y - mean).abs()) / standardDeviation;
        if (outlierCoefficient > threshold) {
          // Replace the y value with most recent usable value.
          // TODO: Instead replace with average of surrounding values.
          spots[i] = FlSpot(spot.x, lastUsableValue);
          numOutliers++;
        } else {
          lastUsableValue = spot.y;
        }
        i++;
      }
      dPrint("Removed $numOutliers outliers from ${spots.length} points.");
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
