import 'package:fit_vault_flutter/features/workout_tracking/data/classes/workout.dart';
import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_activity_provider.dart';
import 'package:fit_vault_flutter/features/workout_tracking/widgets/finish_workout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditWorkoutPage extends StatelessWidget {
  const EditWorkoutPage({super.key, required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("Go back to home screen"),
          ),
          floatingActionButton: FinishWorkoutButton(),
          body: Column(children: [Center(child: Text("hej"))]),
        );
      },
    );
  }
}
