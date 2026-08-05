import 'package:fit_vault_flutter/core/widgets/confirm_dialog.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/activity_controller_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/run_repository_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/finalize_run/discard_run_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/finalize_run/save_run_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> deleteCurrentRun(WidgetRef ref) async {
  Run? currentRun = ref.read(currentRunProvider).value;
  if (currentRun == null) {
    return;
  }
  // int? id = currentRun.id;
  /*if (id != null) {
    await ref.read(workoutRepositoryProvider).deleteRunById(id);
  }*/
}

class FinishRunButton extends ConsumerWidget {
  final bool isCurrentRun = true;
  const FinishRunButton({super.key});

  void onSavePressed(BuildContext context, WidgetRef ref) async {
    late Run runToSave;
    if (isCurrentRun) {
      Run? loadedValue = ref.read(currentRunProvider).value;
      if (loadedValue == null) {
        return;
      }
      runToSave = loadedValue;
    }
    await ref.read(runRepositoryProvider).saveRun(runToSave, isCompleted: true);
    ref.read(activityControllerProvider).stop();
    if (context.mounted) {
      Navigator.popUntil(context, ModalRoute.withName("/"));
    }
  }

  void onDiscardPressed(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          onConfirmFunc: () async {
            if (isCurrentRun) {
              await deleteCurrentRun(ref);
              ref.read(activityControllerProvider).stop();
            }

            if (context.mounted) {
              Navigator.popUntil(context, ModalRoute.withName("/"));
            }
          },
          prompt: isCurrentRun
              ? "Are you sure you want to discard the run?"
              : "Are you sure you want to discard your changes?",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: PopupMenuButton<String>(
        color: Theme.of(context).secondaryHeaderColor, // Popup background
        onSelected: (value) {
          switch (value) {
            case "Save":
              onSavePressed(context, ref);
              break;
            case "Discard":
              onDiscardPressed(context, ref);
              break;
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor, // Open menu button color
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.center,
            child: Text(
              isCurrentRun ? "Finish run" : "Finish editing",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text(
              isCurrentRun
                  ? "What would you like to do?"
                  : "Do you want to save your changes?",
            ),
          ),
          PopupMenuItem(
            value: "Save",
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SaveRunButton(
                  text: isCurrentRun ? "Save run" : "Save changes",
                  fgColor: Colors.white,
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: "Discard",
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DiscardRunButton(
                  text: isCurrentRun ? "Discard run" : "Discard changes",
                  fgColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
