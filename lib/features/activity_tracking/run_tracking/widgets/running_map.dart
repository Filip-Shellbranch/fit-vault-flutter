import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
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
    bool isLoaded = ref.watch(
      currentRunProvider.select(
        (asyncRun) => asyncRun.hasValue && asyncRun.value!.positions.isNotEmpty,
      ),
    );
    if (!isLoaded) {
      return Center(child: CircularProgressIndicator());
    }
    Run run = ref.read(currentRunProvider).value!;
    List<LatLng> boundPoints = _getRoutePoints(run.positions);
    return FlutterMap(
      mapController: controller,
      options: boundPoints.length >= 2
          ? MapOptions(
              initialCameraFit: CameraFit.coordinates(
                coordinates: boundPoints,
                padding: EdgeInsets.all(120),
              ),
            )
          : MapOptions(initialCenter: run.positions.first.getLatLng()),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.fit_vault.fit_vault_flutter',
        ),
        LiveRouteOverlay(),
        RichAttributionWidget(
          showFlutterMapAttribution: false,
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              // onTap: () =>
              // launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
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
