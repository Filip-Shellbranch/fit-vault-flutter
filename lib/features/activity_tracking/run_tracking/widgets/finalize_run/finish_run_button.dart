import 'package:fit_vault_flutter/core/utils/logging/debug.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/activity_controller_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/run_repository_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/widgets/finish_activity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> deleteCurrentRun(WidgetRef ref) async {
  //TODO: Implement this when runs are stored before they are finished.
}

class FinishRunButton extends StatelessWidget {
  final bool isCurrent;
  const FinishRunButton({super.key, this.isCurrent = false});

  Future<void> saveFunc(BuildContext context, WidgetRef ref) async {
    Run? currentRun = ref.read(currentRunProvider).value;
    if (currentRun == null) {
      dWarn("Attempting to save when current run is null");
      return;
    }
    Run runToSave = currentRun;

    await ref.read(runRepositoryProvider).saveRun(runToSave, isCompleted: true);
  }

  Future<void> discardFunc(BuildContext context, WidgetRef ref) async {
    if (isCurrent) {
      await deleteCurrentRun(ref);
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
