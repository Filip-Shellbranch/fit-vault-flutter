import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/milestone_point.dart';
import 'package:flutter/material.dart';

class MilestoneMarker extends StatelessWidget {
  final MilestonePoint milestone;
  const MilestoneMarker({super.key, required this.milestone});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      child: Center(
        child: Text(
          milestone.distance.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
