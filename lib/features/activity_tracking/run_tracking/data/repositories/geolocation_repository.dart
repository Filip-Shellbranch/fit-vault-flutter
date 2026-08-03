import 'dart:async';

import 'package:fit_vault_flutter/core/utils/debug.dart';
import 'package:geolocator/geolocator.dart';

enum LocationRequestResult {
  granted,
  serviceDisabled,
  denied,
  deniedForever,
  notRequested,
}

class GeoLocationRepository {
  StreamSubscription<Position>? _stream;
  GeoLocationRepository();

  Future<LocationRequestResult> initialize() async {
    LocationRequestResult result = await _requestPermission();
    return result;
  }

  Future<LocationRequestResult> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationRequestResult.serviceDisabled;
    }

    permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.denied:
        return LocationRequestResult.denied;
      case LocationPermission.deniedForever:
        return LocationRequestResult.deniedForever;
      default:
        return LocationRequestResult.granted;
    }
  }

  Future<LocationRequestResult> _requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationRequestResult.serviceDisabled;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationRequestResult.denied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationRequestResult.deniedForever;
    }

    return LocationRequestResult.granted;
  }

  Future<bool> startStream(void Function(Position) callback) async {
    AndroidSettings settings = AndroidSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
      intervalDuration: Duration(seconds: 2),
    );
    if (_stream != null) {
      await _stream!.cancel();
    }

    final permission = await _requestPermission();
    if (permission != LocationRequestResult.granted) {
      return false;
    }

    try {
      _stream = Geolocator.getPositionStream(locationSettings: settings).listen(
        callback,
        onError: (e, stack) {
          dError("Error occurred in position stream", error: e, stack: stack);
        },
      );
    } catch (e, stack) {
      dError("Error starting position stream", error: e, stack: stack);
      return false;
    }

    return true;
  }

  Future<Position?> getCurrentPosition() async {
    try {
      final current = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      );
      return current;
    } catch (e, stack) {
      dError("Error fetching current position", error: e, stack: stack);
      return null;
    }
  }

  Future<double> measureAccuracy() async {
    Position? point = await getCurrentPosition();
    if (point == null) {
      return 0.0;
    } else {
      return point.accuracy;
    }
  }

  Future<void> dispose() async {
    if (_stream != null) {
      await _stream?.cancel();
      _stream = null;
    }
  }
}
