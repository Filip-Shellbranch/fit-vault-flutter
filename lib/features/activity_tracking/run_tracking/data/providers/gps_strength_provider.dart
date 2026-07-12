import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GpsSignalStrength { weak, medium, strong }

class GpsStrength {
  final double accuracy;
  final GpsSignalStrength strength;
  GpsStrength(this.accuracy)
    : strength = accuracy < 1
          ? GpsSignalStrength.strong
          : accuracy < 5
          ? GpsSignalStrength.medium
          : GpsSignalStrength.weak;
}

final gpsStrengthProvider = StreamProvider<GpsStrength>((ref) async* {
  while (true) {
    final accuracy = await GeoLocationRepository().measureAccuracy();
    yield GpsStrength(accuracy);

    await Future.delayed(const Duration(seconds: 5));
  }
});
