import 'dart:async';

import 'package:flutter/material.dart';
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

  Future<bool> startStream(void Function(Position?) callback) async {
    LocationSettings settings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
    );
    if (_stream != null) {
      await _stream!.cancel();
    }
    _stream = Geolocator.getPositionStream(
      locationSettings: settings,
    ).listen(callback);

    return true;
  }

  Future<Position?> getCurrentPosition() async {
    //TODO: Error handling and check permissions.
    final current = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    );
    return current;
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
