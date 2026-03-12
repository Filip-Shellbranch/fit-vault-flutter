import 'package:fit_vault_flutter/features/workout_tracking/widgets/deletion_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscardWorkoutButton extends StatelessWidget {
  const DiscardWorkoutButton({super.key});

  final SnackBar infoMessage = const SnackBar(
    content: Text("Workout tracking has not yet been implemented."),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DeletionConfirmDialog();
              },
            );
          },
          heroTag: null,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icon(Icons.delete),
          label: SizedBox(
            width: 200,
            child: Text("Discard workout", style: TextStyle(fontSize: 26)),
          ),
        );
      },
    );
  }
}
