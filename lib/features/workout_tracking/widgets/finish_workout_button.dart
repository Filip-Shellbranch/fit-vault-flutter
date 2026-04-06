import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/activity_controller.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/deletion_confirm_dialog.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/discard_workout_button.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/save_workout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinishWorkoutButton extends ConsumerWidget {
  const FinishWorkoutButton({super.key});

  void onSavePressed(BuildContext context, WidgetRef ref) {
    ActivityController(ref).stop();
    Navigator.popUntil(context, ModalRoute.withName("/"));
  }

  void onDiscardPressed(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return DeletionConfirmDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: PopupMenuButton<String>(
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
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(8), // Edit corner radius here
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.center,
            child: const Text(
              "Finish workout",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: "Save",
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Container(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SaveWorkoutButton(),
              ),
            ),
          ),
          PopupMenuItem(
            value: "Discard",
            padding: EdgeInsets.all(8),
            child: Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DiscardWorkoutButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
