import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run_point.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/running_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class RunningMap extends ConsumerWidget {
  final Run run;
  final MapController controller;
  const RunningMap({super.key, required this.controller, required this.run});

  Marker _createMarker(RunPoint point) {
    return Marker(
      point: point.getLatLng(),
      child: RunningMarker(icon: Icons.run_circle_outlined),
    );
  }

  List<LatLng> _getRoutePoints(List<RunPoint> runPoints) {
    return runPoints.map((point) => point.getLatLng()).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Marker> markers = run.positions
        .map((point) => _createMarker(point))
        .toList();
    List<LatLng> boundPoints = _getRoutePoints(run.positions);
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        initialCenter: markers.first.point,
        initialCameraFit: CameraFit.coordinates(
          coordinates: boundPoints,
          padding: EdgeInsets.all(120),
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.example.fit_vault_flutter',
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: boundPoints,
              color: Theme.of(context).highlightColor,
              strokeWidth: 8.0,
              strokeCap: StrokeCap.round,
              strokeJoin: StrokeJoin.round,
            ),
          ],
        ),
        MarkerLayer(markers: markers),
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
