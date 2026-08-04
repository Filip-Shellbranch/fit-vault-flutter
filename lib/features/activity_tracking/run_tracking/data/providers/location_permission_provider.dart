import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_permission_provider.g.dart';

@riverpod
class LocationPermission extends _$LocationPermission {
  final _geo = GeoLocationRepository();

  @override
  Future<LocationRequestResult> build() async {
    return _geo.checkPermission();
  }
}
