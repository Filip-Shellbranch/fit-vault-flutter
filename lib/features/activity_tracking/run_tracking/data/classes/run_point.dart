import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/pace.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/models/run_point_model.dart';
import 'package:latlong2/latlong.dart';

enum PointType { start, pause, resume, active, end }

class RunPoint {
  final double lat;
  final double lng;
  final double altitude;
  final DateTime? time;
  final PointType type;

  RunPoint(
    this.lat,
    this.lng,
    this.time, {
    this.type = PointType.active,
    this.altitude = 0.0,
  });

  factory RunPoint.fromModel(RunPointModel model) {
    final point = RunPoint(
      model.lat ?? 0,
      model.lng ?? 0,
      model.time,
      altitude: model.altitude ?? 0,
      type: model.type,
    );
    return point;
  }

  double distanceTo(RunPoint otherPoint) {
    LatLng p1 = getLatLng();
    LatLng p2 = otherPoint.getLatLng();
    double distance = DistanceVincenty(
      roundResult: false,
    ).as(LengthUnit.Kilometer, p1, p2);
    if (!distance.isFinite) {
      return 0;
    }
    return distance;
  }

  Pace? pacebetween(RunPoint otherPoint) {
    DateTime? t1 = time;
    DateTime? t2 = otherPoint.time;
    if (t1 == null || t2 == null) {
      return null;
    }

    Duration duration = t1.difference(t2).abs();
    double distance = distanceTo(otherPoint);
    return Pace(distance, duration);
  }

  LatLng getLatLng() {
    return LatLng(lat, lng);
  }
}
