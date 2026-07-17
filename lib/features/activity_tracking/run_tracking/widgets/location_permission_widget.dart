import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:flutter/material.dart';

class LocationPermissionWidget extends StatelessWidget {
  final LocationRequestResult permission;
  const LocationPermissionWidget(this.permission, {super.key});

  String getInfoText() {
    switch (permission) {
      case LocationRequestResult.notRequested:
        return "Not yet requested.";
      case LocationRequestResult.serviceDisabled:
        return "Enable the location services to track running activities.";
      default:
        return "You need to enable location permissions track running activities.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          getInfoText(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
