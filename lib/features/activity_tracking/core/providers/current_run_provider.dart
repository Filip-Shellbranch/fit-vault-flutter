import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/geolocation_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_run_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentRun extends _$CurrentRun {
  @override
  Future<Run?> build() async {
    return null;
    //return ref.read(workoutRepositoryProvider).loadCurrentWorkout();
  }

  Future<bool> startRun({Run? run}) async {
    GeoLocationRepository geo = ref.read(geoLocationRepositoryProvider);
    await geo.initialize();

    if (geo.permission != LocationRequestResult.granted) {
      return false;
    }

    run ??= Run(DateTime.now());

    state = AsyncValue.data(run);
    return true;
  }
}
