import 'package:fit_vault_flutter/core/utils/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class RunTrackingService {
  Ref ref;
  final geo = GeoLocationRepository();

  RunTrackingService(this.ref) {
    FlutterForegroundTask.addTaskDataCallback(_onTaskDataReceived);
  }

  void onDispose() {}

  Future<RunPoint?> createPointAtCurrentLocation(PointType pointType) async {
    Position? pos = await geo.getCurrentPosition();

    if (pos == null) {
      return null;
    }

    final newPoint = RunPoint(
      pos.latitude,
      pos.longitude,
      altitude: pos.altitude,
      type: pointType,
    );
    return newPoint;
  }

  void _onTaskDataReceived(Object data) {
    if (data is Map<String, dynamic>) {
      if (data.containsKey("lat")) {
        _onPositionReceived(data);
      }
    } else {
      _onCommandReceived(data.toString());
    }
  }

  void _onCommandReceived(String str) {
    final runProvider = ref.read(currentRunProvider.notifier);
    switch (str) {
      case "pause":
        runProvider.pauseRun();
        break;
      case "resume":
        runProvider.resumeRun();
        break;
      case "stop":
        runProvider.stopRun();
        break;
      default:
        dWarn("Unknown data received from task handler: $str");
    }
  }

  void _onPositionReceived(Map<String, dynamic> data) {
    final point = RunPoint(data["lat"], data["lng"], altitude: data["lng"]);
    ref.read(currentRunProvider.notifier).addNewPoint(point);
  }
}
