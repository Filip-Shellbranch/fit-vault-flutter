import 'package:fit_vault_flutter/core/utils/second_ticker_provider.dart';
import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_run_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunStatWidget extends StatelessWidget {
  final String title;
  final String value;
  final String? unit;
  const RunStatWidget(this.title, this.value, {super.key, this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(fontSize: 20)),
              Text(
                unit != null ? " ($unit)" : "",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Text(value, style: TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RunStatWidget(
          "Duration",
          formatDurationMinutesSeconds(run.calculateDuration()),
        ),
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
                run.calculatePace().asMinsPerKm(),
                unit: "min/km",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
