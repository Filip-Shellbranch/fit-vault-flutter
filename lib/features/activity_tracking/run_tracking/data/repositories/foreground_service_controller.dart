import 'dart:io';

import 'package:fit_vault_flutter/core/utils/string_utils.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/command.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/run_task_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

NotificationButton createNotificationButton(String id) {
  return NotificationButton(id: id, text: capitalize(id));
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

  Future<bool> requestPermissions() async {
    final isIgnoring =
        await FlutterForegroundTask.isIgnoringBatteryOptimizations;
    if (!isIgnoring) {
      bool granted =
          await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      if (!granted) {
        return false;
      }
    }

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
    return true;
  }

  Future<void> startService() async {
    if (!Platform.isAndroid) {
      return;
    }
    if (await isRunning()) {
      return;
    }
    await FlutterForegroundTask.startService(
      serviceId: 9,
      notificationTitle: "Tracking your run",
      notificationText: "Distance: 0.00 km",
      notificationButtons: [
        createNotificationButton("pause"),
        createNotificationButton("stop"),
      ],
      callback: startCallback,
    );
  }

  void updateService(Command command) {
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
      case UpdateDistanceCommand cmd:
        debugPrint(cmd.info.toString());
        newText = "Distance: ${cmd.info} km";
    }
    if (buttons != null) {
      buttons.add(createNotificationButton("stop"));
    }
    FlutterForegroundTask.updateService(
      notificationTitle: newTitle,
      notificationText: newText,
      notificationButtons: buttons,
    );
  }

  Future<void> stopService() async {
    await FlutterForegroundTask.stopService();
  }
}
