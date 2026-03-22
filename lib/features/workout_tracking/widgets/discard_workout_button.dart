import 'package:flutter/material.dart';

class DiscardWorkoutButton extends StatelessWidget {
  const DiscardWorkoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.delete),
        SizedBox(width: 8),
        Text("Discard workout", style: TextStyle(fontSize: 26)),
      ],
    );
  }
}
