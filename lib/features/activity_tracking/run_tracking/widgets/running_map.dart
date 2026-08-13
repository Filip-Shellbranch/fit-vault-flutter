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
  final MapController? controller;
  final bool showCurrentPosition;
  final bool interactable;
  const RunningMap({
    super.key,
    this.controller,
    this.showCurrentPosition = false,
    this.interactable = true,
  });

  List<LatLng> _getRoutePoints(List<RunPoint> runPoints) {
    return runPoints.map((point) => point.getLatLng()).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Run? run = ref.watch(displayedRunProvider);
    if (run == null) {
      return Center(child: Text("Begin the run to view the map."));
    }
    if (run.positions.isEmpty) {
      return Center(child: Text("The run does not contain any points."));
    }

    List<LatLng> boundPoints = _getRoutePoints(run.positions);
    InteractionOptions interactionOptions = InteractionOptions(
      flags: interactable ? InteractiveFlag.all : InteractiveFlag.none,
    );

    return FlutterMap(
      mapController: controller,
      options: boundPoints.isEmpty
          ? MapOptions(interactionOptions: interactionOptions)
          : boundPoints.length == 1
          ? MapOptions(
              initialCenter: run.positions.first.getLatLng(),
              interactionOptions: interactionOptions,
            )
          : MapOptions(
              initialCameraFit: CameraFit.coordinates(
                coordinates: boundPoints,
                maxZoom: 17,
                padding: EdgeInsets.all(90),
              ),
              interactionOptions: interactionOptions,
            ),
      children: [
        ref.watch(mapProvider),
        LiveRouteOverlay(showCurrentPosition: showCurrentPosition),
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
