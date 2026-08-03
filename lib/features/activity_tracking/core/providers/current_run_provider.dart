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
  try {
    if (Platform.isAndroid) {
      FlutterForegroundTask.sendDataToTask(command.toJSON());
    }
  } catch (e, stack) {
    dError(
      "Error sending message to task (command = ${command.command})",
      error: e,
      stack: stack,
    );
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
    final run = state.value;
    if (run == null) {
      return;
    }
    Run newRun = run.copy();
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

  Future<void> _addPointAtCurrentPosition(Run run, PointType pointType) async {
    final RunPoint? newPoint = await ref
        .read(runTrackingServiceProvider)
        .createPointAtCurrentLocation(pointType);
    if (newPoint == null) {
      return;
    }
    run.positions.add(newPoint);
  }

  void beginRun() async {
    final run = state.value;
    if (run == null || run.isStarted()) {
      return;
    }
    await _addPointAtCurrentPosition(run, PointType.start);

    Run newRun = run.copy();
    newRun.startTime = DateTime.now();
    newRun.pausedAt = null;
    newRun.state = RunState.active;
    beginTimer();

    state = AsyncValue.data(newRun);
  }

  Future<void> pauseRun() async {
    final run = state.value;
    if (run == null || run.isPaused()) {
      return;
    }
    sendMessageToTask(PauseCommand());
    await _addPointAtCurrentPosition(run, PointType.pause);

    Run newRun = run.copy();
    newRun.state = RunState.paused;
    newRun.pausedAt = DateTime.now();
    state = AsyncValue.data(newRun);
    updateRunNotification(newRun);
    stopTimer();
  }

  Future<void> resumeRun() async {
    final run = state.value;
    final timePaused = run?.pausedAt;
    if (run == null || timePaused == null || run.isPaused()) {
      return;
    }

    sendMessageToTask(ResumeCommand());
    await _addPointAtCurrentPosition(run, PointType.resume);

    Run newRun = run.copy();
    newRun.state = RunState.active;
    Duration pauseLength = DateTime.now().difference(timePaused);
    newRun.pausedDuration += pauseLength;
    newRun.pausedAt = null;
    state = AsyncValue.data(newRun);
    beginTimer();
  }

  Future<void> stopRun() async {
    final run = state.value;
    final timePaused = run?.pausedAt;
    if (run != null && timePaused != null && run.isPaused()) {
      Duration pauseLength = DateTime.now().difference(timePaused);
      run.pausedDuration += pauseLength;

      await ref.read(runRepositoryProvider).saveRun(run, isCompleted: true);
    }
    await _runTracker.stopService();
    state = AsyncValue.data(null);
  }
}
