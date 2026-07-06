import 'package:fit_vault_flutter/features/activity_tracking/core/repositories/activity_controller.dart';
import 'package:fit_vault_flutter/features/activity_tracking/workout_tracking/views/create_workout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartWorkoutButton extends ConsumerWidget {
  const StartWorkoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await ActivityController(ref).startWorkout();
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateWorkoutPage()),
          );
        }
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
  }
}
