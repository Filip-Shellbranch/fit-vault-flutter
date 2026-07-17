import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunTrackingService {
  Ref ref;
  RunTrackingService(this.ref) {
    FlutterForegroundTask.addTaskDataCallback(_onPositionReceived);
  }

  void onDispose() {}

  Future<RunPoint> fetchCurrentPosition() async {
    return RunPoint(40, 40);
  }

  void _onPositionReceived(Object data) {
    if (data is! Map<String, dynamic>) return;

    final point = RunPoint(data["lat"], data["lng"], altitude: data["lng"]);
    ref.read(currentRunProvider.notifier).addNewPoint(point);
  }
}
