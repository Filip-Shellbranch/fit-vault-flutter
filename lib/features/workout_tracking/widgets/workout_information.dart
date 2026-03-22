import 'package:fit_vault_flutter/core/utils/second_ticker_provider.dart';
import 'package:fit_vault_flutter/core/utils/time_formatting.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicWorkoutInformation extends ConsumerWidget {
  const BasicWorkoutInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Workout workout = ref.watch(currentWorkoutProvider);
    ref.watch(secondTickerProvider);
    final duration = DateTime.now().difference(workout.startTime);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Theme.of(context).highlightColor),
              ),
            ),
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                  "Workout Start: \n${format24h(workout.startTime)}",
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Theme.of(context).highlightColor),
              ),
            ),
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                  "Workout Duration: \n${formatDurationMinutesSeconds(duration)}",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
