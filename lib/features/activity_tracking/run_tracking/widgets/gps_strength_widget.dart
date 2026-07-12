import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/gps_strength_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GpsStrengthWidget extends ConsumerWidget {
  const GpsStrengthWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strengthAsync = ref.watch(gpsStrengthProvider);
    return strengthAsync.when(
      data: (strength) {
        return Text(
          "Accuracy: ${strength.accuracy.toStringAsFixed(5)} meters",
          style: TextStyle(
            color: strength.strength == GpsSignalStrength.strong
                ? Colors.green
                : strength.strength == GpsSignalStrength.medium
                ? Colors.amber
                : Colors.red,
          ),
        );
      },
      error: (e, trace) {
        return Text(e.toString());
      },
      loading: () {
        return Text("Loading");
      },
    );
  }
}
