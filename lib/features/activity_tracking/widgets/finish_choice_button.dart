import 'package:flutter/material.dart';

class FinishChoiceButton extends StatelessWidget {
  final Color fgColor;
  final String text;
  final IconData icon;
  const FinishChoiceButton({
    super.key,
    required this.text,
    required this.icon,
    this.fgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: fgColor),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 26, color: fgColor)),
      ],
    );
  }
}
