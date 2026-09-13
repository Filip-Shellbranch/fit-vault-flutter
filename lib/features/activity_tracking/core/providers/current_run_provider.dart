import 'dart:async';
import 'dart:io';

import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/run_repository_provider.dart';
import 'package:fit_vault_flutter/features/foreground_task/foreground_service_controller.dart';
import 'package:fit_vault_flutter/features/foreground_task/protocol/task_command.dart';
import 'package:fit_vault_flutter/features/foreground_task/protocol/task_messaging_service.dart';
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
  /*sendMessageToTask(
    UpdateTextCommand(
      formatNotificationText(run.calculateDuration(), run.distance),
    ),
  );*/
}

final oneSecond = Duration(seconds: 1);

@Riverpod(keepAlive: true)
class CurrentRun extends _$CurrentRun {
  final ForegroundServiceController _runTracker = ForegroundServiceController();
  Timer? _notificationUpdateTimer;
  late final StreamSubscription<int?> _runStartedStream;
  late final StreamSubscription<void> _runCompletedStream;
  StreamSubscription<void>? _currentRunStream;

  @override
  Future<Run?> build() async {
    ref.onDispose(onDispose);

    final runRepo = ref.read(runRepositoryProvider);
    _runStartedStream = runRepo.watchRunCreated().listen((runId) async {
      dWarn("New run created and accessed through stream");
      Run? activeRun = await runRepo.getActiveRun();
      if (activeRun != null) {
        onRunUpdated(activeRun.id);
      }
      state = AsyncValue.data(activeRun);
    });
    _runCompletedStream = runRepo.watchRunCompleted().listen((_) {
      dWarn("Stream noticed run completed.");
      state = AsyncValue.data(null);
      _currentRunStream?.cancel();
    });

    return await runRepo.getActiveRun();
  }

  void onDispose() {
    stopTimer();
    _runStartedStream.cancel();
    _runCompletedStream.cancel();
    _currentRunStream?.cancel();
  }

  void onRunUpdated(int? runId) {
    if (runId == null) {
      return;
    }
    _currentRunStream?.cancel();
    final runRepo = ref.read(runRepositoryProvider);
    _currentRunStream = runRepo.watchRun(runId).listen((run) {
      dWarn("Stream noticed run updated.");
      if (run != null) {
        dPrint("Paused at: ${run.pausedAt.toString()}");
        dPrint("TimePaused: ${run.pausedDuration.toString()}");
        dPrint("State: ${run.state.toString()}");
      }
      state = AsyncValue.data(run);
    });
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

  Future<bool> startRun({Run? run}) async {
    TaskMessagingService().sendCommand(StartRunCommand());
    return true;
  }

  Future<void> beginRun() async {
    TaskMessagingService().sendCommand(BeginRunCommand());
    beginTimer();
  }

  Future<void> pauseRun() async {
    TaskMessagingService().sendCommand(PauseRunCommand());
    stopTimer();
  }

  Future<void> resumeRun() async {
    TaskMessagingService().sendCommand(ResumeRunCommand());
    beginTimer();
  }

  Future<void> stopRun() async {
    //TaskMessagingService().sendCommand(StopRunCommand());
    stopTimer();
    /*final run = state.value;
    final timePaused = run?.pausedAt;
    if (run == null || timePaused == null || !run.isPaused()) {
      dWarn("Not stopping run, run is not properly paused.");
      return;
    }
    final now = DateTime.now();

    Run newRun = run.copy();
    newRun.endTime = now;
    Duration pauseLength = now.difference(timePaused);
    newRun.pausedDuration += pauseLength;
    newRun.positions.last.markAsEndPoint();

    state = AsyncValue.data(newRun);*/
    //await _runTracker.stopService();
  }

  Future<void> clearRun() async {
    await _runTracker.stopService();
    state = AsyncValue.data(null);
  }
}
