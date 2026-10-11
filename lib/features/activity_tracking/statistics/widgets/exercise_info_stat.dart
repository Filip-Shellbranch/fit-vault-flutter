import 'package:flutter/material.dart';

class ExerciseInfoStat extends StatelessWidget {
  final String statName;
  final String value;
  final bool borderOnLeft;
  const ExerciseInfoStat({
    super.key,
    required this.statName,
    required this.value,
    this.borderOnLeft = true,
  });

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(color: Theme.of(context).highlightColor);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: borderOnLeft ? border : BorderSide.none,
          right: !borderOnLeft ? border : BorderSide.none,
        ),
      ),
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Column(
            crossAxisAlignment: borderOnLeft
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
                statName,
              ),
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).highlightColor,
                  fontWeight: FontWeight.bold,
                ),
                value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
