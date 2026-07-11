import 'package:latlong2/latlong.dart';

enum PointType { pause, active }

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

  double distanceTo(RunPoint otherPoint) {
    LatLng p1 = getLatLng();
    LatLng p2 = otherPoint.getLatLng();
    double distance = DistanceVincenty(
      roundResult: false,
    ).as(LengthUnit.Kilometer, p1, p2);
    return distance;
  }

  LatLng getLatLng() {
    return LatLng(lat, lng);
  }
}
