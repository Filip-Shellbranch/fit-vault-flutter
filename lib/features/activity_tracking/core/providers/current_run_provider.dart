import 'dart:async';

import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/run_repository_provider.dart';
import 'package:fit_vault_flutter/features/foreground_task/foreground_service_controller.dart';
import 'package:fit_vault_flutter/features/foreground_task/protocol/task_command.dart';
import 'package:fit_vault_flutter/features/foreground_task/protocol/task_messaging_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_run_provider.g.dart';

final oneSecond = Duration(seconds: 1);

@Riverpod(keepAlive: true)
class CurrentRun extends _$CurrentRun {
  final ForegroundServiceController _runTracker = ForegroundServiceController();
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

  void startRun() {
    TaskMessagingService().sendCommand(StartRunCommand());
  }

  void beginRun() {
    TaskMessagingService().sendCommand(BeginRunCommand());
  }

  void pauseRun() {
    TaskMessagingService().sendCommand(PauseRunCommand());
  }

  void resumeRun() async {
    TaskMessagingService().sendCommand(ResumeRunCommand());
  }

  Future<void> clearRun() async {
    await _runTracker.stopService();
    state = AsyncValue.data(null);
  }
}
