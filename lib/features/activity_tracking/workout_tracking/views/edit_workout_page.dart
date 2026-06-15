import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/add_exercise_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/exercise_list.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/finalize_workout/finish_workout_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/workout_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditWorkoutPage extends ConsumerWidget {
  final Workout? workoutToEdit;
  const EditWorkoutPage({super.key, this.workoutToEdit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Workout workout = workoutToEdit ?? ref.read(currentWorkoutProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Back"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FinishWorkoutButton(),
          ),
        ],
      ),
      floatingActionButton: AddExerciseButton(),
      body: Column(
        children: [
          BasicWorkoutInformation(workout: workout),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [ExerciseList(), SizedBox(height: 200)]),
            ),
          ),
        ],
      ),
    );
  }
}
