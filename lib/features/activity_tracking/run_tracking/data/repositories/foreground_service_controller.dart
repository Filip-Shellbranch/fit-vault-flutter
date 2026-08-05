import 'dart:io';
import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/core/utils/string_utils.dart';
import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/task_command.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/run_task_handler.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

NotificationButton createNotificationButton(String id) {
  return NotificationButton(id: id, text: capitalize(id));
}

String formatNotificationText(Duration duration, double dist) {
  return "${formatDurationHMS(duration)} ● Distance: ${dist.toStringAsFixed(2)} km";
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(RunTaskHandler());
}

class ForegroundServiceController {
  ForegroundServiceController();

  Future<bool> isRunning() async {
    if (!Platform.isAndroid) {
      return false;
    }
    return await FlutterForegroundTask.isRunningService;
  }

  Future<bool> _requestIgnoreBatteryOptimization() async {
    try {
      final isIgnoring =
          await FlutterForegroundTask.isIgnoringBatteryOptimizations;
      if (!isIgnoring) {
        bool granted =
            await FlutterForegroundTask.requestIgnoreBatteryOptimization();
        if (!granted) {
          return false;
        }
      }
    } catch (e) {
      dError("Error requesting ignore battery optimization", error: e);
      return false;
    }
    return true;
  }

  Future<bool> _requestNotificationPermission() async {
    try {
      final NotificationPermission status =
          await FlutterForegroundTask.checkNotificationPermission();

      if (status != NotificationPermission.granted) {
        bool granted =
            await FlutterForegroundTask.requestNotificationPermission() ==
            NotificationPermission.granted;
        if (!granted) {
          return false;
        }
      }
    } catch (e) {
      dError("Error checking or requesting notification permission", error: e);
      return false;
    }
    return true;
  }

  Future<bool> requestPermissions() async {
    if (!Platform.isAndroid) {
      return false;
    }
    await GeoLocationRepository().initialize();

    if (!await _requestIgnoreBatteryOptimization()) {
      return false;
    }
    if (!await _requestNotificationPermission()) {
      return false;
    }
    return true;
  }

  Future<void> startService() async {
    if (!Platform.isAndroid) {
      return;
    }
    if (await isRunning()) {
      return;
    }

    await requestPermissions();
    try {
      await FlutterForegroundTask.startService(
        serviceId: 9,
        notificationTitle: "Tracking your run",
        notificationText: formatNotificationText(Duration.zero, 0),
        notificationButtons: [
          createNotificationButton("pause"),
          createNotificationButton("stop"),
        ],
        callback: startCallback,
      );
    } catch (e) {
      dError("Error starting foreground task", error: e);
      rethrow;
    }
  }

  void updateService(TaskCommand command) {
    if (!Platform.isAndroid) {
      return;
    }
    String? newTitle;
    String? newText;
    List<NotificationButton>? buttons;
    switch (command) {
      case PauseCommand _:
        newTitle = "Run paused";
        buttons = [createNotificationButton("resume")];
        break;
      case ResumeCommand _:
        newTitle = "Tracking your run";
        buttons = [createNotificationButton("pause")];
        break;
      case UpdateTextCommand cmd:
        newText = cmd.text;
        break;
    }
    if (buttons != null) {
      buttons.add(createNotificationButton("stop"));
    }
    try {
      FlutterForegroundTask.updateService(
        notificationTitle: newTitle,
        notificationText: newText,
        notificationButtons: buttons,
      );
    } catch (e) {
      dError("Error updating foreground service/notification", error: e);
    }
  }

  Future<void> stopService() async {
    if (!Platform.isAndroid) {
      return;
    }
    try {
      await FlutterForegroundTask.stopService();
    } catch (e) {
      dError("Error stopping foreground service", error: e);
    }
  }
}
