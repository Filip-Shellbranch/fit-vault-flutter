import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

final currentPositionProvider = StreamProvider<LatLng>((ref) async* {
  final geo = GeoLocationRepository();
  ref.onDispose(() {
    geo.dispose();
  });
  while (true) {
    final pos = await geo.getCurrentPosition();
    if (pos != null) {
      yield LatLng(pos.latitude, pos.longitude);
    }

    await Future.delayed(const Duration(seconds: 5));
  }
});
