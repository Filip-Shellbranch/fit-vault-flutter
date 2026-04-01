import 'package:fit_vault_flutter/features/workout_tracking/views/edit_exercise_page.dart';
import 'package:flutter/material.dart';

class CreateExerciseDialog extends StatelessWidget {
  final CreateExerciseCallback createExerciseFunc;
  const CreateExerciseDialog({super.key, required this.createExerciseFunc});

  @override
  Widget build(BuildContext context) {
    final exerciseNameController = TextEditingController();
    return AlertDialog(
      content: TextField(
        decoration: InputDecoration(
          labelText: "Enter the name of the exercise",
        ),
        controller: exerciseNameController,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () async {
            String exerciseName = exerciseNameController.text
                .trim()
                .toLowerCase();
            bool success = await createExerciseFunc(exerciseName);
            if (success && context.mounted) {
              Navigator.pop(context);
            } else {
              debugPrint("Already exists");
            }
          },
          child: Text("Create"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
