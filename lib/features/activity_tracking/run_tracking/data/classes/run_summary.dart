import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/pace.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/models/run_model.dart';

class RunSummary {
  final int id;
  final DateTime startTime;
  final double distance;
  final Duration duration;

  RunSummary(this.id, this.startTime, this.distance, this.duration);

  factory RunSummary.fromRunModel(RunModel model) {
    return RunSummary(
      model.id,
      model.startTime,
      model.distance,
      model.calculateDuration(),
    );
  }

  String formatDistance() {
    return distance.toStringAsFixed(2);
  }

  Pace calculatePace() {
    return Pace(distance, duration);
  }

  String formatPace() {
    return calculatePace().asMinsPerKm();
  }

  String formatDuration() {
    return formatDurationHMS(duration);
  }
}
