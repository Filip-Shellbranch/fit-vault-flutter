import 'package:flutter/material.dart';

class RunControlButton extends StatelessWidget {
  final IconData icon;
  final Color? buttonColor;
  final VoidCallback onPressed;

  const RunControlButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor ?? Theme.of(context).highlightColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: 70,
        color: Colors.white,
      ),
    );
  }
}
