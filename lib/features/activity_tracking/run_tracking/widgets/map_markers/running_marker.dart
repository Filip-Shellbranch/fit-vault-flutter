import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:flutter/material.dart';

class RunningMarker extends StatelessWidget {
  final PointType type;
  const RunningMarker({super.key, required this.type});

  double getInnerRadius() {
    if (!(type == PointType.start || type == PointType.end)) {
      return 20;
    }
    return 28;
  }

  double getOuterRadius() {
    if (!(type == PointType.start || type == PointType.end)) {
      return 20;
    }
    return 36;
  }

  @override
  Widget build(BuildContext context) {
    Color getMarkerColor() {
      switch (type) {
        case PointType.start:
          return Theme.of(context).primaryColor;
        case PointType.end:
          return Colors.red;
        default:
          return Colors.blueGrey;
      }
    }

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer soft shadow / pulse effect
          Container(
            width: getOuterRadius(),
            height: getOuterRadius(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getMarkerColor(),
            ),
          ),
          Container(
            width: getInnerRadius(),
            height: getInnerRadius(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getMarkerColor(),
              border: Border.all(color: Colors.white, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                type == PointType.start
                    ? "S"
                    : type == PointType.end
                    ? "E"
                    : "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
