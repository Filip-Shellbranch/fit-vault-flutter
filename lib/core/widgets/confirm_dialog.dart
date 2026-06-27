import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void defaultCancelFunc() {}

class ConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirmFunc;
  final VoidCallback onCancelFunc;
  final String prompt;
  final String confirmText;
  final String cancelText;
  const ConfirmDialog({
    super.key,
    required this.onConfirmFunc,
    this.onCancelFunc = defaultCancelFunc,
    this.prompt = "Are you sure?",
    this.confirmText = "Yes",
    this.cancelText = "No",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(prompt),
      actions: [
        Consumer(
          builder: (context, ref, child) {
            return TextButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
                onConfirmFunc();
              },
              child: Text(confirmText),
            );
          },
        ),
        TextButton(
          onPressed: () {
            if (context.mounted) {
              Navigator.pop(context);
            }
            onCancelFunc();
          },
          child: Text(cancelText),
        ),
      ],
    );
  }
}
