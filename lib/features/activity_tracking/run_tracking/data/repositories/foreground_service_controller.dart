import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/run_task_handler.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(RunTaskHandler());
}

class ForegroundServiceController {
  ForegroundServiceController();

  Future<bool> requestPermissions() async {
    final isIgnoring =
        await FlutterForegroundTask.isIgnoringBatteryOptimizations;
    if (!isIgnoring) {
      bool granted =
          await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      return granted;
    }
    return true;
  }

  Future<void> startService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return;
    }
    await FlutterForegroundTask.startService(
      notificationTitle: 'Tracking Location',
      notificationText: 'Waiting for location...',
      callback: startCallback,
    );
  }

  Future<void> stopService() async {
    await FlutterForegroundTask.stopService();
  }
}
