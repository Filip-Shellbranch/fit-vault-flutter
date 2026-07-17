import 'dart:async';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/current_pace_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/foreground_service_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_run_provider.g.dart';

final oneSecond = Duration(seconds: 1);

@Riverpod(keepAlive: true)
class CurrentRun extends _$CurrentRun {
  final ForegroundServiceController _runTracker = ForegroundServiceController();
  @override
  Future<Run?> build() async {
    return null;
  }

  void addNewPoint(RunPoint newPoint) {
    if (state.value == null) {
      return;
    }
    if (newPoint.type == PointType.active && state.value!.isPaused()) {
      return;
    }
    Run newRun = state.value!.copy();
    double segmentLength = newRun.addPoint(newPoint);
    ref.read(currentPaceProvider.notifier).updatePace(segmentLength);

    state = AsyncValue.data(newRun);
  }

  Future<bool> startRun({Run? run}) async {
    bool granted = await _runTracker.requestPermissions();
    if (!granted) {
      return false;
    }
    await _runTracker.startService();

    run ??= Run(DateTime.now());
    state = AsyncValue.data(run);
    return true;
  }

  void pauseRun() async {
    if (state.value == null) {
      return;
    }
    // TODO: Add a runpoint and set it to paused.
    Run newRun = state.value!.copy();
    newRun.state = RunState.paused;
    newRun.pausedAt = DateTime.now();
    state = AsyncValue.data(newRun);
  }

  void resumeRun() {
    if (state.value == null) {
      return;
    }
    //TODO: Add a runpoint and set it to active.
    Run newRun = state.value!.copy();
    newRun.state = RunState.active;
    Duration pauseLength = DateTime.now().difference(newRun.pausedAt!);
    newRun.pausedDuration += pauseLength;
    newRun.pausedAt = null;

    state = AsyncValue.data(newRun);
  }

  Future<void> stopRun() async {
    await _runTracker.stopService();
    state = AsyncValue.data(null);
  }
}
