import 'package:fit_vault_flutter/features/workout_tracking/data/providers/current_activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartWorkoutButton extends StatelessWidget {
  const StartWorkoutButton({super.key});

  final SnackBar infoMessage = const SnackBar(
    content: Text("Workout tracking has not yet been implemented."),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return FloatingActionButton.extended(
          onPressed: () {
            ref.read(currentActivityProvider.notifier).startWorkout();
          },
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          icon: ImageIcon(AssetImage("assets/icons/icons8-gym-100.png")),
          label: SizedBox(
            width: 200,
            child: Text("Start workout", style: TextStyle(fontSize: 26)),
          ),
        );
      },
    );
  }
}
