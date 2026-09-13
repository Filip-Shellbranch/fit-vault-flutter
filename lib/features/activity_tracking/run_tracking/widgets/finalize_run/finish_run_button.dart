import 'package:fit_vault_flutter/features/activity_tracking/core/providers/activity_controller_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/widgets/finish_activity_button.dart';
import 'package:fit_vault_flutter/features/foreground_task/protocol/task_command.dart';
import 'package:fit_vault_flutter/features/foreground_task/protocol/task_messaging_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinishRunButton extends StatelessWidget {
  final bool isCurrent;
  const FinishRunButton({super.key, this.isCurrent = false});

  Future<void> saveFunc(BuildContext context, WidgetRef ref) async {
    TaskMessagingService().sendCommand(StopRunCommand());
  }

  Future<void> discardFunc(BuildContext context, WidgetRef ref) async {
    if (isCurrent) {
      TaskMessagingService().sendCommand(DiscardRunCommand());
      await ref.read(activityControllerProvider).stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FinishActivityButton(
      activityName: "run",
      saveFunc: saveFunc,
      discardFunc: discardFunc,
    );
  }
}
