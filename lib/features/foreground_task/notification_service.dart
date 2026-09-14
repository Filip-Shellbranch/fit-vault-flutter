import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/core/utils/string_utils.dart';
import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

NotificationButton _createRunButton(String id) {
  return NotificationButton(id: "run: $id", text: capitalize(id));
}

List<NotificationButton> _createRunButtons(List<String> ids) {
  return ids.map((id) => _createRunButton(id)).toList();
}

String _formatRunNotificationText(Duration duration, double dist) {
  return "${formatDurationHMS(duration)} ● Distance: ${dist.toStringAsFixed(2)} km";
}

class NotificationService {
  void _updateNotification(
    String? newTitle,
    String? newText,
    List<NotificationButton>? buttons,
  ) {
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

  void updateRunNotification(Run run) {
    final title = run.isPaused() ? "Run Paused" : "Tracking your run";
    final text = _formatRunNotificationText(
      run.calculateDuration(),
      run.distance,
    );
    final List<NotificationButton>? buttons;
    switch (run.state) {
      case RunState.active:
        buttons = _createRunButtons(["pause"]);
        break;
      case RunState.paused:
        buttons = _createRunButtons(["resume"]);
        break;
      default:
        buttons = null;
        break;
    }
    _updateNotification(title, text, buttons);
  }
}
