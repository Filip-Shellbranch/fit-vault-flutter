import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise_type.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/create_exercise_dialog.dart';
import 'package:flutter/material.dart';

class AddExerciseTypeButton extends StatelessWidget {
  final Future<bool> Function(ExerciseType) createExerciseFunc;
  const AddExerciseTypeButton({super.key, required this.createExerciseFunc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CreateExerciseDialog(
                createExerciseFunc: createExerciseFunc,
              );
            },
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).highlightColor,
          foregroundColor: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.add, size: 40),
              SizedBox(width: 10),
              Text("Add a new exercise type", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
