import 'package:fit_vault_flutter/features/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExerciseButton extends ConsumerWidget {
  const AddExerciseButton({super.key});

  void createNewExercise(WidgetRef ref) {
    Exercise newExercise = Exercise("Ny exercise!");
    ref.read(currentWorkoutProvider.notifier).addExercise(newExercise);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () {
        createNewExercise(ref);
      },
      backgroundColor: Theme.of(context).highlightColor,
      splashColor: Colors.black.withAlpha(50),
      foregroundColor: Colors.white,
      icon: ImageIcon(AssetImage("assets/icons/icons8-gym-100.png")),
      label: Text("Add Exercise", style: TextStyle(fontSize: 20)),
    );
  }
}
