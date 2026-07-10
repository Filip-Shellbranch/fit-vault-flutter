import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

enum PointType { pause, active }

class RunPoint {
  final Position position;
  final PointType type;

  RunPoint(this.position, {this.type = PointType.active});

  double distanceTo(RunPoint otherPoint) {
    LatLng p1 = getLatLng();
    LatLng p2 = otherPoint.getLatLng();
    double distance = DistanceVincenty().as(LengthUnit.Kilometer, p1, p2);
    return distance;
  }

  LatLng getLatLng() {
    return LatLng(position.latitude, position.longitude);
  }
}
