import 'package:fit_vault_flutter/features/workout_tracking/views/edit_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExerciseButton extends ConsumerWidget {
  const AddExerciseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditExercisePage()),
        );
      },
      backgroundColor: Theme.of(context).highlightColor,
      splashColor: Colors.black.withAlpha(50),
      foregroundColor: Colors.white,
      icon: ImageIcon(AssetImage("assets/icons/icons8-gym-100.png")),
      label: Text("Add Exercise", style: TextStyle(fontSize: 20)),
    );
  }
}
