import 'package:flutter/material.dart';

class SaveWorkoutButton extends StatelessWidget {
  final Color fgColor;
  final String text;
  const SaveWorkoutButton({
    super.key,
    required this.text,
    this.fgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.save, color: fgColor),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 26, color: fgColor)),
      ],
    );
  }
}
