import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:isar_community/isar.dart';

part 'run_point_model.g.dart';

@collection
@Name("RunPoint")
class RunPointModel {
  Id id = Isar.autoIncrement;

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
