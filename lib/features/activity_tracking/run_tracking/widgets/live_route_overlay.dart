import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/milestone_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/milestone_marker.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/running_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class LiveRouteOverlay extends ConsumerWidget {
  final Color lineColor;
  const LiveRouteOverlay({super.key, this.lineColor = Colors.red});

  Marker _createMarker(RunPoint point) {
    return Marker(
      point: point.getLatLng(),
      child: RunningMarker(type: point.type),
    );
  }

  List<Marker> _loadMarkers(List<RunPoint> points) {
    List<Marker> markers = [];
    for (RunPoint point in points) {
      if (point.type != PointType.active) {
        final newMarker = _createMarker(point);
        markers.add(newMarker);
      }
    }

    List<MilestonePoint> milestones = _calculateMilestonePoints(points);
    List<Marker> milestoneMarkers = milestones
        .map(
          (milestone) => Marker(
            point: LatLng(milestone.lat, milestone.lng),
            child: MilestoneMarker(milestone: milestone),
          ),
        )
        .toList();
    markers.addAll(milestoneMarkers);
    return markers;
  }

  Polyline? _createPolyLineFromPoints(List<LatLng> latLngPoints) {
    if (latLngPoints.length < 2) {
      return null;
    }
    return Polyline(
      points: List.from(latLngPoints),
      color: lineColor,
      strokeWidth: 5.0,
      strokeCap: StrokeCap.round,
      strokeJoin: StrokeJoin.round,
    );
  }

  List<Polyline> _createRouteLines(List<RunPoint> points) {
    List<Polyline> lines = [];
    List<LatLng> pointsInCurrent = [];
    for (RunPoint point in points) {
      switch (point.type) {
        case PointType.active:
          pointsInCurrent.add(point.getLatLng());
          break;
        case PointType.start:
          pointsInCurrent.clear();
          pointsInCurrent.add(point.getLatLng());
          break;
        case PointType.resume:
          pointsInCurrent.clear();
          pointsInCurrent.add(point.getLatLng());
          break;
        case PointType.pause:
          pointsInCurrent.add(point.getLatLng());
          final newLine = _createPolyLineFromPoints(pointsInCurrent);
          if (newLine != null) {
            lines.add(newLine);
          }
          pointsInCurrent.clear();
          break;
        case PointType.end:
          pointsInCurrent.add(point.getLatLng());
          break;
      }
    }
    if (pointsInCurrent.length >= 2) {
      final newLine = _createPolyLineFromPoints(pointsInCurrent);
      if (newLine != null) {
        lines.add(newLine);
      }
    }
    return lines;
  }

  List<MilestonePoint> _calculateMilestonePoints(List<RunPoint> points) {
    final List<MilestonePoint> milestones = [];
    if (points.length < 2) {
      return milestones;
    }
    int nextMilestone = 1;
    double dist = 0;
    RunPoint previousPoint = points.first;
    for (RunPoint point in points) {
      if (point == previousPoint) {
        continue;
      }
      if (point.type != PointType.active) {
        previousPoint = point;
        continue;
      }
      double segmentDist = point.distanceTo(previousPoint);
      double distBeforeSegment = dist;
      dist += segmentDist;
      while (dist > nextMilestone) {
        double c = (nextMilestone - distBeforeSegment) / segmentDist;

        double lerpLat =
            (previousPoint.lat - (previousPoint.lat - point.lat) * c);
        double lerpLng =
            (previousPoint.lng - (previousPoint.lng - point.lng) * c);

        MilestonePoint milestone = MilestonePoint(
          lat: lerpLat,
          lng: lerpLng,
          distance: nextMilestone,
        );
        milestones.add(milestone);
        nextMilestone += 1;
      }
      previousPoint = point;
    }
    return milestones;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runAsync = ref.watch(currentRunProvider);
    debugPrint("rebuild live overlay");

    return runAsync.maybeWhen(
      data: (run) {
        if (run == null) {
          return const SizedBox.shrink();
        }
        final polyLines = _createRouteLines(run.positions);

        return Stack(
          children: [
            PolylineLayer(polylines: polyLines),
            MarkerLayer(markers: _loadMarkers(run.positions)),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
