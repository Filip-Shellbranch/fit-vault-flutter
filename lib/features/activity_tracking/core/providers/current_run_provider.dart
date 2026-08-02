import 'dart:async';
import 'dart:io';

import 'package:fit_vault_flutter/core/utils/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/task_command.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/current_pace_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/run_repository_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/run_tracking_service_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/foreground_service_controller.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_run_provider.g.dart';

void sendMessageToTask(TaskCommand command) {
  if (Platform.isAndroid) {
    FlutterForegroundTask.sendDataToTask(command.toJSON());
  }
}

void updateRunNotification(Run run) {
  sendMessageToTask(
    UpdateTextCommand(
      formatNotificationText(run.calculateDuration(), run.distance),
    ),
  );
}

final oneSecond = Duration(seconds: 1);

@Riverpod(keepAlive: true)
class CurrentRun extends _$CurrentRun {
  final ForegroundServiceController _runTracker = ForegroundServiceController();
  Timer? _notificationUpdateTimer;

  @override
  Future<Run?> build() async {
    ref.onDispose(stopTimer);
    return null;
  }

  void beginTimer() {
    if (_notificationUpdateTimer != null) {
      return;
    }
    _notificationUpdateTimer = Timer.periodic(oneSecond, (timer) {
      final run = state.value;
      if (run == null) {
        return;
      }
      updateRunNotification(run);
    });
  }

  void stopTimer() {
    _notificationUpdateTimer?.cancel();
    _notificationUpdateTimer = null;
  }

  void addNewPoint(RunPoint newPoint) {
    if (state.value == null) {
      return;
    }
    if (newPoint.type == PointType.active && !state.value!.isActive()) {
      return;
    }
    Run newRun = state.value!.copy();
    double segmentLength = newRun.addPoint(newPoint);
    ref.read(currentPaceProvider.notifier).updatePace(segmentLength);
    state = AsyncValue.data(newRun);
    updateRunNotification(newRun);
  }

  Future<bool> startRun({Run? run}) async {
    run ??= Run.newRun();
    state = AsyncValue.data(run);
    bool granted = await _runTracker.requestPermissions();
    if (!granted) {
      return false;
    }
    await _runTracker.startService();
    return true;
  }

  Future<void> _addPointAtCurrentPosition(PointType pointType) async {
    final RunPoint? newPoint = await ref
        .read(runTrackingServiceProvider)
        .createPointAtCurrentLocation(pointType);
    if (newPoint == null) {
      return;
    }
    state.value!.positions.add(newPoint);
  }

  void beginRun() async {
    if (state.value == null) {
      return;
    }
    await _addPointAtCurrentPosition(PointType.start);

    Run newRun = state.value!.copy();
    newRun.startTime = DateTime.now();
    newRun.pausedAt = null;
    newRun.state = RunState.active;
    beginTimer();

    state = AsyncValue.data(newRun);
  }

  Future<void> pauseRun() async {
    if (state.value == null) {
      return;
    }
    sendMessageToTask(PauseCommand());
    await _addPointAtCurrentPosition(PointType.pause);

    Run newRun = state.value!.copy();
    newRun.state = RunState.paused;
    newRun.pausedAt = DateTime.now();
    state = AsyncValue.data(newRun);
    updateRunNotification(newRun);
    stopTimer();
  }

  Future<void> resumeRun() async {
    if (state.value == null) {
      return;
    }
    sendMessageToTask(ResumeCommand());
    await _addPointAtCurrentPosition(PointType.resume);

    Run newRun = state.value!.copy();
    newRun.state = RunState.active;
    Duration pauseLength = DateTime.now().difference(newRun.pausedAt!);
    newRun.pausedDuration += pauseLength;
    newRun.pausedAt = null;
    state = AsyncValue.data(newRun);
    beginTimer();
  }

  Future<void> stopRun() async {
    if (state.value != null) {
      final run = state.value!;
      Duration pauseLength = DateTime.now().difference(run.pausedAt!);
      run.pausedDuration += pauseLength;

      await ref.read(runRepositoryProvider).saveRun(run, isCompleted: true);
    }
    await _runTracker.stopService();
    state = AsyncValue.data(null);
  }
}
