import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/location_permission_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/run_tracking_service_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/gps_strength_widget.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/location_permission_widget.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/run_control_menu.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/active_run_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunControlPage extends ConsumerWidget {
  const RunControlPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(runTrackingServiceProvider);
    final permission = ref.watch(locationPermissionProvider);
    return permission.when(
      error: (Object o, StackTrace _) {
        return Text("Error getting permission");
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
      data: (permission) {
        if (permission != LocationRequestResult.granted) {
          return LocationPermissionWidget(permission);
        }
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              RunInfoWidget(),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GpsStrengthWidget(),
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(bottom: 200),
                child: RunControlMenu(),
              ),
            ],
          ),
        );
      },
    );
  }
}
