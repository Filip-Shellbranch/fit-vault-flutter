import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/displayed_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/map_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/live_route_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class RunningMap extends ConsumerWidget {
  final MapController controller;
  const RunningMap({super.key, required this.controller});

  List<LatLng> _getRoutePoints(List<RunPoint> runPoints) {
    return runPoints.map((point) => point.getLatLng()).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Run? run = ref.watch(displayedRunProvider);
    if (run == null) {
      return Center(child: Text("Begin the run to view the map."));
    }

    List<LatLng> boundPoints = _getRoutePoints(run.positions);
    return FlutterMap(
      mapController: controller,
      options: boundPoints.length >= 2
          ? MapOptions(
              initialCameraFit: CameraFit.coordinates(
                coordinates: boundPoints,
                maxZoom: 14,
                padding: EdgeInsets.all(120),
              ),
            )
          : MapOptions(initialCenter: run.positions.first.getLatLng()),
      children: [
        ref.watch(mapProvider),
        LiveRouteOverlay(),
        RichAttributionWidget(
          showFlutterMapAttribution: false,
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              textStyle: TextStyle(
                fontSize: 20,
                color: Theme.of(context).highlightColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
