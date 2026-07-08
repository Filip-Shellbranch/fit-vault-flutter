import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'geolocation_provider.g.dart';

@Riverpod(keepAlive: true)
GeoLocationRepository geoLocationRepository(Ref ref) {
  final repository = GeoLocationRepository();

  ref.onDispose(repository.dispose);

  return repository;
}
