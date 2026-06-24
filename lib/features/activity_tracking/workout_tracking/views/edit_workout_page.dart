import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/edited_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/add_exercise_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/exercise_list.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/finalize_workout/finish_workout_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/workout_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditWorkoutPage extends ConsumerWidget {
  final bool isCurrentWorkout;
  const EditWorkoutPage({super.key, this.isCurrentWorkout = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late Workout workout;
    if (isCurrentWorkout) {
      Workout? loadedValue = ref.watch(currentWorkoutProvider).value;
      if (loadedValue == null) {
        return Text("Error no current workout.");
      }
      workout = loadedValue;
    } else {
      workout = ref.watch(editedWorkoutProvider);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Back"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FinishWorkoutButton(isCurrentWorkout: isCurrentWorkout),
          ),
        ],
      ),
      floatingActionButton: AddExerciseButton(
        isCurrentWorkout: isCurrentWorkout,
      ),
      body: Column(
        children: [
          BasicWorkoutInformation(workout: workout),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ExerciseList(
                    workout: workout,
                    isCurrentWorkout: isCurrentWorkout,
                  ),
                  SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
