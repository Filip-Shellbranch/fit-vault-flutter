import 'package:flutter/material.dart';

class SaveWorkoutButton extends StatelessWidget {
  const SaveWorkoutButton({super.key});

  final SnackBar infoMessage = const SnackBar(
    content: Text("Workout tracking has not yet been implemented."),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.save),
        SizedBox(width: 8),
        Text("Save workout", style: TextStyle(fontSize: 26)),
      ],
    );
  }
}
