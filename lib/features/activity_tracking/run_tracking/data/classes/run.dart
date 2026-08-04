import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/pace.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/models/run_model.dart';

enum RunState { notStarted, active, paused, completed }

class Run {
  int? id;
  DateTime startTime;
  DateTime? endTime;
  RunState state;
  List<RunPoint> positions = [];

  double _distance; // In kilometers.
  double get distance {
    return _distance;
  }

  Duration pausedDuration = Duration.zero;
  DateTime? pausedAt;
  Run(
    this.startTime, {
    this.state = RunState.completed,
    double startingDistance = 0,
  }) : _distance = startingDistance;

  factory Run.newRun() {
    Run newRun = Run(DateTime.now(), state: RunState.notStarted);
    return newRun;
  }

  factory Run.fromModel(RunModel model) {
    final run = Run(model.startTime);
    run.startTime = model.startTime;
    run.id = model.id;
    run.state = model.state;
    run.endTime = model.endTime;
    run.pausedDuration = model.pausedDuration;

    return run;
  }

  double addPoint(RunPoint newPoint) {
    double segmentLength = 0;
    if (positions.isEmpty) {
      _distance = 0;
    } else {
      RunPoint previousPoint = positions.last;
      segmentLength = previousPoint.distanceTo(newPoint);
      _distance += segmentLength;
    }
    positions.add(newPoint);
    return segmentLength;
  }

  String formatDistance() {
    return distance.toStringAsFixed(2);
  }

  Pace calculatePace() {
    return Pace(distance, calculateDuration());
  }

  String formatPace() {
    return calculatePace().asMinsPerKm();
  }

  Duration calculateDuration() {
    if (isStarted() == false) {
      return Duration.zero;
    }
    if (endTime == null) {
      if (isPaused()) {
        return pausedAt!.subtract(pausedDuration).difference(startTime);
      } else {
        return DateTime.now().subtract(pausedDuration).difference(startTime);
      }
    } else {
      return endTime!.subtract(pausedDuration).difference(startTime);
    }
  }

  String formatDuration() {
    Duration duration = calculateDuration();
    return formatDurationHMS(duration);
  }

  bool isStarted() {
    return state != RunState.notStarted;
  }

  bool isActive() {
    return state == RunState.active;
  }

  bool isPaused() {
    return state == RunState.paused;
  }

  Run copy() {
    Run newRun = Run(startTime, startingDistance: _distance, state: state);
    newRun.pausedDuration = pausedDuration;
    newRun.pausedAt = pausedAt;
    newRun.endTime = endTime;
    newRun.id = id;
    newRun.positions = List.from(positions);
    return newRun;
  }
}
