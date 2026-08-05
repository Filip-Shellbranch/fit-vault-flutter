import 'package:fit_vault_flutter/core/utils/second_ticker_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/classes/pace.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/data/providers/current_pace_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/run_tracking/widgets/run_stat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunInfoWidget extends ConsumerWidget {
  const RunInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final run = ref.watch(currentRunProvider).value;
    if (run == null) {
      return Text("Error: No run found");
    }
    ref.watch(secondTickerProvider);
    ref.watch(
      currentRunProvider.select((asyncVal) => asyncVal.asData?.value?.pausedAt),
    );
    Pace currentPace = ref.watch(currentPaceProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RunStatWidget("Duration", run.formatDuration()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: RunStatWidget(
                "Distance",
                run.formatDistance(),
                unit: "km",
              ),
            ),
            Expanded(
              child: RunStatWidget(
                "Avg Pace",
                run.formatPace(),
                unit: "min/km",
              ),
            ),
          ],
        ),
        RunStatWidget(
          "Current Pace",
          currentPace.asMinsPerKm(),
          unit: "min/km",
        ),
      ],
    );
  }
}
