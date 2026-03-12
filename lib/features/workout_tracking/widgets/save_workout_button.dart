import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/activity_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveWorkoutButton extends StatelessWidget {
  const SaveWorkoutButton({super.key});

  final SnackBar infoMessage = const SnackBar(
    content: Text("Workout tracking has not yet been implemented."),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return FloatingActionButton.extended(
          onPressed: () {
            ActivityController(ref).stop();
            Navigator.pop(context);
          },
          heroTag: null,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icon(Icons.save),
          label: SizedBox(
            width: 200,
            child: Text("Save workout", style: TextStyle(fontSize: 26)),
          ),
        );
      },
    );
  }
}
