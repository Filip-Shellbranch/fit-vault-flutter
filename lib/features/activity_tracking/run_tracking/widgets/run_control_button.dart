import 'package:flutter/material.dart';

class RunControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RunControlButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
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
