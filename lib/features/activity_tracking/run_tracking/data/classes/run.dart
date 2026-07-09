import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';

enum RunState { active, paused, complete }

class Run {
  int? id;
  final DateTime startTime;
  DateTime? endTime;
  RunState state = RunState.active;
  List<RunPoint> positions = [];

  Duration pausedDuration = Duration.zero;
  DateTime? pausedAt;
  Run(this.startTime);

  Duration calculateDuration() {
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
    int hours = (duration.inMinutes / 60).floor();
    int minutes = (duration.inMinutes - 60 * hours);
    if (hours == 0) {
      if (minutes == 0) {
        return "<1 min";
      }
      return "$minutes min";
    } else {
      return "$hours h $minutes min";
    }
  }

  bool isActive() {
    return state == RunState.active;
  }

  bool isPaused() {
    return state == RunState.paused;
  }

  Run copy() {
    Run newRun = Run(startTime);
    newRun.pausedDuration = pausedDuration;
    newRun.pausedAt = pausedAt;
    newRun.endTime = endTime;
    newRun.id = id;
    newRun.positions = List.from(positions);
    return newRun;
  }
}
