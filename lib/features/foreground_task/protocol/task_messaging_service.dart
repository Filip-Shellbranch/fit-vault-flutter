import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/foreground_task/protocol/task_command.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class TaskMessagingService {
  bool sendCommand(TaskCommand command) {
    try {
      FlutterForegroundTask.sendDataToTask(command.toJSON());
    } catch (e, _) {
      dError("Error sending data to main task.");
      return false;
    }
    return true;
  }

  Future<bool> sendToMain(Object message) async {
    try {
      FlutterForegroundTask.sendDataToMain(message);
    } catch (e, _) {
      dError("Error sending data to main task.");
      return false;
    }
    return true;
  }

  Future<bool> sendToTask(Object message) async {
    try {
      FlutterForegroundTask.sendDataToTask(message);
    } catch (e, _) {
      dError("Error sending data to foreground task.");
      return false;
    }
    return true;
  }
}
