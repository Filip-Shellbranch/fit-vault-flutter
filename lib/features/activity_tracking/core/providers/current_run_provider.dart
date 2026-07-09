import 'dart:async';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/geolocation_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_run_provider.g.dart';

final oneSecond = Duration(seconds: 1);

@Riverpod(keepAlive: true)
class CurrentRun extends _$CurrentRun {
  @override
  Future<Run?> build() async {
    listenSelf((previous, next) {
      debugPrint('CurrentRun changed');
    });
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

  void pauseRun() {
    if (state.value == null) {
      return;
    }
    Run newRun = state.value!.copy();
    newRun.state = RunState.paused;
    newRun.pausedAt = DateTime.now();

    state = AsyncValue.data(newRun);
  }

  void resumeRun() {
    if (state.value == null) {
      return;
    }
    Run newRun = state.value!.copy();
    newRun.state = RunState.active;
    Duration pauseLength = DateTime.now().difference(newRun.pausedAt!);
    newRun.pausedDuration += pauseLength;
    newRun.pausedAt = null;

    state = AsyncValue.data(newRun);
  }

  void stopRun() {
    state = AsyncValue.data(null);
  }
}
