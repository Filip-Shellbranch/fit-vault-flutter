import 'package:fit_vault_flutter/core/utils/second_ticker_provider.dart';
import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
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

    return Column(
      children: [
        Text("Active duration"),
        Text(formatDurationMinutesSeconds(run.calculateDuration())),
      ],
    );
  }
}
