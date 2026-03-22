import 'package:fit_vault_flutter/features/workout_tracking/widgets/add_exercise_button.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/exercise_list.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/finish_workout_button.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/workout_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditWorkoutPage extends ConsumerWidget {
  const EditWorkoutPage({super.key});

  void onFinishWorkout() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          BasicWorkoutInformation(),
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
