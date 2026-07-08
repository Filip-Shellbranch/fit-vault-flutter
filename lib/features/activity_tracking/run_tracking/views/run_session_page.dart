import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/geolocation_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/location_permission_widget.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/running_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunSessionPage extends ConsumerWidget {
  const RunSessionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(geoLocationRepositoryProvider);
    if (repo.permission != LocationRequestResult.granted) {
      return LocationPermissionWidget(repo.permission);
    }

    late Run run;
    Run? loadedValue = ref.watch(currentRunProvider).value;
    if (loadedValue == null) {
      return Text("Error no current run.");
    }
    run = loadedValue;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [Text("Run ${run.startTime.toString()}"), RunningMap()],
      ),
    );
  }
}
