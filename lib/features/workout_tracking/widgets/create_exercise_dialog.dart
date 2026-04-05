import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/workout_tracking/views/edit_exercise_page.dart';
import 'package:flutter/material.dart';

class CreateExerciseDialog extends StatefulWidget {
  final CreateExerciseTypeCallback createExerciseFunc;
  const CreateExerciseDialog({super.key, required this.createExerciseFunc});

  @override
  State<CreateExerciseDialog> createState() => _CreateExerciseDialogState();
}

class _CreateExerciseDialogState extends State<CreateExerciseDialog> {
  bool isBodyWeight = false;
  final exerciseNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 150,
        child: Column(
          spacing: 8,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Enter the name of the exercise",
                labelStyle: TextStyle(color: Theme.of(context).highlightColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).highlightColor,
                  ),
                ),
              ),
              controller: exerciseNameController,
              autofocus: true,
            ),
            Row(
              children: [
                Text("Uses body weight:"),
                Checkbox(
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Theme.of(context).highlightColor;
                    }
                    return null;
                  }),
                  checkColor: Colors.black,
                  value: isBodyWeight,
                  onChanged: (bool? newValue) {
                    if (newValue != null && newValue != isBodyWeight) {
                      setState(() {
                        isBodyWeight = !isBodyWeight;
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            String exerciseName = exerciseNameController.text
                .trim()
                .toLowerCase();
            ExerciseType newType = ExerciseType(
              exerciseName,
              isCustom: true,
              isBodyWeight: isBodyWeight,
            );
            bool success = await widget.createExerciseFunc(newType);
            if (!context.mounted) {
              return;
            }
            if (success) {
              Navigator.pop(context);
            } else {
              final snackBar = SnackBar(
                content: Text(
                  "Exercise '$exerciseName' can not be created as it already exists!",
                ),
              );
              final messenger = ScaffoldMessenger.of(context);
              messenger.clearSnackBars();
              messenger.showSnackBar(snackBar);
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
