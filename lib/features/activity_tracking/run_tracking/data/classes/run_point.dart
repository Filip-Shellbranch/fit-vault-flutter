import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/models/run_point_model.dart';
import 'package:latlong2/latlong.dart';

enum PointType { start, pause, resume, active, end }

class RunPoint {
  final double lat;
  final double lng;
  final double altitude;

  final PointType type;

  RunPoint(
    this.lat,
    this.lng, {
    this.type = PointType.active,
    this.altitude = 0.0,
  });

  factory RunPoint.fromModel(RunPointModel model) {
    final point = RunPoint(
      model.lat ?? 0,
      model.lng ?? 0,
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
    if (distance.isFinite) {
      return 0;
    }
    return distance;
  }

  LatLng getLatLng() {
    return LatLng(lat, lng);
  }
}
