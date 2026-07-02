import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/exercise.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/widgets/exercise_card.dart';
import 'package:flutter/material.dart';

class ExerciseList extends StatelessWidget {
  final Workout workout;
  final bool isEditing;
  final bool isCurrentWorkout;
  const ExerciseList({
    super.key,
    required this.workout,
    required this.isEditing,
    required this.isCurrentWorkout,
  });

  @override
  Widget build(BuildContext context) {
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
                child: ExerciseCard(
                  exercise: exercise,
                  exerciseIndex: i,
                  isCurrentWorkout: isCurrentWorkout,
                  isEditing: isEditing,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
