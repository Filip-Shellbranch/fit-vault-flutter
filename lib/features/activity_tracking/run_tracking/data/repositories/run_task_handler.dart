import 'dart:io';
import 'dart:isolate';

import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/core/utils/logging/app_logger.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/task_command.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/foreground_service_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';

Map<String, dynamic> serializePosition(Position position) {
  Map<String, dynamic> map = {
    "lat": position.latitude,
    "lng": position.longitude,
    "altitude": position.altitude,
  };
  return map;
}

void onNewPosition(Position position) {
  try {
    if (position.accuracy > 15) {
      dInfo("Low GPS accuracy, discarding point");
      return;
    }
    FlutterForegroundTask.sendDataToMain(serializePosition(position));
  } catch (e, stack) {
    dError(
      "Error sending new position to main isolate",
      error: e,
      stack: stack,
    );
  }
}

class RunTaskHandler extends TaskHandler {
  late ReceivePort errorPort;
  GeoLocationRepository geo = GeoLocationRepository();

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    await AppLogger().init(fileName: "foreground.log");
    try {
      _addErrorHandling();
      LocationRequestResult permission = await geo.initialize();
      if (permission == LocationRequestResult.granted) {
        await geo.startStream(onNewPosition);
      }
    } catch (e) {
      dError("Error starting RunTaskHandler", error: e);
    }
  }

  void _addErrorHandling() {
    errorPort = ReceivePort();

    Isolate.current.addErrorListener(errorPort.sendPort);
    Isolate.current.addOnExitListener(errorPort.sendPort);

    errorPort.listen((dynamic error) {
      if (error is List) {
        dError(
          "Foreground isolate error",
          error: error[0],
          stack: StackTrace.fromString(error[1]),
        );
      } else {
        dError("Foreground isolate exited", error: error);
      }
    });
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
    try {
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
    } catch (e, stack) {
      dError("Error when pressing notification button", error: e, stack: stack);
    }
    super.onNotificationButtonPressed(id);
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/service_lifecycle.log');

    await file.writeAsString(
      '${DateTime.now()} onDestroy\n',
      mode: FileMode.append,
      flush: true,
    );
    try {
      await geo.dispose();
      errorPort.close();
    } catch (e, stack) {
      dError("Error destroying task handler", error: e, stack: stack);
    }
  }
}
