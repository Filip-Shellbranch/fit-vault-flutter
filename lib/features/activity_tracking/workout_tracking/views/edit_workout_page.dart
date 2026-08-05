import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/edited_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/add_exercise_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/exercise_list.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/finalize_workout/finish_workout_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/workout_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditWorkoutButton extends StatelessWidget {
  final VoidCallback callback;
  const EditWorkoutButton({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        alignment: Alignment.center,
        child: Text(
          "Start editing",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class EditWorkoutPage extends ConsumerStatefulWidget {
  final bool isCurrentWorkout = false;
  const EditWorkoutPage({super.key});

  @override
  ConsumerState<EditWorkoutPage> createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends ConsumerState<EditWorkoutPage> {
  void unlockWorkout() {
    setState(() {
      isUnlocked = true;
    });
  }

  bool isUnlocked = false;
  @override
  Widget build(BuildContext context) {
    late Workout workout;
    workout = ref.watch(editedWorkoutProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Back"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: isUnlocked
                ? FinishWorkoutButton(isCurrent: widget.isCurrentWorkout)
                : EditWorkoutButton(callback: unlockWorkout),
          ),
        ],
      ),
      floatingActionButton: isUnlocked
          ? AddExerciseButton(isCurrentWorkout: false)
          : SizedBox(),
      body: Column(
        children: [
          BasicWorkoutInformation(workout: workout),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ExerciseList(
                    workout: workout,
                    isCurrentWorkout: widget.isCurrentWorkout,
                    isEditing: isUnlocked,
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
