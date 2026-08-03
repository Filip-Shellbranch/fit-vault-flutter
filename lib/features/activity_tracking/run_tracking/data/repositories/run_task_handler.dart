import 'package:fit_vault_flutter/core/utils/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/task_command.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/foreground_service_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';

Map<String, dynamic> serializePosition(Position position) {
  Map<String, dynamic> map = {
    "lat": position.latitude,
    "lng": position.longitude,
    "altitude": position.altitude,
  };
  return map;
}

void onNewPosition(Position? position) {
  if (position == null) {
    return;
  }
  if (position.accuracy > 20) {
    dInfo("Low accuracy, discarding point");
  }
  FlutterForegroundTask.sendDataToMain(serializePosition(position));
}

class RunTaskHandler extends TaskHandler {
  GeoLocationRepository geo = GeoLocationRepository();
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    try {
      LocationRequestResult permission = await geo.initialize();
      if (permission == LocationRequestResult.granted) {
        await geo.startStream(onNewPosition);
      }
    } catch (e) {
      dError("Error starting RunTaskHandler", error: e);
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  void onReceiveData(Object data) {
    bool isJSON = data is Map<String, dynamic>;
    if (!isJSON) {
      dWarn("Invalid JSON received: ${data.toString()}");
      return;
    }
    try {
      TaskCommand cmd = TaskCommand.fromJSON(data);
      ForegroundServiceController().updateService(cmd);
    } catch (e, trace) {
      dError(
        "Error parsing command or updating notification",
        error: e,
        stack: trace,
      );
    }

    super.onReceiveData(data);
  }

  @override
  void onNotificationButtonPressed(String id) {
    switch (id) {
      case "resume":
        FlutterForegroundTask.sendDataToMain(id);
        break;
      case "pause":
        FlutterForegroundTask.sendDataToMain(id);
        break;
      case "stop":
        FlutterForegroundTask.sendDataToMain(id);
        break;
      default:
    }
    super.onNotificationButtonPressed(id);
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    await geo.dispose();
  }
}
