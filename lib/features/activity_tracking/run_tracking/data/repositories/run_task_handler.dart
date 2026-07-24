import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/commands/command.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/foreground_service_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:flutter/widgets.dart';
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
  if (position != null) {
    FlutterForegroundTask.sendDataToMain(serializePosition(position));
  }
}

class RunTaskHandler extends TaskHandler {
  GeoLocationRepository geo = GeoLocationRepository();
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    LocationRequestResult permission = await geo.initialize();
    if (permission == LocationRequestResult.granted) {
      await geo.startStream(onNewPosition);
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {}

  @override
  void onReceiveData(Object data) {
    bool isJSON = data is Map<String, dynamic>;
    if (!isJSON) {
      debugPrint("Invalid JSON received!");
      return;
    }
    try {
      Command cmd = Command.fromJSON(data);
      ForegroundServiceController().updateService(cmd);
    } catch (e, _) {
      debugPrint(e.toString());
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
