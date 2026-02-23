import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/workout_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void onClick(WidgetRef ref) async {
    final workoutRepo = ref.watch(workoutRepositoryProvider);

    Exercise newExercise1 = Exercise("Bench");
    newExercise1.sets.add(ExerciseSet(10, 20));

    Workout newWorkout1 = Workout(DateTime.now());
    newWorkout1.exercises.add(newExercise1);
    debugPrint(newWorkout1.exercises.toString());

    await workoutRepo.saveWorkout(newWorkout1);
    debugPrint("save!");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            return Center(
              child: TextButton(
                onPressed: () {
                  onClick(ref);
                },
                child: Text("hej"),
              ),
            );
          },
        ),
      ],
    );
  }
}
