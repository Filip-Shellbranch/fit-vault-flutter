import 'package:fit_vault_flutter/features/workout_tracking/data/repositories/activity_controller.dart';
import 'package:fit_vault_flutter/features/workout_tracking/views/edit_workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartWorkoutButton extends StatelessWidget {
  const StartWorkoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return FloatingActionButton.extended(
          onPressed: () {
            ActivityController(ref).startWorkout();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditWorkoutPage()),
            );
          },
          heroTag: null,
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
