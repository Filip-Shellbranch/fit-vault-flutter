import 'package:flutter/material.dart';

class DiscardRunButton extends StatelessWidget {
  final Color fgColor;
  final String text;
  const DiscardRunButton({
    super.key,
    required this.text,
    this.fgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.delete, color: fgColor),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 26, color: fgColor)),
      ],
    );
  }
}
