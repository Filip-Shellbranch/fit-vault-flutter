import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_workout_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicWorkoutInformation extends ConsumerWidget {
  const BasicWorkoutInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Workout workout = ref.watch(currentWorkoutProvider);
    final duration = DateTime.now().difference(workout.startTime);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
            child: Text(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
              "Workout Start: \n${workout.startTime.hour}:${workout.startTime.minute}",
            ),
          ),
          SizedBox(
            height: 50,
            child: Text(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
              "Workout Duration: \n${duration.inSeconds} s",
            ),
          ),
        ],
      ),
    );
    //return const Text("Display workout information here!");
  }
}
