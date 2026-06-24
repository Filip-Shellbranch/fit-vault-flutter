import 'package:fit_vault_flutter/core/widgets/confirm_dialog.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/classes/workout_notifier_base.dart';
import 'package:fit_vault_flutter/features/activity_tracking/view_activities/data/providers/edited_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/activity_tracking/core/providers/current_workout_provider.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/views/edit_exercise_page.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/add_set_button.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/set_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef UpdateSetCallback =
    void Function(int setIndex, int newReps, double newWeight);
typedef AddSetCallback = void Function();
typedef RemoveSetCallback = void Function(int setIndex);

class ExerciseCard extends ConsumerStatefulWidget {
  final bool isCurrentWorkout;
  final Exercise exercise;
  final int exerciseIndex;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.exerciseIndex,
    required this.isCurrentWorkout,
  });

  @override
  ConsumerState<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends ConsumerState<ExerciseCard> {
  late bool isLocked;
  late WorkoutNotifierBase workoutProvider;

  @override
  void initState() {
    super.initState();
    isLocked = !widget.isCurrentWorkout;
  }

  void toggleLock() {
    setState(() {
      isLocked = !isLocked;
    });
  }

  void deleteExercise() {
    workoutProvider.deleteExercise(widget.exerciseIndex);
  }

  void updateSet(int setIndex, int newReps, double newWeight) {
    widget.exercise.updateSetAt(setIndex, newWeight, newReps);
    workoutProvider.updateExercise(widget.exerciseIndex, widget.exercise);
  }

  void addSet() {
    int newReps = 10;
    double newWeight = 0;
    if (widget.exercise.sets.isNotEmpty) {
      newReps = widget.exercise.sets.last.reps;
      newWeight = widget.exercise.sets.last.weight;
    }
    widget.exercise.addSet(newWeight, newReps);
    workoutProvider.updateExercise(widget.exerciseIndex, widget.exercise);
  }

  void removeSet(int setIndex) {
    widget.exercise.removeSetAt(setIndex);
    workoutProvider.updateExercise(widget.exerciseIndex, widget.exercise);
  }

  @override
  Widget build(BuildContext context) {
    workoutProvider = widget.isCurrentWorkout
        ? ref.read(currentWorkoutProvider.notifier)
        : ref.read(editedWorkoutProvider.notifier);
    widget.isCurrentWorkout
        ? ref.watch(currentWorkoutProvider)
        : ref.watch(editedWorkoutProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Container(
            color: Colors.white.withAlpha(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
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
                        (widget.exerciseIndex + 1).toString(),
                      ),
                      Text(
                        widget.exercise.name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      !isLocked
                          ? IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmDialog(
                                      onConfirmFunc: deleteExercise,
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.delete),
                            )
                          : Container(),
                      !isLocked
                          ? IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditExercisePage(
                                      exerciseIndex: widget.exerciseIndex,
                                      exercise: widget.exercise,
                                      isCurrentWorkout: widget.isCurrentWorkout,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                            )
                          : Container(),
                      IconButton(
                        onPressed: toggleLock,
                        icon: Icon(isLocked ? Icons.lock : Icons.lock_open),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ...widget.exercise.sets.asMap().entries.map((entry) {
            int index = entry.key;
            ExerciseSet set = entry.value;
            return SetCard(
              index: index,
              set: set,
              updateSetFunc: updateSet,
              removeSetFunc: removeSet,
              isBodyWeight: widget.exercise.exerciseType!.isBodyWeight,
              isLocked: isLocked,
            );
          }),
          isLocked ? Container() : AddSetButton(addSetFunc: addSet),
        ],
      ),
    );
  }
}
