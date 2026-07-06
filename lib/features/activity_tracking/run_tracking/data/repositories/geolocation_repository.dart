import 'package:geolocator/geolocator.dart';

class GeoLocationRepository {
  late final Geolocator geo;

  GeoLocationRepository() {
    geo = Geolocator();
  }
}
