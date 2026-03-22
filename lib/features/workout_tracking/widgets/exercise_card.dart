import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/add_set_button.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/set_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef UpdateSetCallback =
    void Function(int setIndex, int newReps, double newWeight);
typedef AddSetCallback = void Function();

class ExerciseCard extends ConsumerWidget {
  const ExerciseCard({super.key, required this.exercise, required this.index});

  final Exercise exercise;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void updateSet(int setIndex, int newReps, double newWeight) {
      debugPrint(setIndex.toString());
      exercise.updateSetAt(setIndex, newWeight, newReps);
      ref
          .watch(currentWorkoutProvider.notifier)
          .updateExercise(index, exercise);
    }

    void addSet() {
      int newReps = 10;
      double newWeight = 0;
      if (exercise.sets.isNotEmpty) {
        newReps = exercise.sets.last.reps;
        newWeight = exercise.sets.last.weight;
      }
      exercise.addSet(newWeight, newReps);
      ref
          .watch(currentWorkoutProvider.notifier)
          .updateExercise(index, exercise);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                    (index + 1).toString(),
                  ),
                  Text(exercise.name, style: TextStyle(fontSize: 20)),
                ],
              ),
              IconButton(
                onPressed: () {
                  // TODO: Implement edit function
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          ...exercise.sets.asMap().entries.map((entry) {
            int index = entry.key;
            ExerciseSet set = entry.value;
            return SetCard(index: index, set: set, updateSetFunc: updateSet);
          }),
          AddSetButton(addSetFunc: addSet),
        ],
      ),
    );
  }
}
