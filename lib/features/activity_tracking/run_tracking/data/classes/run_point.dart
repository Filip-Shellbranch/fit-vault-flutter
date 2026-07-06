import 'package:geolocator/geolocator.dart';

enum PointType { pause, active }

class RunPoint {
  final Position position;
  final PointType type;

  RunPoint(this.position, {this.type = PointType.active});
}
