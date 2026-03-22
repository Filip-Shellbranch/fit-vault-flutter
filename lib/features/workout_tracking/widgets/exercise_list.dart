import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/exercise_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExerciseList extends ConsumerWidget {
  const ExerciseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Workout workout = ref.watch(currentWorkoutProvider);
    final exercises = workout.exercises;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListView.builder(
            itemCount: exercises.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              Exercise exercise = exercises.elementAt(i);
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ExerciseCard(exercise: exercise, index: i),
              );
            },
          ),
        ],
      ),
    );
  }
}
