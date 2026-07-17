import 'package:flutter/material.dart';

class RunningMarker extends StatelessWidget {
  final IconData icon;
  const RunningMarker({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer soft shadow / pulse effect
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).highlightColor,
            ),
          ),
          // Inner solid ring and background
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).highlightColor,
              border: Border.all(color: Colors.white, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
