import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/milestone_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/map_markers/pin_marker.dart';
import 'package:flutter/material.dart';

class MilestoneMarker extends StatelessWidget {
  final MilestonePoint milestone;
  const MilestoneMarker({super.key, required this.milestone});

  @override
  Widget build(BuildContext context) {
    return PinMarker(
      text: "${milestone.distance.toString()} km",
      color: Theme.of(context).primaryColor.withValues(alpha: 0.9),
    );
  }
}
