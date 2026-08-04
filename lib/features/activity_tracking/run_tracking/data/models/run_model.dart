import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/models/run_point_model.dart';
import 'package:isar_community/isar.dart';

part 'run_model.g.dart';

@collection
@Name("Run")
class RunModel {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  RunState state;

  DateTime startTime;
  DateTime? endTime;
  double distance;

  IsarLinks<RunPointModel> points = IsarLinks();

  int pausedDurationMillis = 0;

  @ignore
  Duration get pausedDuration {
    return Duration(milliseconds: pausedDurationMillis);
  }

  set pausedDuration(Duration value) =>
      pausedDurationMillis = value.inMilliseconds;

  RunModel(
    this.startTime, {
    this.endTime,
    Duration pausedDuration = Duration.zero,
    this.distance = 0.0,
    this.state = RunState.completed,
  }) {
    this.pausedDuration = pausedDuration;
  }

  factory RunModel.fromRun(Run run) {
    final model = RunModel(
      run.startTime,
      distance: run.distance,
      state: run.state,
      endTime: run.endTime,
    );
    model.pausedDuration = run.pausedDuration;
    model.id = run.id ?? Isar.autoIncrement;
    return model;
  }

  Duration calculateDuration() {
    final DateTime? end = endTime;
    if (state != RunState.completed || end == null) {
      return Duration.zero;
    }
    return end.subtract(pausedDuration).difference(startTime);
  }
}

/*@embedded
class RunPointModel {
  double? lat;
  double? lng;
  double? altitude;

  @Enumerated(EnumType.name)
  PointType type;

  RunPointModel({
    this.lat = 0,
    this.lng = 0,
    this.altitude = 0,
    this.type = PointType.active,
  });

  factory RunPointModel.fromRunPoint(RunPoint point) {
    final model = RunPointModel(
      lat: point.lat,
      lng: point.lng,
      altitude: point.altitude,
      type: point.type,
    );
    return model;
  }
}
*/
