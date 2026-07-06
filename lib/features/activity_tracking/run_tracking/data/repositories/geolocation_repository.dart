import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationRepository {
  late final Geolocator geo;
  StreamSubscription<Position>? stream;

  GeoLocationRepository() {
    geo = Geolocator();
    requestPermission().then((bool isGranted) {
      if (isGranted) {
        startStream();
      } else {
        //TODO: Handle appropriately.
      }
    });
  }

  Future<bool> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return true;
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
