import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/running_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveRouteOverlay extends ConsumerWidget {
  const LiveRouteOverlay({super.key});

  Marker _createMarker(RunPoint point) {
    return Marker(
      point: point.getLatLng(),
      child: RunningMarker(icon: Icons.run_circle_outlined),
    );
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
        final latLngPoints = run.positions.map((p) => p.getLatLng()).toList();

        return Stack(
          children: [
            PolylineLayer(
              polylines: [
                Polyline(
                  points: latLngPoints,
                  color: Theme.of(context).highlightColor,
                  strokeWidth: 5.0,
                  strokeCap: StrokeCap.round,
                  strokeJoin: StrokeJoin.round,
                ),
              ],
            ),
            MarkerLayer(
              markers: run.positions
                  .map((point) => _createMarker(point))
                  .toList(),
            ),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
