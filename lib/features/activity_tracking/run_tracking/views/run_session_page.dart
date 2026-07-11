import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/run.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/location_permission_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/run_tracking_service_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/repositories/geolocation_repository.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/location_permission_widget.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/run_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunSessionPage extends ConsumerWidget {
  const RunSessionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(runTrackingServiceProvider);
    final permission = ref.watch(locationPermissionProviderProvider);
    return permission.when(
      error: (Object o, StackTrace _) {
        return Text("Error getting permission");
      },
      loading: () {
        return CircularProgressIndicator();
      },
      data: (permission) {
        if (permission != LocationRequestResult.granted) {
          return LocationPermissionWidget(permission);
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
            children: [
              RunInfoWidget(),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (run.isActive()) {
                              ref.read(currentRunProvider.notifier).pauseRun();
                            } else {
                              ref.read(currentRunProvider.notifier).resumeRun();
                            }
                          },
                          child: Icon(
                            run.isActive() ? Icons.pause : Icons.play_arrow,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            await ref
                                .read(currentRunProvider.notifier)
                                .stopRun();
                            if (context.mounted) {
                              Navigator.popUntil(
                                context,
                                ModalRoute.withName("/"),
                              );
                            }
                          },
                          child: Icon(
                            Icons.stop,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
