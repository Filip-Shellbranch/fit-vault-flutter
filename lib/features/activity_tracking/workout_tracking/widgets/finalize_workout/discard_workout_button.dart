import 'package:flutter/material.dart';

class DiscardWorkoutButton extends StatelessWidget {
  final Color fgColor;
  const DiscardWorkoutButton({super.key, this.fgColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.delete, color: fgColor),
        SizedBox(width: 8),
        Text("Discard workout", style: TextStyle(fontSize: 26, color: fgColor)),
      ],
    );
  }
}
