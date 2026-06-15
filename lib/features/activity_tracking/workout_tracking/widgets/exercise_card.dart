import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/providers/current_workout_provider.dart';
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
  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.exerciseIndex,
  });

  final Exercise exercise;
  final int exerciseIndex;

  @override
  ConsumerState<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends ConsumerState<ExerciseCard> {
  bool isLocked = false;
  void toggleLock() {
    setState(() {
      isLocked = !isLocked;
    });
  }

  @override
  Widget build(BuildContext context) {
    void updateSet(int setIndex, int newReps, double newWeight) {
      widget.exercise.updateSetAt(setIndex, newWeight, newReps);
      ref
          .watch(currentWorkoutProvider.notifier)
          .updateExercise(widget.exerciseIndex, widget.exercise);
    }

    void addSet() {
      int newReps = 10;
      double newWeight = 0;
      if (widget.exercise.sets.isNotEmpty) {
        newReps = widget.exercise.sets.last.reps;
        newWeight = widget.exercise.sets.last.weight;
      }
      widget.exercise.addSet(newWeight, newReps);
      ref
          .watch(currentWorkoutProvider.notifier)
          .updateExercise(widget.exerciseIndex, widget.exercise);
    }

    void removeSet(int setIndex) {
      widget.exercise.removeSetAt(setIndex);
      ref
          .watch(currentWorkoutProvider.notifier)
          .updateExercise(widget.exerciseIndex, widget.exercise);
    }

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
                      IconButton(
                        onPressed: toggleLock,
                        icon: Icon(isLocked ? Icons.lock : Icons.lock_open),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditExercisePage(
                                exerciseIndex: widget.exerciseIndex,
                                exercise: widget.exercise,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
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
