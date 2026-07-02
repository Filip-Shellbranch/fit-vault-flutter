import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/add_exercise_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/exercise_list.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/finalize_workout/finish_workout_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/workout_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateWorkoutPage extends ConsumerWidget {
  final bool isCurrentWorkout = true;
  const CreateWorkoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late Workout workout;
    Workout? loadedValue = ref.watch(currentWorkoutProvider).value;
    if (loadedValue == null) {
      return Text("Error no current workout.");
    }
    workout = loadedValue;
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
                    isEditing: true,
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
