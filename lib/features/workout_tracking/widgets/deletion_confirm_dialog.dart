import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/activity_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeletionConfirmDialog extends StatelessWidget {
  const DeletionConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure you want to discard the workout?"),
      actions: [
        Consumer(
          builder: (context, ref, child) {
            return TextButton(
              onPressed: () {
                ActivityController(ref).stop();
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
              child: Text("Yes"),
            );
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("No"),
        ),
      ],
    );
  }
}
