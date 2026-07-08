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
  LocationRequestResult permission = LocationRequestResult.notRequested;
  StreamSubscription<Position>? stream;

  GeoLocationRepository();

  Future<void> initialize() async {
    LocationRequestResult result = await _requestPermission();
    permission = result;
  }

  void dispose() {
    if (stream != null) {
      stream!.cancel();
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

  StreamSubscription<Position> startStream() {
    LocationSettings settings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
    );
    return Geolocator.getPositionStream(locationSettings: settings).listen((
      Position? position,
    ) {
      debugPrint(
        position == null
            ? 'Unknown'
            : '${position.latitude.toString()}, ${position.longitude.toString()}',
      );
    });
  }
}
