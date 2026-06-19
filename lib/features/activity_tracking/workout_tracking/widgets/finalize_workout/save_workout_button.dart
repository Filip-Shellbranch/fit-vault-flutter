import 'package:flutter/material.dart';

class SaveWorkoutButton extends StatelessWidget {
  final Color fgColor;
  const SaveWorkoutButton({super.key, this.fgColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.save, color: fgColor),
        SizedBox(width: 8),
        Text("Save workout", style: TextStyle(fontSize: 26, color: fgColor)),
      ],
    );
  }
}
