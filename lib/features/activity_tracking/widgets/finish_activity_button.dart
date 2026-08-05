import 'package:fit_vault_flutter/core/widgets/confirm_dialog.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/activity_controller_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/widgets/finish_choice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef FinishFunction =
    Future<void> Function(BuildContext context, WidgetRef ref);

typedef DiscardFunction =
    Future<void> Function(BuildContext context, WidgetRef ref);

class FinishActivityButton extends ConsumerWidget {
  final bool isCurrent;
  final String activityName;
  final FinishFunction saveFunc;
  final DiscardFunction discardFunc;

  const FinishActivityButton({
    super.key,
    required this.activityName,
    required this.saveFunc,
    required this.discardFunc,
    this.isCurrent = true,
  });

  void onSavePressed(BuildContext context, WidgetRef ref) async {
    await saveFunc(context, ref);
    await ref.read(activityControllerProvider).stop();
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
            await discardFunc(context, ref);
            if (context.mounted) {
              Navigator.popUntil(context, ModalRoute.withName("/"));
            }
          },
          prompt: isCurrent
              ? "Are you sure you want to discard the $activityName?"
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
              isCurrent ? "Finish $activityName" : "Finish editing",
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
              isCurrent
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
                child: FinishChoiceButton(
                  text: isCurrent ? "Save $activityName" : "Save changes",
                  icon: Icons.save,
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
                child: FinishChoiceButton(
                  text: isCurrent ? "Discard $activityName" : "Discard changes",
                  icon: Icons.delete,
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
